
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'models/imin_scale_obj.dart';



typedef WeightInfoCallback = void Function(IminScaleObj iminScaleObj);


class FlutterIminScale {

  final MethodChannel _channel;
  WeightInfoCallback? _weightInfoCallback;
  IminScaleObj _iminScaleObj = IminScaleObj('', '');



  FlutterIminScale()
      : _channel = const MethodChannel('flutter_imin_scale');



  Future<void> initElectronic() async {
    _channel.setMethodCallHandler(_callback);
    await _channel.invokeMethod('initElectronic');
  }

  void setWeightInfoCallback(WeightInfoCallback? callback) {
    debugPrint('setWeightInfoCallback');
    _weightInfoCallback = callback;
  }

   IminScaleObj getWeight() {
    return _iminScaleObj;
  }

  Future<void> turnZero() async {
    await _channel.invokeMethod('turnZero');
  }

  Future<void> removePeel() async {
    await _channel.invokeMethod('removePeel');
  }

  //Manually peeled {peelWeight}g
  Future<void> manualPeel(int peelWeight) async {
    await _channel.invokeMethod('turnZero', peelWeight);
  }

  Future<void> closeElectronic() async {
    await _channel.invokeMethod('closeElectronic');
  }

  Future<dynamic> _callback(MethodCall call) {
    if (call.method == 'weightInfo') {
      if (_weightInfoCallback != null) {
        final result = IminScaleObj.fromJson(jsonDecode(call.arguments));
        _iminScaleObj = result;
        _weightInfoCallback!(_iminScaleObj);
      }
    }
    return Future.value(true);
  }

  void dispose() {
    _weightInfoCallback = null;
    _channel.setMethodCallHandler(null);
  }
}
