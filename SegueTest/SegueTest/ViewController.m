//
//  ViewController.m
//  SegueTest
//
//  Created by Levi Brown on 11/21/14.
//  Copyright (c) 2014 Levi Brown. All rights reserved.
//

#import "ViewController.h"
#import "CustomSegue.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)rewind:(UIStoryboardSegue *)segue
{
    NSLog(@"ViewController- rewind: %@", segue);
}

- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier
{
    NSLog(@"ViewController- segueForUnwindingToViewController:fromViewController:identifier:");
    
    UIStoryboardSegue *retVal = nil;
    
    CustomSegue *segue = [[CustomSegue alloc] initWithIdentifier:identifier source:fromViewController destination:toViewController];
    segue.unwind = YES;
    retVal = segue;
    
    return retVal;
}

@end
