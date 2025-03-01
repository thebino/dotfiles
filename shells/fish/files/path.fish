fish_add_path $HOME/.cargo/bin

# user bin
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
fish_add_path ~/bin
fish_add_path /usr/local/sbin
fish_add_path /usr/local/bin
fish_add_path /usr/local/texlive/2022/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.fleet/bin
fish_add_path /opt/homebrew/opt/ruby/bin/ruby
fish_add_path /opt/homebrew/opt/go/bin
fish_add_path /opt/homebrew/opt/llvm/bin
fish_add_path /opt/homebrew/bin
fish_add_path $(go env GOPATH)/bin
fish_add_path /usr/local/texlive/2022/bin/universal-darwin

# Go
set -x GOPATH $(go env GOPATH)

# gradle
set -x GRADLE_HOME $HOME/.gradle/wrapper/dists/gradle-8.0-all/a2o1xoguejy6msdh0lk99lxza/gradle-8.0/
fish_add_path $GRADLE_HOME/bin

set -x GRADLE_OPTS "-Dorg.gradle.parallel=true -Dorg.gradle.caching=true -Dorg.gradle.daemon=true -Xmx4096m"

