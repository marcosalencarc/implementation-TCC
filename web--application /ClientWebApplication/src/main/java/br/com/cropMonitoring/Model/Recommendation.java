package br.com.cropMonitoring.Model;

public class Recommendation {

	private int id;
	private String description;
	
	
	
	public Recommendation(int id, String description) {
		super();
		this.id = id;
		this.description = description;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	
	
}
