package app.pings.pings_alarmscreen

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Context.NOTIFICATION_SERVICE
import android.content.Intent
import android.os.Build
import android.widget.Toast
import androidx.annotation.RequiresApi
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import androidx.core.content.ContextCompat.getSystemService
import kotlin.random.Random

class NotificationReceiver: BroadcastReceiver() {
    @RequiresApi(Build.VERSION_CODES.O)
    override fun onReceive(context: Context?, intent: Intent?) {
            val name = "ALARM_CHANNEL"
            val descriptionText = "All alarms will be shown in this channel"
            val importance = NotificationManager.IMPORTANCE_DEFAULT
            val channel = NotificationChannel("CHANNEL_ID", name, importance).apply {
                description = descriptionText
            }
            // Register the channel with the system
            val notificationManager: NotificationManager =
                context?.getSystemService(NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)

        Toast.makeText(context, descriptionText, Toast.LENGTH_SHORT).show()
        val builder= NotificationCompat.Builder(context, "SCREEN")
            .setSmallIcon(context.resources.getIdentifier("ic_access_alarms", "drawable", context.packageName))
            .setContentTitle("Scheduled")
            .setContentText("One time working")
            .setPriority(NotificationCompat.PRIORITY_HIGH)
        notificationManager.notify(Random.nextInt(), builder.build())
//        print("Is is inside though")
//        with(NotificationManagerCompat.from(context)){
//            notify(Random.nextInt(), builder.build())
//        }
    }
}