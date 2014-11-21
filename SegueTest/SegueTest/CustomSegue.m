//
//  CustomSegue.m
//  SegueTest
//
//  Created by Levi Brown on 11/21/14.
//  Copyright (c) 2014 Levi Brown. All rights reserved.
//

#import "CustomSegue.h"

@implementation CustomSegue

- (instancetype)initWithIdentifier:(NSString *)identifier source:(UIViewController *)source destination:(UIViewController *)destination
{
    if ((self = [super initWithIdentifier:identifier source:source destination:destination]))
    {
        self.unwind = NO;
    }
    return self;
}

- (void)perform
{
    UIViewController *sourceViewController = self.sourceViewController;
    UIViewController *destinationViewController = self.destinationViewController;
    
    if (self.unwind)
    {
        NSLog(@"CustomSegue- Performing unwind segue.");
        [destinationViewController dismissViewControllerAnimated:NO completion:nil];
    }
    else
    {
        NSLog(@"CustomSegue- Performing forward segue.");
        [sourceViewController presentViewController:destinationViewController animated:NO completion:nil];
    }
}

@end
