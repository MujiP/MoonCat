# README

When you open the project for the first time, select a simulator device, or plug in your iPhone and select that. Build the project (cmd + B on Mac) to see that it builds successfully, and that you don't have any code signing errors.

You can run it by clicking the play button (or cmd + R on Mac). When you run, it will build first, then it will run the app on the device you specified.

You can build without running, to check that everything compiles properly. If a build succeeds, it means there are no compile errors. You can't run an app that doesn't even build. If a build failed, it'll show you what the errors were. An error is shown as a red icon, which you can click for more info. Sometimes the info has a fix button, which will fix the error for you automatically.

iOS apps have a single entry point. When you want to test a particular view controller, go into AppDelegate.swift and change the window's root view controller property to an instance of whatever view controller you want to display.

Feel free to create 'playground' view controllers to test things out ex. Playground_VC, Playground2_VC, etc.

When you want to make a new view controller (UIViewController subclass), go to File > New > File, and choose Cocoa Touch Class, then indicate UIViewController as the superclass.

When you want to make your own type that doesn't need to inherit from an iOS type, go to File > New > File, and choose Swift File.

