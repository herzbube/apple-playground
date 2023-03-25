# apple-playground

Coding experiments on Apple platforms (mainly iOS).

Code you find in this repository is public domain - do with it whatever you want. No warranty, nor even a guarantee that it runs.

Current experiments:

* [extended-layout](extended-layout/README.md): This project contains code that deals with the "extended layout" concept introduced by Apple in iOS 7.
* [core-graphics](core-graphics/README.md): This project provides a user interface that lets the user interactively explore Core Graphics drawing functions.


## How to create a new iOS project without storyboard

When a new experiment is started for iOS, the steps in this chapter help to get the Xcode project up and running with a minimum of fuss. The steps were written for Xcode 13.2.1.

### Project creation

- Create a new project
- Select the "App" template
- Walk through the wizard and accept all default settings
- Save the project


### Delete files

Delete the following files that you will not need anymore.

- SceneDelegate.h
- SceneDelegate.m
- Main.storyboard

### Modify `AppDelegate.h`

Add this property declaration:

    @property (strong, nonatomic) UIWindow *window;

### Modify `AppDelegate.m`

Remove everything in the section "UISceneSession lifecycle".

Add this line at the top:

    #import "ViewController.h"

Add the following code to `application:didFinishLaunchingWithOptions:()`

```
UIViewController* rootViewController = [[ViewController alloc] init];
UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];

self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
self.window.rootViewController = navigationController;

[self.window makeKeyAndVisible];
```

### Modify project settings

Select the project, then select he project's single target.

- On the "Signing & Capabilities" tab look for the "Team" drop down. Select a valid team to allow building with codesigning. This may only be necessary to deploy to a real device.
- On the "General" tab look for the "Main Interface" text box. Remove the string "Main" which refers to the storyboard file that was deleted.
- On the "Info" tab look for an entry named "Application Scene Manifest" in the list of Info.plist entries. Delete the entire entry (including all content below it).

That's it, the project should now build and run on a simulator and display a black window.