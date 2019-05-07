import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:tcc_app/vo/sensorReadVO.dart';
import 'package:tcc_app/Model/sensorRead.dart';
import 'package:intl/intl.dart';


class ColetaPage extends StatefulWidget {
  @override
  _ColetaPageState createState() => _ColetaPageState();
}

class _ColetaPageState extends State<ColetaPage> {

  static final TextEditingController _message = new TextEditingController();
  static final TextEditingController _text = new TextEditingController();
  DateFormat dateFormatter = new DateFormat('dd/MM/yyyy H:m:s');

  FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;

  List<BluetoothDevice> _devices = [];
  BluetoothDevice _device;
  bool _connected = false;
  bool _pressed = false;
  SensorRead currentRead;
  final SensorReadHelper dataBase = SensorReadHelper();
  bool _init = true;
  @override
  void initState() {
    super.initState();
//    /bluetooth = FlutterBluetoothSerial.instance;
    bluetooth.disconnect();
    _devices = [];
    _connected = false;
    _pressed = false;
    _text.text = "";
    //dataBase.deleteAll();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    List<BluetoothDevice> devices = [];
    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {
      print("Erro ao carregar dispositivos");

      // TODO - Error
    }

    bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case FlutterBluetoothSerial.CONNECTED:
          setState(() {
            _connected = true;
            _pressed = false;
            currentRead = null;
            _text.text = "";
          });
          break;
        case FlutterBluetoothSerial.DISCONNECTED:
          setState(() {
            _connected = false;
            _pressed = false;
          });
          break;
        default:
        // TODO
          print(state);
          break;
      }
    });

    bluetooth.onRead().listen((msg) {
      setState(() {
        print('Read: $msg');
        _text.text = msg;
        handleRead(msg);
      });
    });

    if (!mounted) return;
    setState(() {
      _devices = devices;
    });
  }


  void handleRead(String data){
    List<String> dados = data.replaceAll("[", "").replaceAll("]", "").split(",");
    print(dados);

    SensorReadVO sensorReadVO = new SensorReadVO(umidadeAr:dados[0],temperaturaAmbiente:dados[1],isChovendo:dados[2],umidadeSolo:dados[3]);
    //print(sensorReadVO);
    double tmp = double.parse(sensorReadVO.temperaturaAmbiente);
    int uAr = int.parse(sensorReadVO.umidadeAr);
    int uSolo = int.parse(sensorReadVO.umidadeSolo);
    int isChuva = int.parse(sensorReadVO.isChovendo);
    var random = Random();
    setState(() {
      currentRead = SensorRead(idStation: 1, umidadeAr: uAr, temperatura: tmp,isChuva: isChuva,umidadeSolo: (uSolo>100 ? random.nextInt(100):uSolo));
    });


  }

  void saveRead(){
    if(currentRead != null){
      dataBase.saveSensorRead(currentRead).then((sensorRe){
        print(sensorRe);
        _showMessage();
      });
      currentRead = null;
      Navigator.pop(context);
      //show("Coleta salva com sucesso");

    }
  }
  String dataNowFormat(){
    var dat = DateTime.now();
    return dateFormatter.format(dat);

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coletar Dados'),
      ),
      body: _init ?
      FutureBuilder(
          future: Future.delayed(Duration(seconds: 4)),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case (ConnectionState.waiting):
              case (ConnectionState.none):
                return  Center(
                  child: CircularProgressIndicator(
                    valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.purple),
                    strokeWidth: 5.0,
                  ),
                );

              default:
                if (snapshot.hasError)
                  return Text("Erro ao carregar do banco");
                else{
                  _init = false;
                  return main();
                }
            }
          }):
          main()
    );
  }

  Widget main(){
    return Container(
      child: ListView(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Selecione a Estaçâo:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      DropdownButton(
                        items: _getDeviceItems(),
                        onChanged: (value) => setState(() => _device = value),
                        value: _device,
                      ),
                      RaisedButton(
                        color: Colors.deepPurpleAccent,
                        onPressed:
                        _pressed ? null : _connected ? _disconnect : _connect,
                        child: Text(_connected ? 'Desconectar' : 'Conectar', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),),
                      ),
                    ],
                  ),
                ],
              )
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 0.0),
            child: Row(
              children: <Widget>[
                RaisedButton(
                  color: Colors.deepPurpleAccent,
                  onPressed: _connected ? _writeTest : null,
                  child: Text('Coletar Dados', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                currentRead != null ?  columnData():
                Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Realize uma nova coleta: \n ", style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
                        Text("   1 - Selecione uma estação", style: TextStyle(fontSize: 16.0,fontWeight: _device!=null ? FontWeight.bold:FontWeight.normal,color: _device!=null ? Colors.green: Colors.black),),
                        Text("   2 - Aperte em conectar", style: TextStyle(fontSize: 16.0,fontWeight: _connected ? FontWeight.bold:FontWeight.normal,color: _connected ? Colors.green: Colors.black),),
                        Text("   3 - Aperte coletar dados", style: TextStyle(fontSize: 16.0),),
                      ],
                    )
                )
              ],
            ),
          ),
        ],
      ),
    );
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
        saveButton(),
      ],
    );
  }

  Widget saveButton(){
    return FlatButton(
      padding: EdgeInsets.only(left: 80.0, right: 80.0),
      color: Colors.deepPurpleAccent,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
      child: Text("Salvar", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),),
      onPressed: (){
        saveRead();
      },
    );
  }

  Widget cardTemperatura(){
    if(currentRead!=null) {
      return Card(
          elevation: 1,
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
                  Text("Ambiente: ${currentRead.temperatura}°C", style: TextStyle( color: Colors.white,fontSize: 14.0),),
                ],
              )
          )
      );
    }else{
      return Container();
    }
  }
  Widget cardUmidade(){
    if(currentRead!=null) {
      return Card(
          elevation: 1,
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
                  Text("Ambiente: ${currentRead.umidadeAr}% \nSolo: ${currentRead.umidadeSolo}%", style: TextStyle( color: Colors.white,fontSize: 14.0),),
                ],
              )
          )
      );
    }else{
      return Container();
    }
  }
  Widget cardPrecipitacao(){
    if(currentRead!=null) {
      return Card(
          elevation: 1,
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
                  Text("${currentRead.isChuva == 1 ? "Não":"Sim"}", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                ],
              )
          )
      );
    }else{
      return Container();
    }
  }
  ///
  ///
  ///
  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devices.isEmpty) {
      items.add(DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      _devices.forEach((device) {
        items.add(DropdownMenuItem(
          child: Text(device.name),
          value: device,
        ));
      });
    }
    return items;
  }

  ///
  ///
  ///
  void _connect() {
    if (_device == null) {
      show('No device selected.');
    } else {
      bluetooth.isConnected.then((isConnected) {
        if (!isConnected) {
          bluetooth.connect(_device).catchError((error) {
            setState(() => _pressed = false);
          });
          setState(() => _pressed = true);
        }
      });
    }
  }

  ///
  ///
  ///
  void _disconnect() {
    bluetooth.disconnect();
    setState(() => _pressed = true);
  }

  ///
  ///
  ///
  void _writeTest() {
    bluetooth.isConnected.then((isConnected) {
      if (isConnected) {
        bluetooth.write("1");
      }
    });
  }

  ///
  ///
  ///
  Future show(
      String message, {
        Duration duration: const Duration(seconds: 3),
      }) async {
    await new Future.delayed(new Duration(milliseconds: 100));
    Scaffold.of(context).showSnackBar(
      new SnackBar(
        content: new Text(
          message,
          style: new TextStyle(
            color: Colors.white,
          ),
        ),
        duration: duration,
      ),
    );
  }

  void _showMessage() async {
//     flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: Container(
            child: Text("Coleta salva com sucesso !"),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK",
                  style: TextStyle(color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold),),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}