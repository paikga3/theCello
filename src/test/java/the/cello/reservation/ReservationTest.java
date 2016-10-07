package the.cello.reservation;

import java.time.LocalDateTime;
import java.util.Iterator;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import the.cello.reservation.dao.RevDao;
import the.cello.reservation.entity.Reservation;
import the.cello.reservation.service.RevService;

import static org.junit.Assert.*;
import static org.hamcrest.core.Is.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration
public class ReservationTest {
	
	@Autowired
	RevDao revDao;
	
	@Autowired
	RevService service;
	
	@Transactional
	@Test
	public void daoTest() {
		List<Reservation> list = notPaidUsers("백은주", 30000);
		assertThat(list.size(), is(1));
	}
	
	private List<Reservation> notPaidUsers(String name, int price) {
		List<Reservation> notPaidUsers = revDao.notPaidUsers(name);
		if(notPaidUsers.isEmpty()) {
			return notPaidUsers;
		} else {
			Iterator<Reservation> usersIterator = notPaidUsers.iterator();
			while(usersIterator.hasNext()) {
				Reservation user = usersIterator.next();
				LocalDateTime now = LocalDateTime.now();
				
				if(now.isAfter(user.getRevToTime()) 
						|| user.isPaid() 
						|| !user.getRevName().equals(name) 
						|| user.getRevPrice() != price) {
					usersIterator.remove();
				}
			}
			return notPaidUsers;
		}
	}
}
