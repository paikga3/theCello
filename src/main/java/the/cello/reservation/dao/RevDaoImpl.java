package the.cello.reservation.dao;

import java.util.List;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import the.cello.reservation.entity.Reservation;

@Repository
public class RevDaoImpl implements RevDao {
	
	@Autowired
	private SessionFactory session;
	
	@Override
	public void saveOrUpdate(Reservation item) {
		session.getCurrentSession().saveOrUpdate(item);
		session.getCurrentSession().flush();
		
	}

	@Override
	public void delete(long id) {
		session.getCurrentSession().delete(getItem(id));
	}

	@Override
	public List<Reservation> getList() {
		return session.getCurrentSession()
				.createQuery("from Reservation r order by r.id desc", Reservation.class)
				.getResultList();
	}

	@Override
	public Reservation getItem(long id) {
		return session.getCurrentSession().get(Reservation.class, id);
	}

	@Override
	public List<Reservation> notPaidUsers(String name) {
		return session.getCurrentSession()
				.createQuery("from Reservation r where r.isPaid = false and r.revName=:name", Reservation.class)
				.setString("name", name)
				.getResultList();
	}
	
}
