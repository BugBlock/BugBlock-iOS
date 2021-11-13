# Quick start
BugBlock iOS SDK is providing you with the ability to get quick bug reports from users with network and custom console logs and an automatic crash reporting tool. To start you need to get an SDK token in our [dashbord.bugblock.io](https://dashbord.bugblock.io "dashbord.bugblock.io")


BugBlock iOS SDK is available for at:
- Swift package manager (SPM);
- Cocoa pods;
- import as an xcframework.


## Let`s get started.

#### Swift package manager
Add the following URL to your project. (**XCode->Project->Package dependencies->+**)

```
https://github.com/BugBlock/BugBlock-iOS
```

In the **rules** you need to choose **Branch** and then **main**.

#### Cocoa pods

Add the following pod to you **Podfile**

```swift
pod 'BugBlock'
```

#### Import as a project
You can download the project from the git repository and add it as an xcframework. Our GitHub repository always contains xcframerork builds. 
There are two ways to get it: 
- download latest one from here [github.com/BugBlock/BugBlock-iOS/tree/main/build/BugBlock.xcframework](https://github.com/BugBlock/BugBlock-iOS/tree/main/build/BugBlock.xcframework "github.com/BugBlock/BugBlock-iOS/tree/main/build/BugBlock.xcframework")


## First start

After importing an SDK you need to import project in your AppDelegate:
```swift
import BugBlock
```

Then start an SDK:
```swift
var config = BBConfiguration()
BBLog.start(appId: "Your SDK token", configuration: config)
```

You're done.

