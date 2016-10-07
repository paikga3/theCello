package the.cello.reservation.entity;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

import org.springframework.format.annotation.DateTimeFormat;


@Entity
public class Reservation {
	public Reservation() {
		
	}
	
	@Id
	private long id;
	@Column(nullable=false)
	private String revName;
	
	@Column(nullable=false)
	private String revPhone;
	
	@Column(nullable=false)
	private int revNum;
	
	@Column(nullable=false)
	@DateTimeFormat(pattern="yyyy년 MM월 dd일 HH시 mm분")
	private LocalDateTime revFromTime;
	
	@Column(nullable=false)
	@DateTimeFormat(pattern="yyyy년 MM월 dd일 HH시 mm분")
	private LocalDateTime revToTime;
	
	@Column(nullable=false)
	private String revRoomType;
	
	@Column(nullable=false)
	private boolean isPaid;
	
	@Column(nullable=false)
	private boolean isExpired;
	
	@Column(nullable=false)
	private int revEarly;
	
	@Column(nullable=false)
	private int revLazy;
	
	@Column(nullable=false)
	private int revHoliday;
	
	@Column(nullable=false)
	private int revStayDays;
	
	@Column(nullable=false)
	private int revPrice;

	public long getId() {
		return id;
	}

	public String getRevName() {
		return revName;
	}

	public String getRevPhone() {
		return revPhone;
	}

	public int getRevNum() {
		return revNum;
	}

	public LocalDateTime getRevFromTime() {
		return revFromTime;
	}

	public LocalDateTime getRevToTime() {
		return revToTime;
	}

	public String getRevRoomType() {
		return revRoomType;
	}

	public boolean isPaid() {
		return isPaid;
	}

	public boolean isExpired() {
		return isExpired;
	}

	public int getRevEarly() {
		return revEarly;
	}

	public int getRevLazy() {
		return revLazy;
	}

	public int getRevHoliday() {
		return revHoliday;
	}

	public int getRevStayDays() {
		return revStayDays;
	}

	public int getRevPrice() {
		return revPrice;
	}

	public void setId(long id) {
		this.id = id;
	}

	public void setRevName(String revName) {
		this.revName = revName;
	}

	public void setRevPhone(String revPhone) {
		this.revPhone = revPhone;
	}

	public void setRevNum(int revNum) {
		this.revNum = revNum;
	}
	@DateTimeFormat(pattern="yyyy년 MM월 dd일 HH시 mm분")
	public void setRevFromTime(LocalDateTime revFromTime) {
		this.revFromTime = revFromTime;
	}
	@DateTimeFormat(pattern="yyyy년 MM월 dd일 HH시 mm분")
	public void setRevToTime(LocalDateTime revToTime) {
		this.revToTime = revToTime;
	}

	public void setRevRoomType(String revRoomType) {
		this.revRoomType = revRoomType;
	}

	public void setPaid(boolean isPaid) {
		this.isPaid = isPaid;
	}

	public void setExpired(boolean isExpired) {
		this.isExpired = isExpired;
	}

	public void setRevEarly(int revEarly) {
		this.revEarly = revEarly;
	}

	public void setRevLazy(int revLazy) {
		this.revLazy = revLazy;
	}

	public void setRevHoliday(int revHoliday) {
		this.revHoliday = revHoliday;
	}

	public void setRevStayDays(int revStayDays) {
		this.revStayDays = revStayDays;
	}

	public void setRevPrice(int revPrice) {
		this.revPrice = revPrice;
	}

	

	
}
