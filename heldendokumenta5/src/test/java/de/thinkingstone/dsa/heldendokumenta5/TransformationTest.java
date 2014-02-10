package de.thinkingstone.dsa.heldendokumenta5;

import java.util.HashMap;
import java.util.Map;

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

	@Test
	public void testMagie_Metatalente_false() throws Exception {
		final Map<String, Object> parameterMap = new HashMap<String, Object>();
		parameterMap.put("includeMetatalente", "'false'");
		testTransformation("daten.magie.xml", "daten.magie.metatalente.xml",
				parameterMap);
	}
}
