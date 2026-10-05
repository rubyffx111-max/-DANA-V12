import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() => runApp(DanaV12App());

class DanaV12App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DANA V12',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF0a0e1a),
        primaryColor: Color(0xFF00ff88),
      ),
      home: DanaHome(),
    );
  }
}

class DanaHome extends StatefulWidget {
  @override
  _DanaHomeState createState() => _DanaHomeState();
}

class _DanaHomeState extends State<DanaHome> {
  String signal = "WAITING";
  String pair = "EUR/USD";
  Color signalColor = Colors.grey;
  int countdown = 60;
  Timer? timer;
  Random rand = Random();
  List<String> pairs = ["EUR/USD", "GBP/USD", "USD/JPY", "BTC/USD", "GOLD"];

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        if (countdown > 0) {
          countdown--;
        } else {
          generateSignal();
          countdown = 60;
        }
      });
    });
  }

  void generateSignal() {
    bool isBuy = rand.nextBool();
    setState(() {
      signal = isBuy ? "BUY 🟢" : "SELL 🔴";
      signalColor = isBuy ? Color(0xFF00ff88) : Color(0xFFff4444);
      pair = pairs[rand.nextInt(pairs.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DANA V12 - PRO SIGNALS", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        centerTitle: true,
        backgroundColor: Color(0xFF121a2e),
        actions: [Icon(Icons.diamond, color: Color(0xFF00ff88))],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFF121a2e),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color(0xFF00ff88).withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Text(pair, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text("OTC MARKET", style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 30),
                  Container(
                    width: 200, height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: signalColor.withOpacity(0.2),
                      border: Border.all(color: signalColor, width: 3),
                    ),
                    child: Center(
                      child: Text(signal, style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: signalColor), textAlign: TextAlign.center),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text("NEXT SIGNAL IN", style: TextStyle(color: Colors.grey, letterSpacing: 2)),
                  SizedBox(height: 10),
                  Text("$countdown s", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Color(0xFF00ff88))),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _statBox("ACCURACY", "96.8%")),
                SizedBox(width: 15),
                Expanded(child: _statBox("WIN RATE", "V12 PRO")),
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: generateSignal,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF00ff88),
                minimumSize: Size(double.infinity, 55),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              child: Text("GENERATE NOW", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statBox(String title, String value) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(color: Color(0xFF121a2e), borderRadius: BorderRadius.circular(15)),
      child: Column(children: [
        Text(title, style: TextStyle(color: Colors.grey, fontSize: 12)),
        SizedBox(height: 5),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF00ff88))),
      ]),
    );
  }
}
