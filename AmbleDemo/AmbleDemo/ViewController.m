//
//  ViewController.m
//  AmbleDemo
//
//  Created by Chris Hinkle on 2/26/14.
//  Copyright (c) 2014 Chris Hinkle. All rights reserved.
//

#import "ViewController.h"
#import "Amble.h"
#import "Amble+Ambulation.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	[[Amble steps] subscribeNext:^( AmbleStepsMessage* msg ) {
       
        NSString* msgDisplay = [NSString stringWithFormat:@"%@\n", msg.steps];
        self.textView.text = [self.textView.text stringByAppendingString:msgDisplay];
    }];
    
    [[Amble walkingSpeed] subscribeNext:^( NSNumber* speed )
    {
        NSString* msgDisplay = [NSString stringWithFormat:@"speed %@\n", speed];
        self.textView.text = [self.textView.text stringByAppendingString:msgDisplay];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
