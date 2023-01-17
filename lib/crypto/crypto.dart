import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

const apikey ="7C3D50A2-37E2-4C7A-90ED-A7778DB12515";
const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PKR',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];
const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];
class Network{
  final String url;
  Network(this.url);

  Future getdata() async{
    http.Response response= await http.get(Uri.parse(url));

    if (response.statusCode==200) {
      String data =response.body;
      var decodeddata= jsonDecode(data);
      var price= decodeddata["rate"].toInt();
      return price;
    }else{
       // ignore: avoid_print
    print(response.statusCode);
    }

  }
 }
 class Coindata{
  Future getrates(String currencyname) async{
    Map<String, String> cryptoprices= {};
    for (String crypto in cryptoList) {
      String link = "https://rest.coinapi.io/v1/exchangerate/$crypto/$currencyname?apikey=$apikey";
      Network networkhelper = Network(link);
      var eachcoinrate =await networkhelper.getdata();
      cryptoprices[crypto] = eachcoinrate.toString();
    }
    return cryptoprices;
  }

 }

 class CryptoApp extends StatefulWidget {
  const CryptoApp({super.key});
  
  @override
  State<CryptoApp> createState() => _CryptoAppState();
}

class _CryptoAppState extends State<CryptoApp> {
  late String selectedcurrency = 'AUD';
  late String crypto = 'BTC';
  Coindata coinrates= Coindata();
  String? rate;
   Map<String, String> coinValues = {};
  void updateui(String crypto, String selectedcurrency) async{
    var updateddata =await coinrates.getrates(selectedcurrency);
    setState(() {
      coinValues = updateddata;
    });
  }
  @override
  void initState() {
    super.initState();
    updateui(crypto, selectedcurrency);
  }
  CupertinoPicker getiospicker(){
    List<Text> pickeritems= [];
    for(String currency in currenciesList){
      pickeritems.add(Text(currency,
      textAlign: TextAlign.center,
      style: const TextStyle(
                              color: Colors.black,
                        ),));}
    return CupertinoPicker(
      itemExtent: 32, 
      onSelectedItemChanged: (selectedindex){
        setState(() {
          selectedcurrency = currenciesList[selectedindex];
          updateui(crypto, selectedcurrency);
        });
      }, 
      children: pickeritems);

    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker',style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: const Color.fromARGB(255, 228, 252, 14),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Feild(crypto: "BTC", rate: coinValues['BTC'], selectedcurrency: selectedcurrency),
          Feild(crypto: "ETH", rate: coinValues['ETH'], selectedcurrency: selectedcurrency),
          Feild(crypto: "LTC", rate: coinValues['LTC'], selectedcurrency: selectedcurrency),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: const Color.fromARGB(255, 242, 255, 64),
            child: getiospicker(),
          )
        ],
      ),
    );
  }
}
class Feild extends StatelessWidget {
  const Feild({super.key,required this.crypto,
    required this.rate,
    required this.selectedcurrency,});
  final String crypto;
  final String? rate;
  final String selectedcurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
    child: Card(
        color: const Color.fromARGB(255, 228, 252, 14),
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child:  Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $crypto = $rate $selectedcurrency',
            textAlign: TextAlign.center,
            style:const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}