package the.cello.notice.dto;

import java.util.List;

import the.cello.notice.entity.Record;

public class NoticeDto {
	private List<Record> noticeList;
	private int currentPage;
	
	private int startPage;
	private int endPage;
	
	private boolean isNext;
	private boolean isPrev;
	public List<Record> getNoticeList() {
		return noticeList;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	
	public void setNoticeList(List<Record> noticeList) {
		this.noticeList = noticeList;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	
	public boolean isNext() {
		return isNext;
	}
	public boolean isPrev() {
		return isPrev;
	}
	public void setNext(boolean isNext) {
		this.isNext = isNext;
	}
	public void setPrev(boolean isPrev) {
		this.isPrev = isPrev;
	}
	public int getStartPage() {
		return startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
}
