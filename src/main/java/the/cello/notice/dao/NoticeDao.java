package the.cello.notice.dao;

import java.util.List;

import the.cello.common.CommonStructure;
import the.cello.notice.entity.Record;

public interface NoticeDao extends CommonStructure<Record> {
	
	public Record getSimpleItem(long id);
	public List<Record> getRecords(int firstLimit, int maxLoad);
}
