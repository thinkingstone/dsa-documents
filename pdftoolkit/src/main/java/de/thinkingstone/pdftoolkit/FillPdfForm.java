package de.thinkingstone.pdftoolkit;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.MessageFormat;

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
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfStamper;
import com.itextpdf.text.pdf.XfdfReader;

public class FillPdfForm {

	private static final String CMD_APPL_NAME = "fillpdfform";

	/**
	 * Main method.
	 * 
	 * @param args
	 * @throws Exception
	 */
	public static void main(final String[] args) throws Exception {

		@SuppressWarnings("static-access")
		final Option flatten = OptionBuilder
				.withDescription("flatten the pdf form").withLongOpt("flatten")
				.create("f");

		@SuppressWarnings("static-access")
		final Option help = OptionBuilder.withDescription("print this message")
				.withLongOpt("help").create("h");

		@SuppressWarnings("static-access")
		final Option template = OptionBuilder
				.withArgName("file")
				.hasArg()
				.withDescription(
						"path to the template pdf form file to be filled")
				.isRequired().withLongOpt("template").create("t");

		@SuppressWarnings("static-access")
		final Option xfdf = OptionBuilder.withArgName("file").hasArg()
				.withDescription("path to the xfdf form field file")
				.isRequired().withLongOpt("xfdf").create("x");

		@SuppressWarnings("static-access")
		final Option result = OptionBuilder.withArgName("file").hasArg()
				.withDescription("path to the result pdf file").isRequired()
				.withLongOpt("result").create("r");

		final Options options = new Options();
		options.addOption(help);
		options.addOption(flatten);
		options.addOption(template);
		options.addOption(xfdf);
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
			callFillPdfFormXfdf(//
					line.getOptionValue(template.getOpt()),
					line.getOptionValue(xfdf.getOpt()),
					line.getOptionValue(result.getOpt()),
					line.hasOption(flatten.getOpt()));

		} catch (final ParseException exp) {
			System.err.println("Unexpected Option: " + exp.getMessage());
			printHelp(options);
		}

	}

	private static void callFillPdfFormXfdf(
			final String template,
			final String xfdf,
			final String result,
			final boolean flatten) {

		InputStream templateInputStream = null;
		InputStream xfdfInputStream = null;
		OutputStream resultOutputStream = null;
		try {
			final FillPdfForm filler = new FillPdfForm();

			final String msg = MessageFormat.format(
					"Filling pdf {0} with {1}. Result: {2}. flatten: {3}",
					template,
					xfdf,
					result,
					flatten);

			System.out.println(msg);

			templateInputStream = new FileInputStream(new File(template));
			xfdfInputStream = new FileInputStream(new File(xfdf));
			resultOutputStream = new FileOutputStream(new File(result), false);

			filler.fillPdfFormXfdf(
					templateInputStream,
					xfdfInputStream,
					resultOutputStream,
					flatten);

		} catch (final Exception e) {
			throw new IllegalStateException(e);
		} finally {
			IOUtils.closeQuietly(templateInputStream);
			IOUtils.closeQuietly(xfdfInputStream);
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
	 * Fill a pdf form with an XFDF document.
	 * 
	 * @param sourcePdfInputStream
	 *            input pdf
	 * @param xfdfInputStream
	 *            xfdf
	 * @param destinationPdfOutputStream
	 *            output pdf
	 * @param formflattening
	 *            true: flatten the form
	 */
	public void fillPdfFormXfdf(
			final InputStream sourcePdfInputStream,
			final InputStream xfdfInputStream,
			final OutputStream destinationPdfOutputStream,
			final boolean formflattening) {
		try {
			/* Create a reader that interprets the request's input stream */
			final XfdfReader xfdf = new XfdfReader(xfdfInputStream);

			/* We create a reader with the InputStream */
			final PdfReader reader = new PdfReader(sourcePdfInputStream, null);

			/* Now we create the PDF */
			final PdfStamper stamper = new PdfStamper(
					reader,
					destinationPdfOutputStream);

			/* flatten the form fields? */
			stamper.setFormFlattening(formflattening);

			/* We alter the fields of the existing PDF */
			final AcroFields fields = stamper.getAcroFields();
			fields.setFields(xfdf);

			/* close the stamper */
			stamper.close();

			/* We write the PDF bytes to the OutputStream */
			destinationPdfOutputStream.flush();

		} catch (final DocumentException e) {
			throw new IllegalStateException(e);
		} catch (final IOException e) {
			throw new IllegalStateException(e);
		}
	}

}
