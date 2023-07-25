package com.ezyorder.flutter_imin_scale

import android.util.Log
import com.ezyorder.flutter_imin_scale.models.IminScaleObj
import com.google.gson.Gson
import com.neostra.electronic.ElectronicCallback
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

internal class ElectronicCallbackHandler(methodChannel: MethodChannel?) : ElectronicCallback,FlutterActivity() {
    private val channel: MethodChannel? = methodChannel


    override fun electronicStatus(s: String, s1: String) {


        runOnUiThread{
            val iminScaleObj = IminScaleObj(weight = s, weightStatus = s1)
            val json = Gson().toJson(iminScaleObj)
            channel!!.invokeMethod("weightInfo", json)

        }

    }
}