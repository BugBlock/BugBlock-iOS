xcodebuild archive \
-scheme BugBlock \
-configuration Release \
-destination 'generic/platform=iOS Simulator' \
-archivePath './build/BugBlock.framework-iphonesimulator.xcarchive' \
SKIP_INSTALL=NO \
BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

xcodebuild archive \
-scheme BugBlock \
-configuration Release \
-destination 'generic/platform=iOS' \
-archivePath './build/BugBlock.framework-iphoneos.xcarchive' \
SKIP_INSTALL=NO \
BUILD_LIBRARIES_FOR_DISTRIBUTION=YES


rm -r ./build/BugBlock.xcframework

xcodebuild -create-xcframework \
-framework './build/BugBlock.framework-iphonesimulator.xcarchive/Products/Library/Frameworks/BugBlock.framework' \
-framework './build/BugBlock.framework-iphoneos.xcarchive/Products/Library/Frameworks/BugBlock.framework' \
-output './build/BugBlock.xcframework'

cd build
zip -r BugBlock.xcframework.zip BugBlock.xcframework
rm -r ./build/BugBlock.xcframework
rm -r ./build/BugBlock.framework-iphonesimulator.xcarchive
rm -r ./build/BugBlock.framework-iphoneos.xcarchive
