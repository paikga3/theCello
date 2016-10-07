package the.cello.reservation.service;
import java.util.Map;

import the.cello.common.CommonStructure;
import the.cello.reservation.entity.Reservation;

public interface RevService extends CommonStructure<Reservation>{
	public Map<String, Object> getPrice(Map<String, Object> params);
	public Map<String, Object> itemToMap(Reservation item);
	public void sendSms(Reservation item);
	public void sendConfirmMessage(String msg);
}
