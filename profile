###############################################################################
# PATH
###############################################################################
export PATH=~/bin:$PATH
export JAVA_HOME=~/ins/jdk
export CLASSPATH=$JAVA_HOME/lib/tools.jar:$JAVA_HOME/jre/lib/rt.jar:.
export ANDROID_HOME=~/ins/adt/sdk
export USE_CCACHE=1
export MAVEN_HOME=~/ins/mvn
export M2_HOME=~/ins/mvn
export GRADLE_HOME=~/ins/grd
export PATH=/sbin:$PATH
export PATH=~/bin:$PATH
export PATH=~/bin/archive:$PATH
export PATH=~/bin/archive/rar.macos:$PATH
export PATH=~/bin/perforce:$PATH
export PATH=~/bin/webook:$PATH
export PATH=~/bin/android:$PATH
export PATH=~/bin/android/decompiler:$PATH
export PATH=$JAVA_HOME/bin:$PATH
export PATH=$MAVEN_HOME/bin:$PATH
export PATH=$M2_HOME/bin:$PATH
export PATH=$GRADLE_HOME/bin:$PATH
export PATH=~/ins/rar:$PATH
export PATH=~/ins/adt/sdk/platform-tools:$PATH
export PATH=~/ins/adt/sdk/build-tools/bin:$PATH #you should ln -s xxx bin
export PATH=~/ins/adt/sdk/tools:$PATH
export PATH=~/ins/adt/ndk:$PATH
export PATH=~/ins/bcp/bin:$PATH
export PATH=~/ins/ant/bin:$PATH
export GETH=~/bin/geth

if [ "$BASH" ]; then
    if [ -f ~/.bashrc ]; then
        . ~/.bashrc
    fi
fi
