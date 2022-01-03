import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:animated_background/animated_background.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI CALCULATOR',
      home: const HomePage(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  double? _bmi = 0;
  double _todayValue = 0;

  String _message = 'Please enter your height and weight';

  void _calculate() {
    final double? height = double.tryParse(_heightController.value.text);
    final double? weight = double.tryParse(_weightController.value.text);

    if (height == null || height <= 0 || weight == null || weight <= 0) {
      setState(() {
        _message = "Your height and weight should be positive values.";
      });
      return;
    }

    setState(() {
      _bmi = weight / (height * height);
      if (_bmi! < 18.5) {
        _message = 'Underweight';
      } else if (_bmi! < 25) {
        _message = 'Normal weight';
      } else if (_bmi! < 30) {
        _message = 'Overweight';
      } else {
        _message = 'Obesity';
      }
      _todayValue = _bmi!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 350,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.grey.shade800,
            elevation: 40,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Height (m)',
                      hintText: 'Enter in meters.',
                    ),
                    controller: _heightController,
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Weight (kg)',
                    ),
                    controller: _weightController,
                  ),
                  ElevatedButton(
                    onPressed: _calculate,
                    child: const Text('Calculate'),
                  ),
                  SfLinearGauge(
                    orientation: LinearGaugeOrientation.horizontal,
                    minimum: 12.5,
                    maximum: 35,
                    interval: 35,
                    animateAxis: true,
                    animateRange: true,
                    showLabels: false,
                    showTicks: false,
                    minorTicksPerInterval: 0,
                    axisTrackStyle: const LinearAxisTrackStyle(
                      thickness: 15,
                      color: Colors.white,
                    ),
                    markerPointers: <LinearMarkerPointer>[
                      LinearShapePointer(
                        value: _todayValue,
                        onChanged: (dynamic value) {},
                        height: 20,
                        width: 20,
                        color: _todayValue < 18.5
                            ? Colors.blue
                            : _todayValue < 25
                                ? Colors.green
                                : _todayValue < 30
                                    ? Colors.red
                                    : Colors.black,
                        position: LinearElementPosition.cross,
                        shapeType: LinearShapePointerType.circle,
                      ),
                      const LinearWidgetPointer(
                        value: 15,
                        enableAnimation: false,
                        position: LinearElementPosition.outside,
                        offset: 4,
                        child: Text(
                          'Underweight',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const LinearWidgetPointer(
                        value: 21.2,
                        enableAnimation: false,
                        position: LinearElementPosition.outside,
                        offset: 4,
                        child: Text(
                          'Normal',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const LinearWidgetPointer(
                        value: 26.9,
                        enableAnimation: false,
                        position: LinearElementPosition.outside,
                        offset: 4,
                        child: Text(
                          'Overweight',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const LinearWidgetPointer(
                        value: 32.5,
                        enableAnimation: false,
                        position: LinearElementPosition.outside,
                        offset: 4,
                        child: Text(
                          'Obesity',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                    ranges: const <LinearGaugeRange>[
                      LinearGaugeRange(
                        startValue: 0,
                        endValue: 18.5,
                        startWidth: 8,
                        midValue: 8,
                        endWidth: 8,
                        position: LinearElementPosition.cross,
                        color: Colors.blue,
                      ),
                      LinearGaugeRange(
                        startValue: 18.5,
                        endValue: 24,
                        startWidth: 8,
                        midValue: 8,
                        endWidth: 8,
                        position: LinearElementPosition.cross,
                        color: Colors.green,
                      ),
                      LinearGaugeRange(
                        startValue: 24,
                        endValue: 30,
                        startWidth: 8,
                        midValue: 8,
                        endWidth: 8,
                        position: LinearElementPosition.cross,
                        color: Colors.red,
                      ),
                      LinearGaugeRange(
                        startValue: 30,
                        endValue: 50,
                        startWidth: 8,
                        midValue: 8,
                        endWidth: 8,
                        position: LinearElementPosition.cross,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    _bmi == 0 ? 'No result' : _bmi!.toStringAsFixed(2),
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    _message,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
