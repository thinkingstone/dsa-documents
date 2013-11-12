package de.thinkingstone.dsa.tierdokumenta5;

import org.junit.Test;

import de.thinkingstone.dsa.test.BaseTransformation;

public class CopyTransformation extends BaseTransformation {

	@Test
	public void testGeweiht() throws Exception {
		testCopy("daten.geweiht.xml");
	}
}
