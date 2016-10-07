package the.cello.reservation.entity;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Token {
	
	public Token() {
		
	}
	
	@Id
	private long id;
	private String token;
	
	public void setId(long id) {
		this.id = id;
	}
	
	public long getId() {
		return id;
	}
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
}
