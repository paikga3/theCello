package the.cello.admin.service;

import java.time.LocalDateTime;

import the.cello.common.CommonStructure;
import the.cello.reservation.entity.Reservation;

public interface AdminService extends CommonStructure<Reservation> {
	public String getString(LocalDateTime time);
	public int revCleanExpired();
}
