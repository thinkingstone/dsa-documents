package de.thinkingstone.pdftoolkit;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Collections;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
import com.itextpdf.text.pdf.PdfReader;

public class ExtractXfdf {

	private static final String CMD_APPL_NAME = "extraxtxfdf";

	/**
	 * Main method.
	 * 
	 * @param args
	 * @throws Exception
	 */
	public static void main(final String[] args) throws Exception {

		@SuppressWarnings("static-access")
		final Option fillFieldName = OptionBuilder
				.withDescription("fill the field value with the field name")
				.withLongOpt("fillfieldname").create("f");

		@SuppressWarnings("static-access")
		final Option help = OptionBuilder.withDescription("print this message")
				.withLongOpt("help").create("h");

		@SuppressWarnings("static-access")
		final Option source = OptionBuilder.withArgName("file").hasArg()
				.withDescription("path to the source pdf file").isRequired()
				.withLongOpt("source").create("s");

		@SuppressWarnings("static-access")
		final Option result = OptionBuilder.withArgName("file").hasArg()
				.withDescription("path to the result xfdf file").isRequired()
				.withLongOpt("result").create("r");

		final Options options = new Options();
		options.addOption(help);
		options.addOption(fillFieldName);
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
			callExtractXfdf(//
					line.getOptionValue(source.getOpt()),
					line.getOptionValue(result.getOpt()),
					line.hasOption(fillFieldName.getOpt()));

		} catch (final ParseException exp) {
			System.err.println("Unexpected Option: " + exp.getMessage());
			printHelp(options);
		}

	}

	private static void callExtractXfdf(
			final String source,
			final String result,
			final boolean fillFieldName) {

		InputStream sourceInputStream = null;
		OutputStream resultOutputStream = null;
		try {

			sourceInputStream = new FileInputStream(new File(source));
			resultOutputStream = new FileOutputStream(new File(result), false);

			final ExtractXfdf extractXfdf = new ExtractXfdf();
			extractXfdf.generateXfdf(
					sourceInputStream,
					resultOutputStream,
					fillFieldName);
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
		final String header = "Fills a pdf template form with the xfdf file and writes to the result file.";
		final String footer = "";
		formatter.printHelp(cmdApplName, header, options, footer, autoUsage);
	}

	/**
	 * Manipulates a PDF file src with the file dest as result
	 * 
	 * @param sourceInputStream
	 *            the original PDF
	 * @param resultOutputStream
	 *            the resulting XFDF file
	 * @throws IOException
	 * @throws DocumentException
	 */
	public void generateXfdf(
			final InputStream sourceInputStream,
			final OutputStream resultOutputStream,
			final boolean fillWithFieldName) throws IOException,
			DocumentException {
		final PdfReader reader = new PdfReader(sourceInputStream);
		final AcroFields acroFields = reader.getAcroFields();
		final Map<String, Item> fieldsMap = acroFields.getFields();

		final StringBuilder sb = new StringBuilder();
		sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
		sb.append("\n");
		sb.append("<xfdf xml:space=\"preserve\" xmlns=\"http://ns.adobe.com/xfdf/\">");
		sb.append("\n");
		sb.append("<f href=\"Document.pdf\"/>");
		sb.append("\n");
		sb.append("<ids original=\"7A0631678ED475F0898815F0A818CFA1\" modified=\"BEF7724317B311718E8675B677EF9B4E\"/>");
		sb.append("\n");
		sb.append("<fields>");
		sb.append("\n");

		final Set<String> fieldNames = fieldsMap.keySet();

		final List<String> fieldNamesList = new LinkedList<String>();
		fieldNamesList.addAll(fieldNames);
		Collections.sort(fieldNamesList);

		for (final String name : fieldNamesList) {

			String value = acroFields.getField(name);

			if (fillWithFieldName) {
				value = name;
			}

			sb.append("<field name=\"");
			sb.append(name);
			sb.append("\">");
			sb.append("<value>");
			sb.append(value);
			sb.append("</value>");
			sb.append("</field>");
			sb.append("\n");

		}
		sb.append("</fields>");
		sb.append("\n");
		sb.append("</xfdf>");
		sb.append("\n");

		IOUtils.write(sb.toString(), resultOutputStream, "UTF-8");

		reader.close();
	}

}
