import 'package:flutter/material.dart';
import 'package:flutter_imin_scale/flutter_imin_scale.dart';
import 'package:flutter_imin_scale/models/imin_scale_obj.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _scale = FlutterIminScale();
  IminScaleObj _iminScaleObj = IminScaleObj('', '');

  @override
  void initState() {
    super.initState();
    initScale();
  }

  void initScale() {
    _scale.initElectronic();
    _scale.setWeightInfoCallback((IminScaleObj iminScaleObj) {
      _iminScaleObj = iminScaleObj;
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('IminElectronicScale'),
        ),
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: Center(
              child: Text(
                'weight: ${_iminScaleObj.weight} weightStatus: ${_iminScaleObj.weightStatus}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            )),
            ElevatedButton(
                onPressed: () {
                  initScale();
                },
                child: const Text('Init Electronic')),
            ElevatedButton(
                onPressed: () {
                  _scale.turnZero();
                },
                child: const Text('Turn Zero')),
            ElevatedButton(
                onPressed: () {
                  _scale.manualPeel(100);
                },
                child: const Text('Manual Peel 100g')),
            ElevatedButton(
                onPressed: () {
                  _scale.removePeel();
                },
                child: const Text('Remove Peel')),
            ElevatedButton(
                onPressed: () {
                  _scale.closeElectronic();
                },
                child: const Text('Close Electronic')),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scale.dispose();
    super.dispose();
  }
}
