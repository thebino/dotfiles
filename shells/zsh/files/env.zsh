# user bin
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH=${PATH}:~/bin
export PATH=${PATH}:/usr/local/sbin
export PATH=${PATH}:/usr/local/bin
export PATH=${PATH}:/usr/local/texlive/2022/bin
export PATH=${PATH}:/opt/homebrew/Cellar/go@1.21/
export PATH=${PATH}:~/.cargo/bin
export PATH=${PATH}:~/.fleet/bin

# gradle
export GRADLE_HOME=$HOME/.gradle/wrapper/dists/gradle-8.0-all/a2o1xoguejy6msdh0lk99lxza/gradle-8.0/
export PATH=${PATH}:$GRADLE_HOME/bin
export GRADLE_OPTS="-Dorg.gradle.parallel=true -Dorg.gradle.caching=true -Dorg.gradle.daemon=true -Xmx4096m"


# sublime
export PATH=${PATH}:/Applications/Sublime\ Text.app/Contents/SharedSupport/bin
