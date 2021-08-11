package com.example.moengage_sdk
import android.content.Intent
import com.moengage.core.LogLevel
import com.moengage.core.MoEngage
import com.moengage.core.config.GeofenceConfig
import com.moengage.core.config.InAppConfig
import com.moengage.core.config.LogConfig
import com.moengage.core.config.NotificationConfig
import com.moengage.flutter.MoEInitializer
import com.moengage.geofence.MoEGeofenceHelper
import com.moengage.geofence.listener.OnGeofenceHitListener
import io.flutter.app.FlutterApplication

class MyApplication() : FlutterApplication(){

    override fun onCreate() {
        super.onCreate()

        val configureNotificationMetaData =
            MoEngage.Builder(this, "S3FN6CEPSJFCNCL7UT91FI0N")//enter your own app id
                .configureLogs(LogConfig(LogLevel.VERBOSE, true))
                .configureNotificationMetaData(
                    NotificationConfig(
                        R.drawable.ic_baseline_4g_mobiledata_24,
                        R.drawable.launch_background,
                        R.color.design_default_color_error,
                        tone = null,
                        isMultipleNotificationInDrawerEnabled = true,
                        isBuildingBackStackEnabled = true,
                        isLargeIconDisplayEnabled = true
                    )
                ).configureGeofence(
                    GeofenceConfig(
                        isGeofenceEnabled = true,
                        isBackgroundSyncEnabled = true
                    )
                ).configureInApps(
                    InAppConfig(
                       false
                    )
                )

        MoEInitializer.initialize(this, configureNotificationMetaData)
        MoEGeofenceHelper.getInstance().addListener(object:OnGeofenceHitListener{
            override fun geofenceHit(geoFenceHit: Intent): Boolean {
                return false
            }

        });
    }
}