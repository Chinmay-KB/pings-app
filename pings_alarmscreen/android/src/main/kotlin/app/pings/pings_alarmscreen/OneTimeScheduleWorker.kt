package app.pings.pings_alarmscreen

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.content.Context.NOTIFICATION_SERVICE
import android.graphics.BitmapFactory
import android.os.Build
import android.widget.Toast
import androidx.annotation.RequiresApi
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import androidx.core.content.ContextCompat.getSystemService
import androidx.core.graphics.drawable.IconCompat
import androidx.work.ListenableWorker
import androidx.work.Worker
import androidx.work.WorkerParameters
import io.flutter.FlutterInjector
import java.util.*
import kotlin.random.Random

class OneTimeScheduleWorker(val context: Context, workerParams:WorkerParameters) : Worker(context,workerParams) {
    @RequiresApi(Build.VERSION_CODES.M)
    override fun doWork(): Result {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val name = "ALARM_CHANNEL"
            val descriptionText = "All alarms will be shown in this channel"
            val importance = NotificationManager.IMPORTANCE_DEFAULT
            val channel = NotificationChannel("CHANNEL_ID", name, importance).apply {
                description = descriptionText
            }
            // Register the channel with the system
            val notificationManager: NotificationManager =
                context.getSystemService(NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        }
        Toast.makeText(applicationContext, "Works", Toast.LENGTH_SHORT).show()
        val builder= NotificationCompat.Builder(context, "SCREEN")
            .setSmallIcon(context.resources.getIdentifier("ic_access_alarms", "drawable", context.packageName))
            .setContentTitle("Scheduled")
            .setContentText("One time working")
            .setPriority(NotificationCompat.PRIORITY_HIGH)
        print("Is is inside though")
        with(NotificationManagerCompat.from(context)){
            notify(Random.nextInt(), builder.build())
        }
        return Result.success()
    }

}
