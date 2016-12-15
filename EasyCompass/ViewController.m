//
//  ViewController.m
//  EasyCompass
//
//  Created by 叶明 on 11/4/16.
//  Copyright © 2016 Ming Yeh. All rights reserved.
//

#import "ViewController.h"
#import "CompassView.h"

@interface ViewController ()

@property(weak,nonatomic) IBOutlet UISwitch *nightModeSwitch;
@property(weak,nonatomic) IBOutlet UISlider *rotateSlider;
@property(weak,nonatomic) IBOutlet UILabel *rotateValue;
@property(weak,nonatomic) IBOutlet UILabel *nightModeLabel;
@property(weak,nonatomic) IBOutlet CompassView *compassView;
@property(assign,nonatomic) CGAffineTransform defaultTransform;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Color configuration
    self.compassView.isInNightMode = NO;
    self.compassView.dayModeBackgroundColor = [UIColor whiteColor];
    self.compassView.dayModeForegroundColor = [UIColor grayColor];
    self.compassView.nightModeBackgroundColor = [UIColor blackColor];
    self.compassView.nightModeForegroundColor = [UIColor whiteColor];
    
    // Border configuration
    self.compassView.padding = 10;
    self.compassView.borderMargin = 40;
    self.compassView.displayOuterBorder = YES;
    self.compassView.displayInnerBorder = YES;
    self.compassView.outerBorderWidth = 4;
    self.compassView.innerBorderWidth = 1;
    
    // Scale configuration
    self.compassView.displayScales = YES;
    self.compassView.displayMinorScales = YES;
    self.compassView.majorScaleCount = 12;
    self.compassView.minorScaleCountBetweenMajorScales = 5;
    self.compassView.majorScaleLength = 12;
    self.compassView.majorScaleWidth = 2;
    self.compassView.minorScaleLength = 8;
    self.compassView.minorScaleWidth = 1;
    
    // Scale digit configuration
    self.compassView.displayMajorScaleDigits = YES;
    UIFont *majorScaleDigitFont = [[UIFont preferredFontForTextStyle:UIFontTextStyleBody] fontWithSize:18];
    self.compassView.majorScaleDigitFont = majorScaleDigitFont;
    self.compassView.majorScaleDigitMargin = 3;
    self.compassView.majorScaleDigitPositions = [NSArray arrayWithObjects: @0, @90, @180, @270, nil];
    self.compassView.majorScaleDigitTexts = [NSArray arrayWithObjects: @"N", @"E", @"S", @"W", nil];
    
    self.compassView.displayMinorScaleDigits = YES;
    UIFont *minorScaleDigitFont = [[UIFont preferredFontForTextStyle:UIFontTextStyleBody] fontWithSize:12];
    self.compassView.minorScaleDigitFont = minorScaleDigitFont;
    self.compassView.minorScaleDigitMargin = 3;
    self.compassView.minorScaleDigitPositions = [NSArray arrayWithObjects: @30, @60, @120, @150, @210, @240, @300, @330, nil];
    self.compassView.minorScaleDigitTexts = [NSArray arrayWithObjects: @"30", @"60", @"120", @"150", @"210", @"240", @"300", @"330",  nil];
    
    [self.compassView setNeedsDisplay];
    self.defaultTransform = [self.compassView transform];
}

-(IBAction)switchNightNode:(UISwitch*)sender{
    self.view.backgroundColor = sender.on ? [UIColor blackColor] : [UIColor whiteColor];
    self.rotateValue.textColor = sender.on ? [UIColor whiteColor] : [UIColor blackColor];
    self.nightModeLabel.textColor = sender.on ? [UIColor whiteColor] : [UIColor blackColor];
    self.compassView.isInNightMode = sender.on;

    self.compassView.transform = self.defaultTransform;
    [self.compassView setNeedsDisplay];
    self.rotateSlider.value = 0;
    self.rotateValue.text = @"000";
}

-(IBAction)slideRotateValue:(UISlider*)sender{
    self.rotateValue.text = [NSString stringWithFormat:@"%.0f",self.rotateSlider.value];
    [UIView animateWithDuration:0.5 animations:^{
        self.compassView.transform = CGAffineTransformMakeRotation(-self.rotateSlider.value * M_PI / 180.0);
    }];
}

@end
