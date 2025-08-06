# Keep MediaPipe and its proto classes
-keep class com.google.mediapipe.** { *; }
-keep class com.google.mediapipe.proto.** { *; }
-keep class com.google.mediapipe.framework.** { *; }
-keep class com.google.mediapipe.tasks.** { *; }

# Keep Protobuf classes
-keep class com.google.protobuf.** { *; }

# Keep other referenced libraries
-keep class javax.lang.model.** { *; }
-keep class org.bouncycastle.** { *; }
-keep class org.conscrypt.** { *; }
-keep class org.openjsse.** { *; }

# Add these rules for additional components
-dontwarn com.google.protobuf.**
-dontwarn javax.lang.model.**
-dontwarn org.bouncycastle.**
-dontwarn org.conscrypt.**
-dontwarn org.openjsse.**

# Specific rules for the missing classes
-keep class com.google.mediapipe.proto.CalculatorProfileProto$** { *; }
-keep class com.google.mediapipe.proto.GraphTemplateProto$** { *; }