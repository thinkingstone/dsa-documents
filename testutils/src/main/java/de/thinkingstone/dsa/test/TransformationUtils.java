package de.thinkingstone.dsa.test;

import java.io.InputStream;
import java.io.OutputStream;

import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

public class TransformationUtils {

	public static void transform(InputStream inputInputStream,
			InputStream xsltInputStream, OutputStream resultOutputStream) {
		javax.xml.transform.Source xmlSource = new StreamSource(
				inputInputStream);
		javax.xml.transform.Source xsltSource = new StreamSource(
				xsltInputStream);
		TransformerFactory transFact = TransformerFactory.newInstance();
		try {
			Transformer trans = transFact.newTransformer(xsltSource);
			trans.transform(xmlSource, new StreamResult(resultOutputStream));
		} catch (Exception e) {
			throw new IllegalStateException(e);
		}
	}

}
