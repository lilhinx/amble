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

@interface MotiveIconButtonView : UIButton

@property (nonatomic,strong) UIImageView* iconView;

- (UIImage*)walkIcon;

@end

@implementation MotiveIconButtonView

- (UIImage*)walkIcon
{
	return [[UIImage imageNamed:@"WalkingIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if( self )
	{
		self.iconView = [[UIImageView alloc] initWithImage:nil];
		self.iconView.contentMode = UIViewContentModeCenter;
		[self addSubview:self.iconView];
	}
	return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	self.iconView.frame = self.bounds;
	self.iconView.center = CGPointMake( CGRectGetMidX( self.bounds ), CGRectGetMidY( self.bounds ) );
}

- (UIEdgeInsets)alignmentRectInsets
{
	return UIEdgeInsetsMake( 0, 16.0f, 0, 0 );
}


@end

@interface MotiveIconButtonItem : UIBarButtonItem

+ (MotiveIconButtonItem*)icon;

@property (nonatomic,assign) BOOL showWalkIcon;

- (void)updateIcon;

@end

@implementation MotiveIconButtonItem

+ (MotiveIconButtonItem*)icon
{
	CGRect r = CGRectZero;
	r = CGRectMake( 0.0f, 0.0f, 44.0f, 44.0f );
	MotiveIconButtonView* v = [[MotiveIconButtonView alloc] initWithFrame:r];
	return [[MotiveIconButtonItem alloc] initWithCustomView:v];
}

- (void)updateIcon
{
	MotiveIconButtonView* v = (MotiveIconButtonView*)self.customView;
	if( self.showWalkIcon )
	{
		v.iconView.image = [v walkIcon];
		return;
	}
	
	v.iconView.image = nil;
}

- (void)setShowWalkIcon:(BOOL)showWalkIcon
{
	_showWalkIcon = showWalkIcon;
	[self updateIcon];
}


@end

@interface ViewController( )

@property (nonatomic,strong) MotiveIconButtonItem* motiveItem;

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
//    
//	[[Amble steps] subscribeNext:^( AmbleStepsMessage* msg ) {
//       
//        NSString* msgDisplay = [NSString stringWithFormat:@"%@\n", msg.steps];
//        self.textView.text = [self.textView.text stringByAppendingString:msgDisplay];
//		
//    }];
//    
//    [[Amble walkingSpeed] subscribeNext:^( NSNumber* speed )
//    {
//        NSString* msgDisplay = [NSString stringWithFormat:@"speed %@\n", speed];
//        self.textView.text = [self.textView.text stringByAppendingString:msgDisplay];
//    }];
	
	self.motiveItem = [MotiveIconButtonItem icon];
	RAC(self.motiveItem, showWalkIcon ) = [Amble isAmbulatory];
	self.toolbarItems = @[self.motiveItem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
