package the.cello.reservation;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

import org.junit.Test;

public class SmsParsingTest {
	@Test
	public void textParsing() throws IOException {
		File file = new File("c:/hi/msg.txt");
		BufferedReader reader = new BufferedReader(new FileReader(file));
		StringBuilder sb = new StringBuilder();
		String line = "";
		while((line = reader.readLine()) != null) {
			sb.append(line);
		}
		System.out.println(sb.toString());
		
	}
}
