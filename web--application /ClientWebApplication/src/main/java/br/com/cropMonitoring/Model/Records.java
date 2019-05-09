package br.com.cropMonitoring.Model;

public class Records {

	private int id;
	
	private SensorRead sensorRead;
	
	private Recommendation recomendation;
	
	

	public Records(int id, SensorRead sensorRead, Recommendation recomendation) {
		super();
		this.id = id;
		this.sensorRead = sensorRead;
		this.recomendation = recomendation;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public SensorRead getSensorRead() {
		return sensorRead;
	}

	public void setSensorRead(SensorRead sensorRead) {
		this.sensorRead = sensorRead;
	}

	public Recommendation getRecomendation() {
		return recomendation;
	}

	public void setRecomendation(Recommendation recomendation) {
		this.recomendation = recomendation;
	}
	
	
	
}
