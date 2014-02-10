package de.thinkingstone.dsa.test;

import java.io.InputStream;
import java.io.OutputStream;
import java.util.Map;
import java.util.Map.Entry;

import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

public class TransformationUtils {

	public static void transform(final InputStream inputInputStream,
			final InputStream xsltInputStream,
			final OutputStream resultOutputStream,
			final Map<String, Object> parameterMap) {
		final javax.xml.transform.Source xmlSource = new StreamSource(
				inputInputStream);
		final javax.xml.transform.Source xsltSource = new StreamSource(
				xsltInputStream);
		final TransformerFactory transFact = TransformerFactory.newInstance();
		try {
			final Transformer trans = transFact.newTransformer(xsltSource);
			for (final Entry<String, Object> entry : parameterMap.entrySet()) {
				trans.setParameter(entry.getKey(), entry.getValue());
			}
			trans.transform(xmlSource, new StreamResult(resultOutputStream));
		} catch (final Exception e) {
			throw new IllegalStateException(e);
		}
	}

}
