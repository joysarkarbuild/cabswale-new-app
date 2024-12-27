-keepattributes *Annotation*
-dontwarn com.razorpay.**
-keep class com.razorpay.** {*;}
-optimizations !method/inlining/
-keepclasseswithmembers class * {
  public void onPayment*(...);
}

# Keep the credentials API classes
-keep class com.google.android.gms.auth.api.credentials.** { *; }
-dontwarn com.google.android.gms.auth.api.credentials.**

# Prevent obfuscation of related classes
-keep class androidx.activity.result.** { *; }
-dontwarn androidx.activity.result.**
