package the.cello.reservation;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.hamcrest.core.Is.is;
import static org.junit.Assert.assertThat;


public class JsonByJackson {
	
	
	@Test
	public void compareToTest() {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/dd/yyyy", Locale.KOREA);
		LocalDateTime time1 = LocalDateTime.from(LocalDate.parse("09/23/2016", formatter).atStartOfDay());
		LocalDateTime time2 = LocalDateTime.from(LocalDate.parse("09/24/2016", formatter).atStartOfDay());
		
		time1 = time1.plusHours(17L);
		
		
		LocalDate date1= LocalDate.of(time1.getYear(), time1.getMonth(), time1.getDayOfMonth());
		LocalDate date2 = LocalDate.of(time2.getYear(), time2.getMonth(), time2.getDayOfMonth());
		assertThat(time1.isAfter(time2), is(false));
	}
	
	
}
