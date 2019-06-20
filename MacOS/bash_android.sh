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
  echo 'Noted: check path of JAVA_HOME (ex: jdk1.8.0_51.jdk) in .bash_profile to make sure we use correctly'
  endf
}

android_help() {
  beginf
  echo '$ android_tools: check required tools for Android development'
  echo '$ emulators: show list android emulators'
  echo '$ start_emulator $emulator_name: launch a specific emulator'
  endf
}
alias emulators="emulator -list-avds"
start_emulator() {
  emulator -avd $1
}