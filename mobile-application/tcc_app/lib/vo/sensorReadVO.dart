
class SensorReadVO {
  String umidadeAr;
  String temperaturaAmbiente;
  String isChovendo;
  String umidadeSolo;


  SensorReadVO({this.umidadeAr, this.temperaturaAmbiente, this.isChovendo, this.umidadeSolo});

  factory SensorReadVO.fromJson(Map<String, dynamic> json) {
    return SensorReadVO(
        umidadeAr: json["umidadeAr"],
        temperaturaAmbiente: json["temperaturaAmbiente"],
        isChovendo: json["isChovendo"],
        umidadeSolo: json["umidadeSolo"]
    );
  }

  @override
  String toString() {
    return "{umidadeAr: "+ this.umidadeAr+", temperaturaAmbiente: "+this.temperaturaAmbiente+", chovendo:"+ (this.isChovendo == "0" ? "Sim" : "Não") +", umidadeSolo:"+this.umidadeSolo+"}";
  }


}