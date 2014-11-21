SegueTest
===========

This is a test application to illustrate an issue with UITabBarController and custom rewind segues. This has been posted to Stack Overflow: [http://stackoverflow.com/questions/27069709/using-a-custom-unwind-segue-from-within-a-uitabbarcontrollers-more-tab](http://stackoverflow.com/questions/27069709/using-a-custom-unwind-segue-from-within-a-uitabbarcontrollers-more-tab)

#### The Question

How can we work around the fact that `UITabBarController` is replacing our `UINavigationController` when our tab is in the "More" tab, such that we can return our custom unwind `UIStoryboardSegue` from our overriden `segueForUnwindingToViewController:fromViewController:identifier:`?

#### The Goal

The goal is to use a custom `UIStoryboardSegue` for an "unwind" segue, in a situation where the presenting View Controller is in a `UINavigationController` hierarchy, and that hierarchy is represented by one tab on a UITabBarController.

#### The Issues

1. Installing a custom unwind segue requires the unwind target, or presenting View Controller, to override `segueForUnwindingToViewController:fromViewController:identifier:` and supply an instance of the `UIStoryboardSegue` to use.

    In the case of the presenting View Controller being in a `UINavigationController` hierarchy this gets slightly more complicated since the `UINavigationController` is actually the object who's `segueForUnwindingToViewController:fromViewController:identifier:` gets called.
    
    To work around this, one must (seemingly) sub-class `UINavigationController` and override `segueForUnwindingToViewController:fromViewController:identifier:` to call its children view controllers' `segueForUnwindingToViewController:fromViewController:identifier:`. This workaround comes from a Stack Overflow answer, which comes, presumably, from Apple's DTS: [http://stackoverflow.com/a/16844573/397210](http://stackoverflow.com/a/16844573/397210), and I've verified this does indeed correct this issue. Essentially, your `UINavigationController` subclass would contain something similar to this code:
    
        - (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier
        {
            return [self.topViewController segueForUnwindingToViewController:toViewController fromViewController:fromViewController identifier:identifier];
        }

    Which sends the `segueForUnwindingToViewController:fromViewController:identifier:` message to the navigation controller's `topViewController`.

2. `UITabBarController` seemingly replaces a tab's `UINavigationController` with its own private `UIMoreNavigationController` when that tab is in the "More" section of the tab bar.

    This is problematic. Due to issue #1 we must have custom code in the navigation controller to delegate the `segueForUnwindingToViewController:fromViewController:identifier:` call to our implementation so we can return an instance of the custom `UIStoryboardSegue` we want to use for the unwind. However, since the `UITabBarController` *replaces* our `UINavigationController` with its own (in the "More" case), our code does not get called, we are unable to return a custom instance of `UIStoryboarSegue`, and we seem to be stuck.

#### Environment

iOS 8.1, Xcode 6.1 (6A1052d)

#### Sample Application

This repository contains a sample application which illustrates this issue clearly.

The main entry point is a `UITabBarController` which has six tabs installed. When run on the iPhone 5s, in portrait mode, this will be enough tabs to force the last two into a "More" tab which is created by the `UITabBarController`.

The last tab is called "Problematic" and exhibits the issues described, which can be noted by the animated dismissal of the modal view controller, which is the default segue behavior (the custom segue performs no animations).

The first tab is called "OK" and is exactly the same as the "Problematic" tab, except that it is not relegated to the "More" tab. In this case, the custom unwind segue is executed, which can be noted by the lack of animation when dismissing the modal view controller.

### Illustrative Steps

1. Run the project in the iPhone 5s simulator, in portrait mode.
2. NOTE: the initial tab is the "OK" tab.
3. Tap "Next VC" on the green view which will modally present a view controller with a red view with a "Back" button.
4. Tap "Back" on the red view and note you are retuned to the green view *without* animation.
5. Tap on the "More" tab.
6. Tap on the "Problematic" table cell.
7. Tap "Next VC" on the green view which will modally present a view controller with a red view with a "Back" button.
8. Tap "Back" on the red view and note you are retuned to the green view *with* the standard animation.

#### Disclaimer and Licence

* This work is licensed under the [Creative Commons Attribution 3.0 Unported License](http://creativecommons.org/licenses/by/3.0/).
  Please see the included LICENSE.txt for complete details.

#### About
A professional iOS engineer by day, my name is Levi Brown. Authoring a technical blog
[grokin.gs](http://grokin.gs), I am reachable via:

Twitter [@levigroker](https://twitter.com/levigroker)  
App.net [@levigroker](https://alpha.app.net/levigroker)  
Email [levigroker@gmail.com](mailto:levigroker@gmail.com)  

Your constructive comments and feedback are always welcome.
