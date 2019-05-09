package br.com.cropMonitoring.mock;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import br.com.cropMonitoring.Model.*;

public class Repository {

	List<User> users;
	List<Station> stations;
	List<Sensor> sensors;
	List<SensorRead> sensorReads;
	List<Recommendation> recommendations;
	List<Records> records;
	HashMap<Integer, List<SensorRead>> coletasMap;
	List<Coleta> coletas;
	
	public Repository() {
		users = new ArrayList<>();
		stations = new ArrayList<>();
		sensors =  new ArrayList<>();
		sensorReads = new ArrayList<>();
		recommendations = new ArrayList<>();
		records = new ArrayList<>(); 
		coletas = new ArrayList<>();
	}
	
	public Repository getRepository() {
		
		User admin = new User(1, "admin", "pass", "Administrador");
		users.add(admin);
		
		Sensor umidadeAr = new Sensor(1, "DHT", "Sensor umidade ambiente");
		Sensor umidadeSolo = new Sensor(1, "Hidromero", "Sensor umidade solo");
		Sensor temperaturaAr = new Sensor(1, "DHT", "Sensor temperatura ambiente");
		Sensor temperaturaSolo = new Sensor(1, "Hidromero", "Sensor temperatura solo");
		Sensor precipitacao = new Sensor(1, "DHT", "Sensor de precipitação");
		
		sensors.add(umidadeAr);
		sensors.add(umidadeSolo);
		sensors.add(temperaturaAr);
		sensors.add(temperaturaSolo);
		sensors.add(precipitacao);
		
		Station s1 = new Station(1, "Sitio Pereiro", "Russas-CE", users, sensors);
		Station s2 = new Station(1, "Sitio Tamboril", "Ouricuri-PE", users, sensors);
		
		s1.setUltVer("29/04/2019 - 09:37");
		s2.setUltVer("12/04/2019 - 14:05");
		
		stations.add(s1);
		stations.add(s2);
		
		
		
		Random e = new Random();
		sensorReads.clear();
		int day = e.nextInt(30) +1 ;
		SensorRead l1 = new SensorRead(1, 75, new Date(2019,4, day), umidadeAr, s1);
		SensorRead l2 = new SensorRead(1, 60, new Date(2019,4, day), umidadeSolo, s1);
		SensorRead l3 = new SensorRead(1, 27, new Date(2019,4, day), temperaturaAr, s1);
		SensorRead l4 = new SensorRead(1, 23, new Date(2019,4, day), temperaturaSolo, s1);
		SensorRead l5 = new SensorRead(1, 1, new Date(2019,4, day), precipitacao, s1);
		/*for(int i = 0; i < 5; i++) {
			sensorReads.clear();
			int day = e.nextInt(30) +1 ;
			SensorRead l1 = new SensorRead(1, 75, new Date(2019,4, day), umidadeAr, s1);
			SensorRead l2 = new SensorRead(1, 60, new Date(2019,4, day), umidadeSolo, s1);
			SensorRead l3 = new SensorRead(1, 27, new Date(2019,4, day), temperaturaAr, s1);
			SensorRead l4 = new SensorRead(1, 23, new Date(2019,4, day), temperaturaSolo, s1);
			SensorRead l5 = new SensorRead(1, 1, new Date(2019,4, day), precipitacao, s1);
			sensorReads.add(l1);
			sensorReads.add(l2);
			sensorReads.add(l3);
			sensorReads.add(l4);
			sensorReads.add(l5);
			//coletas.put(1, sensorReads);
			
		}
		
		for(int i = 0; i < 5; i++) {
			sensorReads.clear();
			int day = e.nextInt(30) +1 ;
			SensorRead l1 = new SensorRead(1, 75, new Date(2019,4, day), umidadeAr, s1);
			SensorRead l2 = new SensorRead(1, 60, new Date(2019,4, day), umidadeSolo, s1);
			SensorRead l3 = new SensorRead(1, 27, new Date(2019,4, day), temperaturaAr, s1);
			SensorRead l4 = new SensorRead(1, 23, new Date(2019,4, day), temperaturaSolo, s1);
			SensorRead l5 = new SensorRead(1, 1, new Date(2019,4, day), precipitacao, s1);
			sensorReads.add(l1);
			sensorReads.add(l2);
			sensorReads.add(l3);
			sensorReads.add(l4);
			sensorReads.add(l5);
			//coletas.put(2, sensorReads);
			
		}*/
		
		
		coletas.add(new Coleta(1, "05/04/2019 - 15:11:23"));
		coletas.add(new Coleta(2, "06/04/2019 - 13:57:49"));
		coletas.add(new Coleta(3, "09/04/2019 - 11:28:51"));
		coletas.add(new Coleta(4, "14/04/2019 - 18:17:47"));
		coletas.add(new Coleta(5, "24/04/2019 - 16:28:16"));
		
		
		
		return this;
	}

	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}

	public List<Station> getStations() {
		return stations;
	}

	public void setStations(List<Station> stations) {
		this.stations = stations;
	}

	public List<Sensor> getSensors() {
		return sensors;
	}

	public void setSensors(List<Sensor> sensors) {
		this.sensors = sensors;
	}

	public List<SensorRead> getSensorReads() {
		return sensorReads;
	}

	public void setSensorReads(List<SensorRead> sensorReads) {
		this.sensorReads = sensorReads;
	}

	public List<Recommendation> getRecommendations() {
		return recommendations;
	}

	public void setRecommendations(List<Recommendation> recommendations) {
		this.recommendations = recommendations;
	}

	public List<Records> getRecords() {
		return records;
	}

	public void setRecords(List<Records> records) {
		this.records = records;
	}

	public HashMap<Integer, List<SensorRead>> getColetasMap() {
		return coletasMap;
	}

	public void setColetasMap(HashMap<Integer, List<SensorRead>> coletasMap) {
		this.coletasMap = coletasMap;
	}

	public List<Coleta> getColetas() {
		return coletas;
	}

	public void setColetas(List<Coleta> coletas) {
		this.coletas = coletas;
	}


	
	
	
}
