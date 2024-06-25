alias bluetooth_debugging='adb forward tcp:4444 localabstract:/adb-hub && adb connect localhost:4444'
alias wifi_debugging='adb tcpip 5555 && adb connect 172.16.1.51:5555'
alias wifi_connect='adb connect 172.16.1.43:5555'

alias dhu='adb forward tcp:5277 tcp:5277 && sleep 2 && $ANDROID_HOME/extras/google/auto/desktop-head-unit '
alias kill_gradle_cache='find ~/.gradle -type f -name "*.lock" | while read f; do rm $f; done'

alias set_proxy='adb shell settings put global http_proxy 192.168.225.100:3128 && adb shell settings put global global_http_proxy_host 172.22.11.226 && adb shell settings put global global_http_proxy_port 8080'
alias clear_proxy='adb shell settings delete global http_proxy && adb shell settings delete global global_http_proxy_host && adb shell settings delete global global_http_proxy_port'

export ANDROID_HOME=$HOME/Library/Android/sdk
export ANDROID_AVD_HOME=$HOME/.android/avd
export ANDROID_SDK_HOME=$ANDROID_HOME
export NDK=$ANDROID_SDK_HOME/ndk/20.0.5594570/
export GRADLE_USER_HOME=$HOME/.gradle

# export HOST_TAG=darwin-x86_64
# export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/$HOST_TAG
# export AR=$TOOLCHAIN/bin/aarch64-linux-android-ar
# export AS=$TOOLCHAIN/bin/aarch64-linux-android-as
# export CC=$TOOLCHAIN/bin/aarch64-linux-android21-clang
# export CXX=$TOOLCHAIN/bin/aarch64-linux-android21-clang++
# export LD=$TOOLCHAIN/bin/aarch64-linux-android-ld
# export RANLIB=$TOOLCHAIN/bin/aarch64-linux-android-ranlib
# export STRIP=$TOOLCHAIN/bin/aarch64-linux-android-strip

export PATH=${PATH}:$ANDROID_HOME/tools
export PATH=${PATH}:$ANDROID_HOME/platform-tools
export PATH=${PATH}:$ANDROID_HOME/build-tools/28.0.2
export PATH=${PATH}:$ANDROID_HOME/apktool
export PATH=${PATH}:$ANDROID_HOME/cmdline-tools/latest/bin

# https://github.com/apxb1988/dex2jar
alias dex2jar='sh $ANDROID_HOME/dex2jar-2.0/d2j-dex2jar.sh -f $1'


alias start_demo='adb shell settings put global window_animation_scale 0.0 && adb shell settings put global transition_animation_scale 0.0 && adb shell settings put global window_animation_scale 0.0 && adb shell settings put global animator_duration_scale 0.0 && adb shell settings put secure show_ime_with_hard_keyboard 0'
