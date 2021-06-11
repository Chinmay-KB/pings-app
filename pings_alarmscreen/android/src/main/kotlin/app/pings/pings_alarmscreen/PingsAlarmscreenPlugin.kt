package app.pings.pings_alarmscreen

import android.app.*
import android.content.Context
import android.content.Intent
import android.os.Build
import android.widget.Toast
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import androidx.core.app.NotificationCompat
import androidx.work.OneTimeWorkRequestBuilder
import androidx.work.WorkManager
import androidx.work.workDataOf
import io.flutter.FlutterInjector
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.concurrent.TimeUnit
import kotlin.random.Random


/** PingsAlarmscreenPlugin */
class PingsAlarmscreenPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context:Context
  private lateinit var loader:FlutterInjector
  private lateinit var activity:Activity

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context=flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "pings_alarmscreen")
    channel.setMethodCallHandler(this)
    loader= FlutterInjector.instance()
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
        setAlarm()
      }
      result.success("Working")
      //scheduleNotification(context, 5000,"Title is working", "Body", result)
      //scheduleOneTimeNotification(15000)
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

//  fun scheduleOneTimeNotification(initialDelay:Long){
//    val work = OneTimeWorkRequestBuilder<OneTimeScheduleWorker>()
//      .setInitialDelay(initialDelay, TimeUnit.MILLISECONDS)
//      .addTag("ALARM_SCREEN")
//      .setInputData(workDataOf(
//        "icon" to FlutterInjector.instance().flutterLoader().getLookupKeyForAsset("notification_icon")
//      ))
//      .build()
//    WorkManager.getInstance(context).enqueue(work)
//  }

  @RequiresApi(Build.VERSION_CODES.O)
  fun setAlarm(){
    val name = "ALARM_CHANNEL"
    val descriptionText = "All alarms will be shown in this channel"
    val importance = NotificationManager.IMPORTANCE_HIGH
    val channel = NotificationChannel("CHANNEL_ID", name, importance).apply {
      description = descriptionText
    }
    val notificationManager: NotificationManager =
      activity.applicationContext.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
    notificationManager.createNotificationChannel(channel)

    Toast.makeText(activity.applicationContext, activity.applicationContext.packageName, Toast.LENGTH_SHORT).show()
    val builder= NotificationCompat.Builder(activity.applicationContext, "SCREEN")
      .setSmallIcon(R.drawable.ic_access_alarms)
      .setContentTitle("Scheduled")
      .setContentText("One time working")
      .setPriority(NotificationCompat.PRIORITY_HIGH)
    notificationManager.notify(Random.nextInt(), builder.build())
//        Tried this as well, not working
//        with(NotificationManagerCompat.from(context)){
//            notify(Random.nextInt(), builder.build())
//        }
  }

  fun scheduleNotification(context: Context, time: Long, title: String?, text: String?, @NonNull result:Result) {

    print("Asuchi")
    val intent = Intent(context, NotificationReceiver::class.java)
    intent.putExtra("title", title)
    intent.putExtra("text", text)
    val pending = PendingIntent.getBroadcast(context, 42, intent, PendingIntent.FLAG_UPDATE_CURRENT)
    // Schdedule notification
    val manager = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
      manager.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, time, pending)
      result.success("Android ${android.os.Build.VERSION.RELEASE} is the version")

    }
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity=binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    TODO("Not yet implemented")
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    TODO("Not yet implemented")
  }

  override fun onDetachedFromActivity() {
    TODO("Not yet implemented")
  }
}
