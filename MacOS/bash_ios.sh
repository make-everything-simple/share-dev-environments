# Utility commands for iOS Development

#==============================================#
# install iOS tools
#==============================================#
alias install_xcode="open 'https://developer.apple.com/xcode/'"
alias install_xcode_cli='xcode-select --install'
alias simulators='xcrun simctl list'
alias install_pod="open 'https://cocoapods.org/'"
alias install_carthage="open 'https://github.com/Carthage/Carthage#installing-carthage'"
alias spm_install="open 'https://github.com/apple/swift-package-manager'"

ios_profiles() {
  open ~/Library/MobileDevice/Provisioning\ Profiles/
}

ios_clean() {
 echo 'remove all data in folder Library/Developer/Xcode/DerivedData/'
 rm -rf ~/Library/Developer/Xcode/DerivedData/
}

ios_tools() {
  beginf
  echo '\u2460 Xcode: install Xcode IDE https://developer.apple.com/xcode/'
  echo '\u2461 Xcode CLI: allows you to do command line development in macOS'
  echo '\u2462 CocoaPods: is a centralized dependency manager'
  echo '\u2463 Carthage: is a decentralized dependency manager' 
  echo '\u2464 SPM: is a tool for managing distribution of source code back by Apple'
  endf
}

ios_setup() {
  beginf
  echo '$ install_xcode: install Xcode IDE'
  echo '$ install_xcode_cli: install Xcode CLI'
  echo '$ install_pod: install CocoaPods'
  echo '$ install_carthage: install Carthage'
  echo '$ spm_install: install Swift Package Manager'
  endf
}

ios_help() {
 beginf
 echo '$ ios_tools: check required tools for iOS development'
 echo '$ ios_setup: setup required development tools'
 echo '$ ios_clean: clean DerivedData folder'
 echo '$ simulators: list iOS simulators'
 echo '$ xcodebuild: build Xcode projects and workspaces.'
 echo '$ runOnSimulator $simulator_name: run react-native on a specific simulator'
 echo '$ xcrun: run or locate development tools and properties.'
 echo '$ xcode-select: manages the active developer directory for Xcode and BSD tools.'
 echo '$ ios_profiles: open Provisioning Profiles of xcode'
 echo '$ build_xcframework [SCHEME] [iOS_ONLY]: build a xcframework for iOS only or both iOS and MacOS (default)'
 echo '$ pod trunk [COMMAND]: interact with the CocoaPods API to manage podspecs'
 endf
}

#######################################
# Build XCFramework to support multi architectures.
# Globals:
#   None
# Arguments:
#   SCHEME to build $SCHEME.xcscheme. Default is current directory name
#   iOS_ONLE check to build iOS only or both iOS and MacOS. Default is both
# Outputs:
#   Create a new file $SCHEME.xcframework
#######################################
build_xcframework() {
  beginf
  # https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html
  local dir_name=${PWD##*/}
  if [[ -z "${1}" ]]; then
    echo "build_xcframework $dir_name false"
  else
    if [[ -z "${2}" ]]; then
      echo "build_xcframework $1 false"
    else
      echo "build_xcframework $1 $2"
    fi
  fi
  local scheme_name=${1:=$dir_name}
  local is_iOS_only=${2:=false}

  # 1. Remove existing xcframework bundle
  test -d "$scheme_name.xcframework" && rm -rf "$PWD/$scheme_name.xcframework"

  # 2. Build all the supported architectures & create a XCFramework
  if [[ "${is_iOS_only}" == 'true' ]]; then
    build_xcframework_ios $scheme_name
  else
    ## Device slice.
    xcodebuild clean archive -scheme "$scheme_name" CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO -sdk iphoneos  -configuration Release -destination 'generic/platform=iOS' -archivePath "$PWD/archives/$scheme_name.framework-iphoneos.xcarchive" SKIP_INSTALL=NO

    ## Simulator slice.
    xcodebuild clean archive -scheme "$scheme_name" CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO -sdk iphonesimulator -configuration Release -destination 'generic/platform=iOS Simulator' -archivePath "$PWD/archives/$scheme_name.framework-iphonesimulator.xcarchive" SKIP_INSTALL=NO

    ## Mac Catalyst slice.
    xcodebuild clean archive -scheme "$scheme_name" -configuration Release -archivePath "$PWD/archives/$scheme_name.framework-catalyst.xcarchive" SKIP_INSTALL=NO

    # Create a XCFramework to combine all the supported architectures in a bundle
    xcodebuild -create-xcframework -framework "$PWD/archives/$scheme_name.framework-iphonesimulator.xcarchive/Products/Library/Frameworks/$scheme_name.framework" -framework "$PWD/archives/$scheme_name.framework-iphoneos.xcarchive/Products/Library/Frameworks/$scheme_name.framework" -framework "$PWD/archives/$scheme_name.framework-catalyst.xcarchive/Products/Library/Frameworks/$scheme_name.framework" -output "$PWD/$scheme_name.xcframework"
  fi

  # 3. Remove temporay folder to take the space back
  rm -rf "$PWD/archives"
  $endf
}

#######################################
# Build XCFramework to support multi architectures for iOS only.
# Globals:
#   None
# Arguments:
#   SCHEME to build $SCHEME.xcscheme. Default is current directory name
# Outputs:
#   Create a new file $SCHEME.xcframework
build_xcframework_ios() {
  beginf
  if [[ -z "${1}" ]]; then
    echo "Missing SCHEME, retry with 'build_xcframework_ios [SCHEME]', please"
  else
    ## Device slice.
    xcodebuild clean archive -scheme "$1" CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO -sdk iphoneos  -configuration Release -destination 'generic/platform=iOS' -archivePath "$PWD/archives/$1.framework-iphoneos.xcarchive" SKIP_INSTALL=NO

    ## Simulator slice.
    xcodebuild clean archive -scheme "$1" CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO -sdk iphonesimulator -configuration Release -destination 'generic/platform=iOS Simulator' -archivePath "$PWD/archives/$1.framework-iphonesimulator.xcarchive" SKIP_INSTALL=NO

    ## Create a XCFramework to combine all the supported architectures in a bundle
    xcodebuild -create-xcframework -framework "$PWD/archives/$1.framework-iphonesimulator.xcarchive/Products/Library/Frameworks/$1.framework" -framework "$PWD/archives/$1.framework-iphoneos.xcarchive/Products/Library/Frameworks/$1.framework" -output "$PWD/$1.xcframework"
  fi
  endf
}