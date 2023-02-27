package uz.demos.almahbub_managment


import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MapKitFactory.setApiKey("4a50fcb7-5dd9-4567-afd8-458d86d411a0") // Your generated API key
        super.configureFlutterEngine(flutterEngine)
    }
}
