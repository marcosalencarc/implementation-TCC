package br.com.cropMonitoring.Model;

import java.util.List;

public class Station {

	
	private int id;
	
	private String descriptionStation;
	
	private String location;
	
	private List<User> users;
	
	private List<Sensor> sensors;
	
	private String ultVer;

	
	
	public Station(int id, String descriptionStation, String location) {
		super();
		this.id = id;
		this.descriptionStation = descriptionStation;
		this.location = location;
	}
	
	

	public Station(int id, String descriptionStation, String location, List<User> users, List<Sensor> sensors) {
		super();
		this.id = id;
		this.descriptionStation = descriptionStation;
		this.location = location;
		this.users = users;
		this.sensors = sensors;
	}



	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDescriptionStation() {
		return descriptionStation;
	}

	public void setDescriptionStation(String descriptionStation) {
		this.descriptionStation = descriptionStation;
	}

	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}

	public List<Sensor> getSensors() {
		return sensors;
	}

	public void setSensors(List<Sensor> sensors) {
		this.sensors = sensors;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}



	public String getUltVer() {
		return ultVer;
	}



	public void setUltVer(String ultVer) {
		this.ultVer = ultVer;
	}
	
	
	
	
}
