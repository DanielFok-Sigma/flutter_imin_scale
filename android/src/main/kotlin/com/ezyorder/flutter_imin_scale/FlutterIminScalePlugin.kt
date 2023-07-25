package com.ezyorder.flutter_imin_scale

import android.util.Log
import androidx.annotation.NonNull
import com.neostra.electronic.Electronic
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterIminScalePlugin */
class FlutterIminScalePlugin : FlutterPlugin, MethodCallHandler, FlutterActivity() {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var methodChannel: MethodChannel

    private var mElectronic: Electronic? = null
    private var electronicCallbackHandler: ElectronicCallbackHandler? = null

//    mElectronic = Electronic.Builder()
//    .setDevicePath(Electronic.getDevicePath())
//    .setReceiveCallback(this)
//    .builder()


    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        methodChannel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_imin_scale")
        methodChannel.setMethodCallHandler(this)
        electronicCallbackHandler = ElectronicCallbackHandler(methodChannel)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {

        try {


            if (call.method == "initElectronic") {
                mElectronic = Electronic.Builder()
                    .setDevicePath(Electronic.getDevicePath())
                    .setReceiveCallback(electronicCallbackHandler)
                    .builder()
            } else {
                if (mElectronic == null) {
                    throw NullPointerException("The electronic scale has not been initialized, please use the initElectronic method to initialize")
                }
                when (call.method) {
                    "turnZero" -> mElectronic!!.turnZero()
                    "removePeel" -> mElectronic!!.removePeel()
                    "manualPeel" -> mElectronic!!.manualPeel(call.arguments as Int)
                    "closeElectronic" -> mElectronic!!.closeElectronic()
                    else -> result.notImplemented()
                }
            }


        } catch (e: Exception) {
            Log.e("Imin Scale Error", e.toString())
            result.success(false)
        }


//        else if (call.method == "getWeight") {
//            try {
//                val iminScaleObj = IminScaleObj(mWeight!!, mWeightState!!)
//                val json = Gson().toJson(iminScaleObj)
//                result.success(json)
//            } catch (e: Exception) {
//                Log.e("getWeight", e.toString())
//                result.success(false)
//            }
//        }

    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        methodChannel.setMethodCallHandler(null)
    }


}
