package de.thinkingstone.dsa.test;

import static org.junit.Assert.fail;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

public class BaseTransformation {

	public BaseTransformation() {
		super();
	}

	protected String getExpectedPath() {
		return "./src/test/heldensoftware/";
	}

	protected String getTesttargetPath() {
		return "./target/main/heldensoftware/";
	}

	protected String getXslPath() {
		return "./src/main/heldensoftware/";
	}

	protected void testCopy(final String filename) {
		testCopy(getExpectedPath() + filename, getTesttargetPath() + filename);
	}

	protected void testCopy(final String expectedfilename,
			final String outputfilename) {
		try {
			IOUtils.copy(outputfilename, expectedfilename);
		} catch (final IOException e) {
			fail(e.getMessage());
		}
	}

	protected void testTransformation(final String inputFilename) {
		final Map<String, Object> parameterMap = new HashMap<String, Object>();
		testTransformation(inputFilename, getXslPath() + "helden.xfdf.xsl",
				getTesttargetPath() + inputFilename, getExpectedPath()
						+ inputFilename, parameterMap);
	}

	protected void testTransformation(final String inputFilename,
			final String expectedFilename,
			final Map<String, Object> parameterMap) {
		testTransformation(inputFilename, getXslPath() + "helden.xfdf.xsl",
				getTesttargetPath() + expectedFilename, getExpectedPath()
						+ expectedFilename, parameterMap);
	}

	protected void testTransformation(final String inputFilename,
			final String xsltFilename, final String outputfilename,
			final String expectedFilename,
			final Map<String, Object> parameterMap) {

		try {
			final InputStream inputFileInputStream = Thread.currentThread()
					.getContextClassLoader().getResourceAsStream(inputFilename);

			final InputStream xsltInputStream = IOUtils
					.createInputStream(xsltFilename);

			final OutputStream resultOutputStream = IOUtils
					.createOutputStream(outputfilename);

			try {
				TransformationUtils.transform(inputFileInputStream,
						xsltInputStream, resultOutputStream, parameterMap);
			} finally {
				inputFileInputStream.close();
				xsltInputStream.close();
				resultOutputStream.close();
			}

			Asserts.assertEqualsContent(expectedFilename, outputfilename);

		} catch (final FileNotFoundException e) {
			fail(e.getMessage());
		} catch (final IOException e) {
			fail(e.getMessage());
		}

	}

}