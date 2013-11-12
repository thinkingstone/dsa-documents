package de.thinkingstone.dsa.tierdokumenta5;

import org.junit.Test;

import de.thinkingstone.dsa.test.BaseTransformation;

public class TransformationTest extends BaseTransformation {

	@Test
	public void testGeweiht() throws Exception {
		testTransformation("daten.geweiht.xml");
	}
}
