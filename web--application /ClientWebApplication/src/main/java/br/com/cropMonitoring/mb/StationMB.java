package br.com.cropMonitoring.mb;

import javax.faces.bean.ManagedBean;
import javax.faces.view.ViewScoped;

import br.com.cropMonitoring.Model.Station;
import br.com.cropMonitoring.mock.Repository;

@ManagedBean(name="stationMB")
@ViewScoped
public class StationMB {

	Repository data = new Repository();
	
	Station current;
	
	public StationMB() {
		data = data.getRepository();
	}

	public Repository getData() {
		return data;
	}

	public void setData(Repository data) {
		this.data = data;
	}
	
}
