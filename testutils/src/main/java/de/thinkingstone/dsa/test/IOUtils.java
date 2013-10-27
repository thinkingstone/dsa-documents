package de.thinkingstone.dsa.test;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.text.MessageFormat;

public class IOUtils {
	public static void copy(final String fromFilename, final String toFilename)
			throws IOException {
		final File inputFile = new File(fromFilename);
		final File outputFile = new File(toFilename);

		final FileReader in = new FileReader(inputFile);
		final FileWriter out = new FileWriter(outputFile);
		int c;

		while ((c = in.read()) != -1) {
			out.write(c);
		}

		in.close();
		out.close();
	}

	public static InputStream createInputStream(final String filename)
			throws FileNotFoundException {
		InputStream inputFileInputStream = null;
		try {
			inputFileInputStream = new FileInputStream(new File(filename));
		} catch (final Exception e) {
			final String msg = MessageFormat.format(
					"Can not use file {0}.",
					filename);
			throw new IllegalArgumentException(msg, e);
		}
		return inputFileInputStream;
	}

	public static OutputStream createOutputStream(final String filename)
			throws FileNotFoundException {
		final File file = new File(filename);
		if (!file.exists()) {
			try {
				file.getParentFile().mkdirs();
				file.createNewFile();
			} catch (final IOException e) {
				final String msg = MessageFormat.format(
						"Can not use file {0}.",
						filename);
				throw new IllegalArgumentException(msg, e);
			}
		}
		final FileOutputStream outputStream = new FileOutputStream(file);
		return outputStream;
	}

	public static String readString(
			final InputStream inputStream,
			final String encoding) throws UnsupportedEncodingException,
			IOException {
		final char[] buffer = new char[0x10000];
		final StringBuilder out = new StringBuilder();
		final Reader in = new InputStreamReader(inputStream, encoding);
		int read;
		do {
			read = in.read(buffer, 0, buffer.length);
			if (read > 0) {
				out.append(buffer, 0, read);
			}
		} while (read >= 0);
		return out.toString();
	}

}
