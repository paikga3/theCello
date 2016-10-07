package the.cello.reservation.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import the.cello.reservation.entity.Token;

@Repository
@Transactional
public class RevTokenDaoImpl implements RevTokenDao{

	@Autowired
	private SessionFactory session;
	
	@Override
	public void saveOrUpdate(Token item) {
		session.getCurrentSession().saveOrUpdate(item);
		session.getCurrentSession().flush();
	}

	@Override
	public void delete(long id) {
		session.getCurrentSession().delete(getItem(id));
		
	}

	@Override
	public List<Token> getList() {
		return session.getCurrentSession()
				.createQuery("from Token t order by t.id desc", Token.class)
				.getResultList();
	}

	@Override
	public Token getItem(long id) {
		return session.getCurrentSession().get(Token.class, id);
	}

}
