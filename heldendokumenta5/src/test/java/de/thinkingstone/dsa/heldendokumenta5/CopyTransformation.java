package de.thinkingstone.dsa.heldendokumenta5;

import org.junit.Test;

import de.thinkingstone.dsa.test.BaseTransformation;

public class CopyTransformation extends BaseTransformation {

	@Test
	public void testGeweiht() throws Exception {
		testCopy("daten.geweiht.xml");
	}

	@Test
	public void testKampf() throws Exception {
		testCopy("daten.kampf.xml");
	}

	@Test
	public void testMagie() throws Exception {
		testCopy("daten.magie.xml");
	}

	@Test
	public void testMagie_Metatalente() throws Exception {
		testCopy("daten.magie.metatalente.xml");
	}
}
