# user bin
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH=${PATH}:~/bin
export PATH=${PATH}:/usr/local/sbin
export PATH=${PATH}:/usr/local/bin
export PATH=${PATH}:/usr/local/texlive/2022/bin
export PATH=${PATH}:~/.cargo/bin
export PATH=${PATH}:~/.fleet/bin
export PATH=${PATH}:/opt/homebrew/opt/ruby/bin/ruby
export PATH=${PATH}:/opt/homebrew/opt/go/bin
export PATH=${PATH}:/opt/homebrew/opt/llvm/bin
export PATH=${PATH}:/opt/homebrew/bin
export PATH=${PATH}:$(go env GOPATH)/bin
export PATH=${PATH}:/usr/local/texlive/2022/bin/universal-darwin

# Go
export GOPATH=$(go env GOPATH)

# gradle
export GRADLE_HOME=$HOME/.gradle/wrapper/dists/gradle-8.0-all/a2o1xoguejy6msdh0lk99lxza/gradle-8.0/
export PATH=${PATH}:$GRADLE_HOME/bin
export GRADLE_OPTS="-Dorg.gradle.parallel=true -Dorg.gradle.caching=true -Dorg.gradle.daemon=true -Xmx4096m"


# sublime
export PATH=${PATH}:/Applications/Sublime\ Text.app/Contents/SharedSupport/bin
