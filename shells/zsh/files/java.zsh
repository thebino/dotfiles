# list java versions
# /usr/libexec/java_home -V

# export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_181.jdk/Contents/Home
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-11.0.12.jdk/Contents/Home
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Home
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-11-openj9.jdk/Contents/Home
export JAVA_HOME=/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/temurin-11.jdk/Contents/Home



# java
DEFAULT_JVM_OPTS="-Xmx512m"



export JAVA_11_HOME=$(/usr/libexec/java_home -v11)
export JAVA_17_HOME=$(/usr/libexec/java_home -v17)

alias java8='export JAVA_HOME=$JAVA_8_HOME'
alias java11='export JAVA_HOME=$JAVA_11_HOME'
alias java17='export JAVA_HOME=$JAVA_17_HOME'


# list available java versions
alias java_ls='/usr/libexec/java_home -V 2>&1 | grep -E "\d.\d.\d[,_]" | cut -d , -f 1 | colrm 1 4 | grep -v Home'

# change selected java version
function java_use() {
   export JAVA_HOME=$(/usr/libexec/java_home -v $1)
   export PATH=${PATH}:$JAVA_HOME/bin
   java -version
}
