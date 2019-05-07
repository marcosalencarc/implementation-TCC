import 'package:flutter/material.dart';
import 'package:tcc_app/View/reads_page.dart';
import 'package:tcc_app/View/recomendation_page.dart';
import 'ColetaPage.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(51, 51, 51, 1.0),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Crop Monitoring'),
          ),
          backgroundColor: Color.fromRGBO(51, 51, 51, 1.0),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              _rows("REALIZAR COLETA", Icons.add, (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ColetaPage()));
                  },
                  "VISUALIZAR COLETAS", Icons.search, (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ReadsPage()));
                  }),
              Container(
                height: 1.0,
                color: Color(0xFFCCCCCC),
              ),
              _rows("ENVIAR COLETAS", Icons.cloud_upload, ((){}),
                  "INSERIR RECOMENDAÇÕES", Icons.assignment, (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RecomendationPage()));
                  }),
            ],
          ),
        ),
      ),
    );
  }

  void realizarColeta(){

  }

  Widget _rows(String opcao1, IconData icon1, Function fun1, String opcao2,
      IconData icon2, Function fun2) {
    return Expanded(
      flex: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: _options(opcao1, icon1, fun1),
          ),
          Container(
            width: 1.0,
            color: Color(0xFFCCCCCC),
          ),
          Expanded(
            flex: 1,
            child: _options(opcao2, icon2, fun2),
          ),
        ],
      ),
    );
  }

  Widget _options(String opcao, IconData icon, Function fun) {
    return FlatButton(
      color: Colors.white,
      shape: BeveledRectangleBorder(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Icon(
              icon,
              color:Theme.of(context).primaryColor,
              size: 80.0,
            ),
          ),
          Text(
            opcao,
            style: TextStyle(
              fontSize: 11.0,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      onPressed: fun,
    );
  }

}
