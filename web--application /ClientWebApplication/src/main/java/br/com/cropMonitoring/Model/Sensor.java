package br.com.cropMonitoring.Model;

public class Sensor {

	
	private int id;
	
	private String name;
	
	private String descriptionSensnor;

	
	
	public Sensor(int id, String name, String descriptionSensnor) {
		super();
		this.id = id;
		this.name = name;
		this.descriptionSensnor = descriptionSensnor;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescriptionSensnor() {
		return descriptionSensnor;
	}

	public void setDescriptionSensnor(String descriptionSensnor) {
		this.descriptionSensnor = descriptionSensnor;
	}
	
	
	
}
