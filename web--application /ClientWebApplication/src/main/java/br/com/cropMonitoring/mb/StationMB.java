package br.com.cropMonitoring.mb;

import javax.faces.bean.ManagedBean;
import javax.faces.view.ViewScoped;

import br.com.cropMonitoring.Model.Coleta;
import br.com.cropMonitoring.Model.Station;
import br.com.cropMonitoring.mock.Repository;

@ManagedBean(name="stationMB")
@ViewScoped
public class StationMB {

	Repository data = new Repository();
	
	Station current;
	Coleta atual;
	
	public StationMB() {
		data = data.getRepository();
	}

	public Repository getData() {
		return data;
	}

	public void setData(Repository data) {
		this.data = data;
	}

	public Station getCurrent() {
		return current;
	}

	public void setCurrent(Station current) {
		this.current = current;
	}

	public Coleta getAtual() {
		return atual;
	}

	public void setAtual(Coleta atual) {
		this.atual = atual;
	}
	
	
}
