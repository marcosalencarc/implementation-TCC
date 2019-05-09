package br.com.cropMonitoring.Model;

import java.util.Date;

public class SensorRead {

	private long id;
	
	private double value;
	private Date data;
	
	private Sensor sensor;
	
	private Station station;
	
	

	public SensorRead(long id, double value, Date data) {
		super();
		this.id = id;
		this.value = value;
		this.data = data;
	}
	
	

	public SensorRead(long id, double value, Date data, Sensor sensor, Station station) {
		super();
		this.id = id;
		this.value = value;
		this.data = data;
		this.sensor = sensor;
		this.station = station;
	}



	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public double getValue() {
		return value;
	}

	public void setValue(double value) {
		this.value = value;
	}

	public Date getData() {
		return data;
	}

	public void setData(Date data) {
		this.data = data;
	}

	public Sensor getSensor() {
		return sensor;
	}

	public void setSensor(Sensor sensor) {
		this.sensor = sensor;
	}

	public Station getStation() {
		return station;
	}

	public void setStation(Station station) {
		this.station = station;
	}
	
	
	
}
