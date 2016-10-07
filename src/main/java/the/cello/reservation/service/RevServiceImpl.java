package the.cello.reservation.service;

import java.io.IOException;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import the.cello.reservation.dao.RevDao;
import the.cello.reservation.dao.RevTokenDao;
import the.cello.reservation.entity.Reservation;
import the.cello.reservation.entity.Token;

import org.json.simple.JSONObject;

@Transactional
@Service
public class RevServiceImpl implements RevService {
	
	@Autowired
	private RevDao revDao;
	@Autowired
	private RevTokenDao tokenDao;
	private final String serverAPIKey = "AIzaSyCX3jQ6IZVNlKKKmavpXgeNGIdefI4_tDA";
	//private final String serverAPIKey = "AIzaSyDzEUEitNDdoP90aRdAsHK6II9eE7vaLds"; 
	@Override
	public Map<String, Object> getPrice(Map<String, Object> params) {
		Map<String, Object> result = new HashMap<String, Object>();
		Reservation rev = new Reservation();
		rev.setId(System.currentTimeMillis());
		rev.setPaid(false);
		rev.setExpired(false);
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/dd/yyyy", Locale.KOREA);
		LocalDateTime fromLocalDateTime = LocalDateTime.from(LocalDate.parse((String)params.get("revFromDate"), formatter).atStartOfDay());
		fromLocalDateTime = fromLocalDateTime.plusHours(Long.parseLong((String)params.get("revFromHour")));
		fromLocalDateTime = fromLocalDateTime.plusMinutes(Long.parseLong((String)params.get("revFromMin")));
		LocalDateTime toLocalDateTime = LocalDateTime.from(LocalDate.parse((String)params.get("revToDate"), formatter).atStartOfDay());
		toLocalDateTime = toLocalDateTime.plusHours(Long.parseLong((String)params.get("revToHour")));
		toLocalDateTime = toLocalDateTime.plusMinutes(Long.parseLong((String)params.get("revToMin")));
		
		rev.setRevFromTime(fromLocalDateTime);
		rev.setRevToTime(toLocalDateTime );
		rev.setRevName((String)params.get("revName"));
		rev.setRevNum(Integer.parseInt((String)params.get("revNum")));
		rev.setRevPhone((String)params.get("revPhone"));
		rev.setRevRoomType((String)params.get("revRoomType"));
		
		int price = 0;

		LocalDate compareFromDate = LocalDate.of(fromLocalDateTime.getYear(), fromLocalDateTime.getMonth(), fromLocalDateTime.getDayOfMonth());
		LocalDate compareToDate = LocalDate.of(toLocalDateTime.getYear(), toLocalDateTime.getMonth(), toLocalDateTime.getDayOfMonth());
		
		
		int holidayCount = 0;
		int stayDays = 0;
		
		result.put("early", 0);
		result.put("lazy", 0);
		
		if(compareToDate.compareTo(compareFromDate) > 0) {
			
			if(fromLocalDateTime.getHour() < 9) {
				compareFromDate = compareFromDate.minusDays(1L);
			}
			
			if(fromLocalDateTime.getHour() >= 9 && fromLocalDateTime.getHour() <= 12) {
				price += 20000;
				result.put("early", 20000);
			} else if(fromLocalDateTime.getHour() > 12 && fromLocalDateTime.getHour() <= 18) {
				price += 10000;
				result.put("early", 10000);
			}
			
			if(toLocalDateTime.getHour() > 13 && toLocalDateTime.getHour() <=16) {
				price += 10000;
				result.put("lazy", 10000);
			} else if(toLocalDateTime.getHour() > 16) {
				price += 20000;
				result.put("lazy", 20000);
			}
			
		} else if(compareToDate.compareTo(compareFromDate) < 0) {
			result.put("error", "입실일자가 퇴실일자보다 이후 일 수 없습니다.");
			return result;
		} else {
			stayDays++;
			if(fromLocalDateTime.getHour() < 9) {
				compareFromDate = compareFromDate.minusDays(1L);
			}
			
			if(compareFromDate.getDayOfWeek() == DayOfWeek.FRIDAY ||
					compareFromDate.getDayOfWeek() == DayOfWeek.SATURDAY) {
				holidayCount++;
			}
			
			
			if(fromLocalDateTime.getHour() < 9) {
				compareFromDate = compareFromDate.plusDays(1L);
			}

			double fromTime = fromLocalDateTime.getHour() + (fromLocalDateTime.getMinute() == 0 ? 0 : 0.5);
			double toTime = toLocalDateTime.getHour() + (toLocalDateTime.getMinute() == 0 ? 0 : 0.5);
			
			double betweenTime = toTime - (fromTime + 13);
			if(betweenTime >= 1 && betweenTime <=3 ) {
				price += 10000;
				result.put("lazy", 10000);
			} else if(betweenTime > 3) {
				price += 20000;
				result.put("lazy", 20000);
			}

		}

		while(compareToDate.compareTo(compareFromDate) > 0) {
			
			stayDays++;
			if(compareFromDate.getDayOfWeek() == DayOfWeek.FRIDAY ||
					compareFromDate.getDayOfWeek() == DayOfWeek.SATURDAY) {
				holidayCount++;
			}
			compareFromDate = compareFromDate.plusDays(1L);
		}
		
		
		
		int revNum = rev.getRevNum();
		int addByNum = 0;
		int dayPrice = 0;
		
		System.out.println("stayDays=" + stayDays);
		
		switch(revNum) {
			case 1:
			case 2:
				break;
			case 3:
				addByNum = 5000;
				break;
			case 4:
				addByNum = 10000;
				break;
		}
		
		dayPrice += addByNum;
		
		if(rev.getRevRoomType().equals("general")) {
			dayPrice += 30000;
			price += (dayPrice * stayDays) + (holidayCount * 5000);
			System.out.println("dayPrice=" + dayPrice);
			System.out.println("price=" + price);
		} else {
			dayPrice += 40000;
			price += (dayPrice * stayDays);
		}
		result.put("staydays", stayDays);
		result.put("holiday", holidayCount);
		result.put("num", addByNum * stayDays);
		result.put("price", price);

		rev.setRevEarly((Integer)result.get("early"));
		rev.setRevLazy((Integer)result.get("lazy"));
		rev.setRevStayDays((Integer)result.get("staydays"));
		rev.setRevHoliday((Integer)result.get("holiday"));
		rev.setRevPrice((Integer)result.get("price"));
		
		
		result.put("info", rev);
		return result;
	}

	
	@Override
	public void saveOrUpdate(Reservation item) {
		revDao.saveOrUpdate(item);
	}
	
	@Override
	public void sendSms(Reservation item) {
		List<Token> list = tokenDao.getList();

		Token token = null;
		if (list.size() != 0) {
			token = list.get(0);
		}
		// 문자 메시지 전송에 대한 비즈니스 로직을 구현한다.
		URL url = null;

		StringBuffer buffer = new StringBuffer();
		buffer.append("[인천 계산동 첼로모텔입니다.]\r\n").append("예약번호 : ").append(item.getId()).append("\r\n").append("숙박요금 : ")
				.append(item.getRevPrice()).append("원\r\n").append("▶계좌번호안내◀\r\n").append("국민(223302-04-063864)\r\n예금주: 백종현\r\n")
				.append("상기계좌로 입금하시면 예약이 정상적으로 완료됩니다. ").append("입금이 확인되면 확인문자를 발송해드리고 있습니다. ")
				.append("예약확인은 저희 홈페이지에 예약확인에서 예약번호로 검색이 가능합니다. 좋은하루 되세요 ^^");

		JSONObject totalData = new JSONObject();

		JSONObject data = new JSONObject();
		data.put("number", item.getRevPhone());
		data.put("message", buffer.toString());

		totalData.put(0, data);

		JSONObject univ = new JSONObject();
		univ.put("collapse_key", String.valueOf(Math.random() % 1000));
		univ.put("time_to_live", 3600);
		univ.put("delay_while_idle", false);
		univ.put("to", token.getToken());
		univ.put("data", totalData);

		try {
			url = new URL("https://fcm.googleapis.com/fcm/send");
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", "key=" + serverAPIKey);
			conn.setRequestProperty("Content-Type", "application/json");
			conn.setDoOutput(true);
			conn.setConnectTimeout(20000);
			conn.setReadTimeout(20000);
			conn.connect();
			OutputStreamWriter writer = new OutputStreamWriter(conn.getOutputStream(), "UTF-8");
			writer.write(univ.toJSONString());
			writer.flush();

			System.out.println(conn.getResponseCode());

		} catch (MalformedURLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	

	@Override
	public void delete(long id) {
		revDao.delete(id);
		
	}

	@Override
	public List<Reservation> getList() {
		return revDao.getList();
	}

	@Override
	public Reservation getItem(long id) {
		return revDao.getItem(id);
	}

	
	public String timeToTwoChar(String time) {
		return time.length() == 1 ? "0" + time : time;
	}
	
	
	@Override
	public Map<String, Object> itemToMap(Reservation item) {
		Map<String, Object> map = new HashMap<String, Object>();
		if(item == null) {
			map.put("null", true);
			return map;
		} 
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분", Locale.KOREA);
		
		map.put("revName", item.getRevName());
		map.put("revPhone", item.getRevPhone());
		map.put("revNum", item.getRevNum());
		map.put("revFromTime", item.getRevFromTime().format(dateTimeFormatter));
		map.put("revToTime", item.getRevToTime().format(dateTimeFormatter));
		map.put("revRoomType", item.getRevRoomType().equals("general") ? "일반실" : "특실");
		map.put("revEarly", item.getRevEarly());
		map.put("revLazy", item.getRevLazy());
		map.put("revHoliday", item.getRevHoliday());
		map.put("revStayDays", item.getRevStayDays());
		map.put("revPrice", item.getRevPrice());
		map.put("isPaid", item.isPaid() ? "입금완료" : "입금전");
		
		return map;
	}
	/*
	 * 은행으로부터 입금확인 문자가 왔을 시 무조건 그 메시지를 서버로 보내게 되는데 그 메시지를 파싱하고
	 * 미 입금자의 금액과 이름이 파싱되어진 문자에서의 금액과 이름이 일치하면 해당 예약자에게
	 * 입금확인 문자를 보낼 수 있도록 다시 앱에 데이터를 전달하는 메소드
	 * */
	
	@Override
	public void sendConfirmMessage(String msg) {
		List<Token> list = tokenDao.getList();
		
		Token token = null;
		if(list.size() != 0) {
			token = list.get(0);
		}
		
		URL url = null;
		
		JSONObject totalData = new JSONObject();
		JSONObject data = new JSONObject();
		JSONObject univ = new JSONObject();
		univ.put("collapse_key", String.valueOf(Math.random() % 1000));
		univ.put("time_to_live", 3600);
		univ.put("delay_while_idle", false);
		univ.put("to", token.getToken());
		
		String[] msgArr = null;
		String userName = "";
		String depositMsg = "";
		int depositAmount = 0;
		try {
			msgArr = msg.split("\n");
			// 송금자 이름
			userName = msgArr[2];
			// 입금인지 출금인지
			depositMsg = msgArr[3];
			// 입금금액
			depositAmount = Integer.parseInt(msgArr[4].replace(",", ""));
		} catch (IndexOutOfBoundsException e) {
			System.out.println("IndexOutOfBoundsException");
			return;
		}
		
		System.out.println(depositAmount);
		if(depositMsg.indexOf("입금") != -1) {
			List<Reservation> reves = notPaidUsers(userName, depositAmount);
			
			DateTimeFormatter nowFormatter = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분", Locale.KOREA);
			DateTimeFormatter revFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd E HH:mm", Locale.KOREA);
			LocalDateTime now = LocalDateTime.now();
			StringBuffer buffer = new StringBuffer();
			buffer.append("[인천 계산동 첼로모텔입니다.]\r\n");
			if(reves.size() == 0) {
				System.out.println("맵의 크기가 0입니다.");
				return;
			} else if(reves.size() == 1) {
				Reservation rev = reves.get(0);
				buffer
				.append(now.format(nowFormatter))
				.append("\r\n")
				.append(rev.getRevName())
				.append("님의 입금이 정상적으로 확인되었습니다.\r\n")
				.append("입실일시 : ")
				.append(rev.getRevFromTime().format(revFormatter))
				.append("\r\n")
				.append("퇴실일시 : ")
				.append(rev.getRevToTime().format(revFormatter))
				.append("\r\n")
				.append("예약번호 : ")
				.append(rev.getId())
				.append("\r\n")
				.append("이용해주셔서 감사합니다. 기타 문의사항은 이 번호로 문의주세요. ^^");
				
				
				// 입금완료 처리
				rev.setPaid(true);
				revDao.saveOrUpdate(rev);
				
				data.put("number", rev.getRevPhone());
				data.put("message", buffer.toString());
				
				totalData.put(0, data);
				univ.put("data", totalData);
			} else {
				buffer = new StringBuffer();
				Iterator<Reservation> iterator = reves.iterator();
				int i = 0;
				while(iterator.hasNext()) {
					Reservation rev = iterator.next();
					buffer
					.append("[인천 계산동 첼로모텔입니다.]\r\n")
					.append("동일한 이름과 동일한 숙박요금을 가진 경우가 ")
					.append(reves.size())
					.append("건이라 모두 문자를 보내어 확인하고 있습니다.")
					.append("입금하신 분은 하기 예약번호를 가지고 연락주시면 바로 처리해드리도록 하겠습니다.\r\n")
					.append("예약번호 : ")
					.append(rev.getId());
					
					data.put("number", rev.getRevPhone());
					data.put("message", buffer.toString());
					totalData.put(i++, data);
					buffer = new StringBuffer();
					data = new JSONObject();
				}
				univ.put("data", totalData);
			}
			
			HttpURLConnection conn = null;
			
			try {
				 url = new URL("https://fcm.googleapis.com/fcm/send");
				 conn = (HttpURLConnection)url.openConnection();
				 conn.setRequestMethod("POST");
				 conn.setRequestProperty("Authorization", "key=" + serverAPIKey);
				 conn.setRequestProperty("Content-Type", "application/json");
		         conn.setDoOutput(true);
		         conn.setConnectTimeout(20000);
		         conn.setReadTimeout(20000);
		         conn.connect();
		         OutputStreamWriter writer = new OutputStreamWriter(conn.getOutputStream(), "UTF-8");
				 writer.write(univ.toJSONString());
				 writer.flush();
				 
				 System.out.println(conn.getResponseCode());
				 
			} catch (MalformedURLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				if( conn != null ) {
					conn.disconnect();
				}
			}
		}
	}
	
	private List<Reservation> notPaidUsers(String name, int price) {
		List<Reservation> notPaidUsers = revDao.notPaidUsers(name);
		if(notPaidUsers.isEmpty()) {
			return notPaidUsers;
		} else {
			Iterator<Reservation> usersIterator = notPaidUsers.iterator();
			while(usersIterator.hasNext()) {
				Reservation user = usersIterator.next();
				LocalDateTime now = LocalDateTime.now();
				
				if(now.isAfter(user.getRevToTime()) 
						|| user.isPaid() 
						|| !user.getRevName().equals(name) 
						|| user.getRevPrice() != price) {
					usersIterator.remove();
				}
			}
			return notPaidUsers;
		}
	}

}
