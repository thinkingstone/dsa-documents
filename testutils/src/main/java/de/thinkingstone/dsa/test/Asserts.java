package de.thinkingstone.dsa.test;

import static org.junit.Assert.assertEquals;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;

public class Asserts {

	public static void assertEqualsContent(String expectedfilename,
			String outputfilename) throws UnsupportedEncodingException,
			IOException {
		InputStream expectedIS = IOUtils.createInputStream(expectedfilename);
		String expected =  IOUtils.readString(expectedIS, "UTF-8");

		InputStream outputIS =  IOUtils.createInputStream(outputfilename);
		String output =  IOUtils.readString(outputIS, "UTF-8");

		assertEquals(expected, output);
	}

}
