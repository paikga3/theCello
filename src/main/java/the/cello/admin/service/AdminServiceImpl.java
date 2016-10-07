package the.cello.admin.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import the.cello.reservation.dao.RevDao;
import the.cello.reservation.entity.Reservation;

@Service
@Transactional
public class AdminServiceImpl implements AdminService {

	@Autowired
	RevDao revDao;
	
	@Override
	public void saveOrUpdate(Reservation item) {
		revDao.saveOrUpdate(item);
		
	}

	@Override
	public void delete(long id) {
		revDao.delete(id);
	}

	@Override
	public List<Reservation> getList() {
		return revDao.getList();
	}

	@Override
	public Reservation getItem(long id) {
		return revDao.getItem(id);
	}
	
	@Override
	public String getString(LocalDateTime time) {
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분", Locale.KOREA);
		return time.format(dateTimeFormatter);
	}
	
	@Override
	public int revCleanExpired() {
		int count = 0;
		List<Reservation> list = getList();
		LocalDateTime now = LocalDateTime.now();
		for(Reservation item : list) {
			if(item.isExpired()) {
				continue;
			}
			
			if(now.isAfter(item.getRevFromTime())) {
				item.setExpired(true);
				count++;
				revDao.saveOrUpdate(item);
			}
		}
		return count;
	}

}
