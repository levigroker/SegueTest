//
//  ProxyNavigationController.m
//  SegueTest
//
//  Created by Levi Brown on 11/21/14.
//  Copyright (c) 2014 Levi Brown. All rights reserved.
//

#import "ProxyNavigationController.h"

@implementation ProxyNavigationController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        NSLog(@"ProxyNavigationController- initWithCoder:");
    }
    return self;
}

// We want to defer to our child view controller(s) as to what unwind segue to use
//Based on http://stackoverflow.com/a/16844573/397210
- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier
{
    NSLog(@"ProxyNavigationController- segueForUnwindingToViewController:fromViewController:identifier:");

    //TODO: We should probably look down our list of view controllers and find the appropriate one, rather than assuming the top is what we want
    UIViewController *controller = self.topViewController;
    UIStoryboardSegue *retVal = [controller segueForUnwindingToViewController:toViewController fromViewController:fromViewController identifier:identifier];
    return retVal;
}

@end
