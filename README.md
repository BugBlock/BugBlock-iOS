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

After importing an SDK you need to import the project in your AppDelegate:
```swift
import BugBlock
```

Then start an SDK:
```swift
var config = BBConfiguration()
BBLog.start(appId: "Your SDK token", configuration: config)
```

You're done.



# Configurations

Once you are already done with the initial setup. Let's go through some tips that may help you configure SDK to your needs.

Before starting SDK we need to create configuration. Struct `BBConfiguration` is responsible for the SDK configuration. All properties are `false` by default. If you need to enable something just pass true to respective property. Here is full list of possible properties:

```swift
var config = BBConfiguration()
config.consoleLoggingEnabled = false
config.serverLoggingEnabled = true
config.crashReportingEnabled = true
config.invokeByScreenshot = true
config.invokeByShake = true
```

All are self-describing but one is special it's `serverLoggingEnabled` it should be used with network configuration only, otherwise, it will not take any effect.

## Network configuration

To set up network request and response logging you need to pass the `URLSessionConfiguration` instance to the SDK:
```swift
let conf = URLSessionConfiguration.default
BBLog.networkLogging(with: conf)
let session = URLSession(configuration: conf)
```

Keep in mind, to handle all network logs you need to use the `session` that you created above.


## Console logging

To prevent you from reading long lists of console logs produced by the iOS application. You can pass only the logs you need. It's pretty easy to make a custom console log: 

```swift
BBLog.consoleLog(string: "Error description", logLevel: .error)
```

To make it easy to differentiate log by level we've created those levels:

`debug`, 
`info`, 
`warning`, 
`error`


## User identity

If you want to identify a user when he reports an issue it will be easier to do with the user identity feature. There is two function that can help you to recognize a user in the report: 

```swift
BBLog.user(name: "Test name")
BBLog.user(email: "info@example.com")
```


## Silent reports 

By using this feature you can also send a silent report with user acknowledgment

```swift
BBLog.report()
```
