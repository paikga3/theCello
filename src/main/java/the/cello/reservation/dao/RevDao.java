package the.cello.reservation.dao;

import java.util.List;

import the.cello.common.CommonStructure;
import the.cello.reservation.entity.Reservation;

public interface RevDao extends CommonStructure<Reservation> {
	public List<Reservation> notPaidUsers(String name);
}
