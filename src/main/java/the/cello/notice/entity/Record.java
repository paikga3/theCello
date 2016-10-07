package the.cello.notice.entity;

import java.time.LocalDateTime;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="notice")
public class Record {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;
	
	private String title;
	private String content;
	private int readCount;
	private LocalDateTime regDate;
	private String writer;
	
	public long getId() {
		return id;
	}
	
	public String getTitle() {
		return title;
	}
	public String getContent() {
		return content;
	}
	public int getReadCount() {
		return readCount;
	}
	public LocalDateTime getRegDate() {
		return regDate;
	}
	public String getWriter() {
		return writer;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}
	public void setRegDate(LocalDateTime regDate) {
		this.regDate = regDate;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	
	public String getFormattingRegDate() {
		String dateFormat = regDate.toString();
		int cutPlace = dateFormat.indexOf("T");
		return dateFormat.substring(0, cutPlace);
	}

	
	
}
