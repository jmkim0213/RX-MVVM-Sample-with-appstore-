if which pod >/dev/null; then
  echo 'already installed cocoapods'
else
  sudo gem install -n /usr/local/bin cocoapods
fi

#brew install or update
which -s brew
if [[ $? != 0 ]] ; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
fi

#swiftlint install
if which swiftlint >/dev/null; then
  brew upgrade swiftlint
else
  brew install swiftlint
fi

#intall or upgrade carthage
if which carthage >/dev/null; then
  brew upgrade carthage
else
  brew install carthage
fi

#library install
carthage update --platform iOS --cache-builds
pod update
pod install --repo-update
