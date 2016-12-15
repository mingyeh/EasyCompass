//
//  CompassView.h
//  EasyCompass
//
//  Created by 叶明 on 11/4/16.
//  Copyright © 2016 Ming Yeh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@interface CompassView : UIView

//Whether the compass is displayed in "Night Mode"
@property(assign,nonatomic)BOOL isInNightMode;

//Color settings
@property(strong,nonatomic)UIColor* dayModeForegroundColor;
@property(strong,nonatomic)UIColor* dayModeBackgroundColor;
@property(strong,nonatomic)UIColor* nightModeForegroundColor;
@property(strong,nonatomic)UIColor* nightModeBackgroundColor;

//Border settings
@property(assign,nonatomic)CGFloat padding;
@property(assign,nonatomic)CGFloat borderMargin; // the margin between inner border and outer border
@property(assign,nonatomic)BOOL displayOuterBorder;
@property(assign,nonatomic)BOOL displayInnerBorder;
@property(assign,nonatomic)CGFloat outerBorderWidth;
@property(assign,nonatomic)CGFloat innerBorderWidth;

//Scale settings
@property(assign,nonatomic)BOOL displayScales;
@property(assign,nonatomic)BOOL displayMinorScales;
@property(assign,nonatomic)int majorScaleCount;
@property(assign,nonatomic)int minorScaleCountBetweenMajorScales;
@property(assign,nonatomic)CGFloat majorScaleWidth;
@property(assign,nonatomic)CGFloat minorScaleWidth;
@property(assign,nonatomic)CGFloat majorScaleLength;
@property(assign,nonatomic)CGFloat minorScaleLength;

//Scale digit settings
@property(assign,nonatomic)BOOL displayMajorScaleDigits;
@property(assign,nonatomic)BOOL displayMinorScaleDigits;
@property(strong,nonatomic)UIFont *majorScaleDigitFont;
@property(strong,nonatomic)UIFont *minorScaleDigitFont;
@property(assign,nonatomic)CGFloat majorScaleDigitMargin;
@property(assign,nonatomic)CGFloat minorScaleDigitMargin;
@property(retain,nonatomic)NSArray* majorScaleDigitPositions;
@property(retain,nonatomic)NSArray* majorScaleDigitTexts;
@property(retain,nonatomic)NSArray* minorScaleDigitPositions;
@property(retain,nonatomic)NSArray* minorScaleDigitTexts;

@end
