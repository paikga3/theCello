package the.cello.notice.service;

import the.cello.common.CommonStructure;
import the.cello.notice.dto.NoticeDto;
import the.cello.notice.entity.Record;

public interface NoticeService extends CommonStructure<Record>{
	
	public Record getSimpleItem(long id);
	public void delete(long[] removeList);
	public NoticeDto getList(int currentPage);
}
