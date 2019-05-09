package br.com.cropMonitoring.Model;

import java.util.List;

public class User {


	private long id;
	
	private String login;
	private String password;
	private String name;
	
	
	
	private List<Station> stations;



	public User(long id, String login, String password, String name) {
		super();
		this.id = id;
		this.login = login;
		this.password = password;
		this.name = name;
	}

	

	public User(long id, String login, String password, String name, List<Station> stations) {
		super();
		this.id = id;
		this.login = login;
		this.password = password;
		this.name = name;
		this.stations = stations;
	}



	public long getId() {
		return id;
	}



	public void setId(long id) {
		this.id = id;
	}



	public String getLogin() {
		return login;
	}



	public void setLogin(String login) {
		this.login = login;
	}



	public String getPassword() {
		return password;
	}



	public void setPassword(String password) {
		this.password = password;
	}



	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}



	public List<Station> getStations() {
		return stations;
	}



	public void setStations(List<Station> stations) {
		this.stations = stations;
	}
	
	
	
}
