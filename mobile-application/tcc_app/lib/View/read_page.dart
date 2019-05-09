import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tcc_app/Model/sensorRead.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:tcc_app/vo/sensorReadVO.dart';
import 'package:tcc_app/Model/sensorRead.dart';
import 'package:intl/intl.dart';
class ReadPage extends StatefulWidget {
  SensorRead current;
  ReadPage({this.current});
  @override
  _ReadPageState createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Recomendação'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child:Column(
              children: <Widget>[
                columnData(),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(10.0),
                    labelText: "Insira a sua recoemndação",
                  ),
                ),
                Container(height: 10.0,),
                saveButton(),
              ],
            ),
          ),
        )
    );
  }

  DateFormat dateFormatter = new DateFormat('dd/MM/yyyy H:m:s');
  Widget saveButton(){
    return FlatButton(
      padding: EdgeInsets.only(left: 80.0, right: 80.0),
      color: Colors.deepPurpleAccent,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
      child: Text("Salvar", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),),
      onPressed: (){
        print("teste");
        _showMessage();

      },
    );
  }

  String dataNowFormat(){
    var dat = DateTime.now();
    return dateFormatter.format(dat);

  }

  Widget columnData(){
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text("Dados Coletados",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
          ],
        ),
        Container(height: 10.0,),
        Row(
          children: <Widget>[
            Text("Estação:",style: TextStyle(fontWeight: FontWeight.bold),),
            Text("Sitio Principal"),
          ],
        ),

        Row(
          children: <Widget>[
            Text("Data:",style: TextStyle(fontWeight: FontWeight.bold),),
            Text("${dataNowFormat()}"),
          ],
        ),
        Container(height: 10.0,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            cardTemperatura(),
            cardUmidade(),
          ],
        ),
        Container(height: 2.0,),
        cardPrecipitacao(),
        Container(height: 40.0,),
      ],
    );
  }

  Widget cardTemperatura(){
    if(widget.current!=null) {
      return Card(
          elevation: 1.0,
          color: Colors.red,
          child: Container(
              height: 100.0,
              width: 140.0,
              padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.ac_unit, color: Colors.white,),
                  Text("Temperatura", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 16.0),),
                  Container(height: 6.0,),
                  Text("Ambiente: ${widget.current.temperatura}°C", style: TextStyle( color: Colors.white,fontSize: 14.0),),
                ],
              )
          )
      );
    }else{
      return Container();
    }
  }
  Widget cardUmidade(){
    if(widget.current!=null) {
      return Card(
          elevation: 1.0,
          color: Colors.blue,
          child: Container(
              height: 100.0,
              width: 140.0,
              padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.invert_colors, color: Colors.white,),
                  Text("Umidade", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 16.0),),
                  Container(height: 6.0,),
                  Text("Ambiente: ${widget.current.umidadeAr}% \nSolo: ${widget.current.umidadeSolo}%", style: TextStyle( color: Colors.white,fontSize: 14.0),),
                ],
              )
          )
      );
    }else{
      return Container();
    }
  }
  Widget cardPrecipitacao(){
    if(widget.current!=null) {
      return Card(
          elevation: 1.0,
          color: Colors.blueGrey,
          child: Container(
              height: 100.0,
              width: 140.0,
              padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.beach_access, color: Colors.white,),
                  Text("Chovendo", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16.0),),
                  Container(height: 6.0,),
                  Text("${widget.current.isChuva == 1 ? "Não":"Sim"}", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                ],
              )
          )
      );
    }else{
      return Container();
    }
  }

  void _showMessage() async {
//     flutter defined functio
    print("teste");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: Container(
            child: Text("Recomendação!"),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK",
                style: TextStyle(color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold),),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}


