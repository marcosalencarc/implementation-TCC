import 'package:flutter/material.dart';
import 'package:tcc_app/Model/sensorRead.dart';
import 'package:tcc_app/Model/sensorRead.dart';
import 'package:intl/intl.dart';

class ReadsPage extends StatefulWidget {
  @override
  _ReadsPageState createState() => _ReadsPageState();
}

class _ReadsPageState extends State<ReadsPage> {

  SensorReadHelper sensorReadHelper = new SensorReadHelper();
  List<SensorRead> sensorReads = List();
  DateFormat dateFormatter = new DateFormat('dd/MM/yyyy H:m:s');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coletas Realizadas"),

      ),
      backgroundColor: Color(0xFFEFF0F1),
      body: FutureBuilder(
          future: _getAllReads(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case (ConnectionState.waiting):
              case (ConnectionState.none):
                return  Center(
                  child: CircularProgressIndicator(
                    valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 5.0,
                  ),
                );

              default:
                if (snapshot.hasError)
                  return Text("Erro ao carregar do banco");
                else{
                  return _createLista(context, snapshot);
                }
            }
          }),
    );
  }

  Future<List> _getAllReads() async {
    return await sensorReadHelper.getAllSensorReads();
  }

  Widget _createLista(BuildContext context, AsyncSnapshot snapshot){
    if(snapshot.data.length < 1){
      return Center(child: Text("Nenhuma coleta local registrada"),);
    }else{
      sensorReads = snapshot.data;
      return ListView.builder(
          padding: EdgeInsets.all(0.0),
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return _deliveryCard(context, index);
          });
    }
  }

  String dataNowFormat(){
    var dat = DateTime.now();
    return dateFormatter.format(dat);

  }

  Widget _deliveryCard(BuildContext context, int index) {
    return Card(
      elevation: 2.0,
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
      child:
      ListTile(
        contentPadding: EdgeInsets.all(8.0),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Coleta ${sensorReads[index].id}", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent),),
            Row(
              children: <Widget>[
                Text("Local: ", style: TextStyle(fontSize: 14.0, color: Colors.black),),
                Text("Sitio principal", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold,color: Colors.deepPurpleAccent),),
              ],
            ),

            Row(
              children: <Widget>[
                Text("Data: ", style: TextStyle(fontSize: 14.0, color: Colors.black),),
                Text("${dataNowFormat()}",style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold,color: Colors.deepPurpleAccent),),
              ],
            ),

          ],
        ),
        ),
      );
  }


}
