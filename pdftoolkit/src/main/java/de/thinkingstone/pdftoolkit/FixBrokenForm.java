package de.thinkingstone.pdftoolkit;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Map;

import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.GnuParser;
import org.apache.commons.cli.HelpFormatter;
import org.apache.commons.cli.Option;
import org.apache.commons.cli.OptionBuilder;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.ParseException;
import org.apache.commons.io.IOUtils;

import com.itextpdf.text.DocumentException;
import com.itextpdf.text.pdf.AcroFields;
import com.itextpdf.text.pdf.AcroFields.Item;
import com.itextpdf.text.pdf.PdfArray;
import com.itextpdf.text.pdf.PdfDictionary;
import com.itextpdf.text.pdf.PdfName;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfStamper;

public class FixBrokenForm {

	private static final String CMD_APPL_NAME = "fixbrokenform";

	/**
	 * Main method.
	 * 
	 * @param args
	 * @throws Exception
	 */
	public static void main(final String[] args) throws Exception {

		@SuppressWarnings("static-access")
		final Option help = OptionBuilder.withDescription("print this message")
				.withLongOpt("help").create("h");

		@SuppressWarnings("static-access")
		final Option source = OptionBuilder.withArgName("file").hasArg()
				.withDescription("path to the source pdf form file")
				.isRequired().withLongOpt("source").create("s");

		@SuppressWarnings("static-access")
		final Option result = OptionBuilder.withArgName("file").hasArg()
				.withDescription("path to the result pdf file").isRequired()
				.withLongOpt("result").create("r");

		final Options options = new Options();
		options.addOption(help);
		options.addOption(source);
		options.addOption(result);

		/* create the parser */
		final CommandLineParser parser = new GnuParser();
		try {
			/* parse the command line arguments */
			final CommandLine line = parser.parse(options, args);

			/* help */
			if (line.hasOption(help.getOpt())) {
				printHelp(options);
			}

			/* process */
			callFixBrokenForm(//
					line.getOptionValue(source.getOpt()),
					line.getOptionValue(result.getOpt()));

		} catch (final ParseException exp) {
			System.err.println("Unexpected Option: " + exp.getMessage());
			printHelp(options);
		}

	}

	private static void callFixBrokenForm(
			final String source,
			final String result) {

		InputStream sourceInputStream = null;
		OutputStream resultOutputStream = null;
		try {
			sourceInputStream = new FileInputStream(new File(source));
			resultOutputStream = new FileOutputStream(new File(result));

			final FixBrokenForm fixBrokenForm = new FixBrokenForm();
			fixBrokenForm.manipulateForm(sourceInputStream, resultOutputStream);
		} catch (final Exception e) {
			throw new IllegalStateException(e);
		} finally {
			IOUtils.closeQuietly(sourceInputStream);
			IOUtils.closeQuietly(resultOutputStream);
		}

	}

	private static void printHelp(final Options options) {
		/* automatically generate the help statement */
		final HelpFormatter formatter = new HelpFormatter();
		final boolean autoUsage = true;
		final String cmdApplName = CMD_APPL_NAME;
		final String header = "Fixes the broken pdf form that was created by scribus.";
		final String footer = "";
		formatter.printHelp(cmdApplName, header, options, footer, autoUsage);
	}

	/**
	 * Manipulates a PDF file src with the file dest as result
	 * 
	 * @param sourceInputStream
	 *            the original PDF
	 * @param resultOutputStream
	 *            the resulting PDF
	 * @throws IOException
	 * @throws DocumentException
	 */
	public void manipulateForm(
			final InputStream sourceInputStream,
			final OutputStream resultOutputStream) throws IOException,
			DocumentException {
		final PdfReader reader = new PdfReader(sourceInputStream);
		final PdfDictionary root = reader.getCatalog();
		final PdfDictionary form = root.getAsDict(PdfName.ACROFORM);
		final PdfArray fields = form.getAsArray(PdfName.FIELDS);

		/* regenerate dictionary */
		PdfDictionary page;
		PdfArray annots;
		for (int i = 1; i <= reader.getNumberOfPages(); i++) {
			page = reader.getPageN(i);
			annots = page.getAsArray(PdfName.ANNOTS);
			for (int j = 0; j < annots.size(); j++) {
				fields.add(annots.getAsIndirectObject(j));
			}
		}

		final PdfStamper stamper = new PdfStamper(reader, resultOutputStream);

		/* regenerate form field appearance */
		final AcroFields acroFields = stamper.getAcroFields();
		final Map<String, Item> fieldsMap = acroFields.getFields();
		for (final Map.Entry<String, Item> entry : fieldsMap.entrySet()) {
			final String name = entry.getKey();
			acroFields.regenerateField(name);
		}

		stamper.close();
		reader.close();
	}

}
