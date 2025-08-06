-keepclassmembers class com.google.mediapipe.tasks.genai.llminference.LlmInference { *; }
# Keep MediaPipe and Protobuf classes
-keep class com.google.mediapipe.** { *; }
-keep class com.google.protobuf.** { *; }

# Keep other referenced libraries
-keep class javax.lang.model.** { *; }
-keep class org.bouncycastle.** { *; }
-keep class org.conscrypt.** { *; }
-keep class org.openjsse.** { *; }