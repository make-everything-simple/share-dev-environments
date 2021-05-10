#!/bin/bash
#
# Utility commands for Android Development.

#==============================================#
# install android tools
#==============================================#
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_51.jdk/Contents/Home

export ANDROID_HOME=${HOME}/Library/Android/sdk
export ANDROID_SDK_ROOT=${HOME}/Library/Android/sdk
export PATH=${PATH}:${ANDROID_HOME}/tools
export PATH=${PATH}:${ANDROID_HOME}/platform-tools

android_tools() {
  beginf
  echo '1. JDK (Java SE Development Kit). For Java Developers. Includes a complete JRE plus tools for developing, debugging, and monitoring Java applications. 
        install: https://docs.oracle.com/cd/E19182-01/820-7851/inst_cli_jdk_javahome_t/'
  echo '2. Android SDK (software development kit) is a set of development tools used to develop applications for Android platform.
        install: https://developer.android.com/studio'
  echo '3. IDE for Android: Android Studio, IntelliJ (Optional)'
  echo '4. Gradle is an open-source build automation tool focused on flexibility and performance. Gradle build scripts are written using a Groovy or Kotlin DSL.
        install: $ install_gradle'
  echo '5. Android Debug Bridge (adb) is a versatile command-line tool that lets you communicate with a device, is included in the Android SDK Platform-Tools package.'
  echo '6. Logcat (adb logcat) is a command-line tool that dumps a log of system messages, including stack traces when the device throws an error and messages'
  echo ''
  echo 'Noted: check path of JAVA_HOME (ex: jdk1.8.0_51.jdk) in .bash_profile to make sure we use correctly'
  endf
}

android_help() {
  beginf
  echo '$ android_tools: check required tools for Android development'
  echo '$ emulators: show list android emulators'
  echo '$ start_emulator $emulator_name: launch a specific emulator'
  echo '$ adb_help: show utility commands of adb command-line tool'
  echo '$ gpay_help: show list commands for Google Pay'
  echo '$ app_signing: Security your application'
  endf
}

alias app_signing="open 'https://developer.android.com/studio/publish/app-signing'"
alias emulators="emulator -list-avds"

start_emulator() {
  emulator -avd $1
}

# Google Pay Utility Commands
gpay_help() {
  beginf
  echo 'You must connect to your device first via adb command-line: $ adb_help'
  echo '$ gpay_sandbox $is_enable: enable google pay sandbox mode or not'
  echo '$ gpay_enable: enable Google Pay app for some device don’t have it.'
  endf
}

gpay_sandbox() {
  if [ "$1" = "true" ]; then
    echo 'Enable Google Pay Sandbox Mode'
    adb -d shell touch /sdcard/Download/android_pay_env_override_sandbox
    adb -d reboot
  else
    echo 'Disable Google Pay Sandbox Mode'
    adb -d shell rm /sdcard/Download/android_pay_env_override_sandbox
    adb -d reboot
  fi
}

gpay_enable() {
  adb -d shell am start -n com.google.android.gms/com.google.android.gms.tapandpay.settings.TapAndPaySettingsActivity
}

# Android Debug Bridge Utility Commands to communicate with device
alias start_server="adb start-server"
alias listen_port="adb tcpip $1"
alias stop_server="adb kill-server"
alias connect_device="adb connect $1"
alias devices='adb devices'
alias adb_docs="open 'https://developer.android.com/studio/command-line/adb'"
alias logcat_docs="open 'https://developer.android.com/studio/command-line/logcat'"
alias connect_device11="open 'https://developer.android.com/studio/command-line/adb#connect-to-a-device-over-wi-fi-android-11+'"
alias adb_analytics_debug="adb shell setprop debug.firebase.analytics.app $1"
adb_help() {
  beginf
  echo 'Connect to a device over Wi-Fi'
  echo '- MUST be the same wireless connection'
  echo "- Must be the same adb version: /usr/local/Cellar/android-sdk/version/platform-tools/adb the same $ANDROID_SDK_ROOT/platform-tools/adb"
  echo ''
  echo '$ connect_device11: guide for Android 11+ '
  echo ''
  echo 'Android 10 and lower: follow the following steps:'
  echo '1. $ start_server: Ensure that there is a server running'
  echo '2. $ listen_port [port_number]: Set the target device to listen for a TCP/IP connection on a specific port 5555'
  echo '3. $ connect_device [device_ip_address]: Connect to the device by its IP address'
  echo '4. $ devices: show List of devices attached'
  echo ''
  echo '$ stop_server: Reset your adb host to stop listening for a TCP/IP connection'
  echo '$ adb_docs: open official Android documentation adb command-line'
  echo '$ logcat_docs: open official Android documentation logcat command-line'
  echo ''
  echo '$ adb_analytics_debug: enable debug view for firebase analytics by packagename or .none. to disable'
  endf
}