package de.thinkingstone.dsa.heldendokumentoriginal;

import org.junit.Test;

import de.thinkingstone.dsa.test.BaseTransformation;

public class TransformationTest extends BaseTransformation {

	@Test
	public void testGeweiht() throws Exception {
		testTransformation("daten.geweiht.xml");
	}

	@Test
	public void testKampf() throws Exception {
		testTransformation("daten.kampf.xml");
	}

	@Test
	public void testMagie() throws Exception {
		testTransformation("daten.magie.xml");
	}
}
