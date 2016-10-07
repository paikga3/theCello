package the.cello.notice.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import the.cello.notice.dao.NoticeDao;
import the.cello.notice.dto.NoticeDto;
import the.cello.notice.entity.Record;

@Service
@Transactional
public class NoticeServiceImpl implements NoticeService {
	
	int maxPage = 10;
	
	@Autowired
	private NoticeDao noticeDao;
	
	@Override
	public void saveOrUpdate(Record record) {
		record.setWriter("운영자");
		record.setRegDate(LocalDateTime.now());
		noticeDao.saveOrUpdate(record);
	}

	@Override
	public void delete(long[] removeList) {
		for(int i=0; i<removeList.length; i++) {
			noticeDao.delete(removeList[i]);
		}
	}

	@Override
	public Record getItem(long id) {
		return noticeDao.getItem(id);
	}

	@Override
	public Record getSimpleItem(long id) {
		return noticeDao.getSimpleItem(id);
	}
	
	@Override
	public NoticeDto getList(int currentPage) {
		int startPage = currentPage + 1 - (currentPage % maxPage == 0 ? maxPage : currentPage % maxPage);
		int endPage = startPage + (10 - 1);
		int firstLimit = (startPage - 1) * 10; 
		
		List<Record> loadedList = noticeDao.getRecords(firstLimit, 101);
		NoticeDto noticeDto = new NoticeDto();
		if(currentPage < 11) {
			noticeDto.setPrev(false);
		} else {
			noticeDto.setPrev(true);
		}
		
		if(loadedList.size() == 101) {
			noticeDto.setNext(true);
		} else {
			noticeDto.setNext(false);
		}
		
		int topRecordOrder = (currentPage - 1) * 10;
		List<Record> noticeList = noticeDao.getRecords(topRecordOrder, 10);
		
		noticeDto.setNoticeList(noticeList);
		int loadedListSize = loadedList.size();
		int size = loadedListSize == 101 ? 100 : loadedListSize;
		
		int loadingPage = size % 10 == 0 ? size / 10 : size / 10 + 1;
		
		if(loadingPage%10 != 0) {
			endPage = endPage - (10 - (loadingPage % 10));
		} else if(loadedListSize == 0) {
			endPage = startPage;
		}
		noticeDto.setCurrentPage(currentPage);
		noticeDto.setStartPage(startPage);
		noticeDto.setEndPage(endPage);
		
		return noticeDto;
	}


	@Override
	public void delete(long id) {
		noticeDao.delete(id);
		
	}

	@Override
	public List<Record> getList() {
		// TODO Auto-generated method stub
		return null;
	}
}
