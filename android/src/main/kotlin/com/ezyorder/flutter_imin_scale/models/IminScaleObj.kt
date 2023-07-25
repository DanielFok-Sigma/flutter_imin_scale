package com.ezyorder.flutter_imin_scale.models

class IminScaleObj(val weight: String, val weightStatus: String) {
    companion object {
        fun fromJson(json: Map<String, Any>): IminScaleObj {
            return IminScaleObj(
                json["weight"] as String,
                json["weightStatus"] as String
            )
        }
    }
}