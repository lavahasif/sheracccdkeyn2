package com.shersoft.sheracccdkeynew

import AndCdkey.CDKey
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler { call, result ->
            if (call.method.equals("getandcdkey")) {
                var cdkey = call.arguments.toString()

                var key1 = cdkey.replace("\\[".toRegex(), "");
                cdkey = key1.replace("\\]".toRegex(), "");
                val decrypt = CDKey.encrypt(cdkey)
                result.success(decrypt)
            }
        }
    }

    private val channel = "cdkey.flutter.dev/cdkey"
//    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
//        if (call.equals("getandcdkey")) {
//            val cdkey = call.arguments.toString()
//            val decrypt = CDKey.encrypt(cdkey)
//            result.success(decrypt)
//        }
//    }
}
