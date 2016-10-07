package the.cello.notice.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import the.cello.notice.entity.Record;

@Repository
public class NoticeDaoImpl implements NoticeDao {
	
	@Autowired
	private SessionFactory session;
	
	@Override
	public void saveOrUpdate(Record record) {
		session.getCurrentSession().saveOrUpdate(record);
		session.getCurrentSession().flush();
	}
	
	@Override
	public void delete(long removeId) {
		Record record = session.getCurrentSession().get(Record.class, removeId);
		session.getCurrentSession().delete(record);
		session.getCurrentSession().flush();
	}

	@Override
	public Record getItem(long id) {
		Record record = session.getCurrentSession().get(Record.class, id);
		int readCount = record.getReadCount();
		record.setReadCount(readCount + 1);
		return record;
	}
	
	@Override
	public Record getSimpleItem(long id) {
		Record record = session.getCurrentSession().get(Record.class, id);
		return record;
	}

	@Override
	public List<Record> getRecords(int firstLimit, int maxLoad) {
		return session.getCurrentSession().createQuery("from Record r order by r.id desc", Record.class)
					.setFirstResult(firstLimit)
					.setMaxResults(maxLoad)
					.getResultList();
	}

	@Override
	public List<Record> getList() {
		// TODO Auto-generated method stub
		return null;
	}

}
