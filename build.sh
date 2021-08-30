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

zip -r ./build/BugBlock.xcframework.zip ./build/BugBlock.xcframework

rm -r ./build/BugBlock.framework-iphonesimulator.xcarchive
rm -r ./build/BugBlock.framework-iphoneos.xcarchive
