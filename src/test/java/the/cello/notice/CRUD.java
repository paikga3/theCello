package the.cello.notice;

import static org.hamcrest.core.Is.is;
import static org.junit.Assert.assertThat;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import the.cello.notice.entity.Record;
import the.cello.notice.service.NoticeService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration
@Rollback(value = false)
public class CRUD {
	@Autowired
	NoticeService service;

	
	public void isnull() {
		
	}
	
	@Test
	public void saveOrUpdate() {
		for(int i=0; i<200; i++) {
			Record record = new Record();
			record.setTitle(i + "번째 글입니다.");
			record.setContent(i + "번째 글내용입니다.");
			service.saveOrUpdate(record);
		}
	}

	
	public void cal() {
		int currentPage = 31;
		int maxPage = 10;
		int startPage = currentPage + 1 - (currentPage % maxPage == 0 ? maxPage : currentPage % maxPage);
		
		assertThat(startPage, is(31));
	}

	
}
