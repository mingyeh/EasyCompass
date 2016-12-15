//
//  CompassView.m
//  EasyCompass
//
//  Created by 叶明 on 11/4/16.
//  Copyright © 2016 Ming Yeh. All rights reserved.
//

#import "CompassView.h"
#import "Math.h"
#import <CoreText/CoreText.h>

@implementation CompassView

- (void)drawRect:(CGRect)rect {
    //Get context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Get radius of the compass
    CGFloat diameter;
    if (self.frame.size.height > self.frame.size.width){
        diameter = self.frame.size.width - self.padding * 2;
    }
    else{
        diameter = self.frame.size.height - self.padding * 2;
    }
    CGFloat radius = diameter / 2;
    
    //Handle the night mode
    CGContextAddRect(context, self.frame);
    CGColorRef backgoundColor = self.isInNightMode ? self.nightModeBackgroundColor.CGColor : self.dayModeBackgroundColor.CGColor;
    CGColorRef foregroundColor = self.isInNightMode ? self.nightModeForegroundColor.CGColor : self.dayModeForegroundColor.CGColor;
    CGContextSetFillColorWithColor(context,backgoundColor);
    CGContextFillPath(context);
    CGContextSetStrokeColorWithColor(context, foregroundColor);
    
//    CFRelease(backgoundColor);
//    CFRelease(foregroundColor);
    
    //Draw outer border
    if(self.displayOuterBorder){
        CGContextAddEllipseInRect(context, CGRectMake(self.padding, self.padding, diameter, diameter));
        CGContextSetLineWidth(context, self.outerBorderWidth);
        
        CGContextStrokePath(context);
    }
    
    //Draw inner border
    if(self.displayInnerBorder){
        CGContextAddEllipseInRect(context, CGRectMake(self.padding + self.borderMargin, self.padding + self.borderMargin, diameter - self.borderMargin * 2, diameter - self.borderMargin * 2));
        CGContextSetLineWidth(context, self.innerBorderWidth);
        
        CGContextStrokePath(context);
    }
    
    //Drae scales
    if(self.displayScales){
        float majorStep = 360.0 / self.majorScaleCount;
        
        for(int i = 0; i < self.majorScaleCount; i++){
            float scale = (90 - i * majorStep) * M_PI / 180;
            
            CGFloat xOfScale1 = self.padding + radius + radius * cosf(scale);
            CGFloat yOfScale1 = self.padding + radius - radius * sinf(scale);
            CGFloat xOfScale2 = self.padding + radius + (radius - self.majorScaleLength) * cosf(scale);
            CGFloat yOfScale2 = self.padding + radius - (radius - self.majorScaleLength) * sinf(scale);
            
            CGContextSetLineWidth(context, self.majorScaleWidth);
            CGContextMoveToPoint(context, xOfScale1, yOfScale1);
            CGContextAddLineToPoint(context, xOfScale2, yOfScale2);
            CGContextStrokePath(context);
            
            //Draw minor scale
            if(self.displayMinorScales){
                float minorStep = majorStep / self.minorScaleCountBetweenMajorScales;
                for(int j = 1; j < self.minorScaleCountBetweenMajorScales; j++){
                    float minorScale = (90 - i * majorStep - j * minorStep) * M_PI / 180;
                    
                    CGFloat xOfMinorScale1 = self.padding + radius + radius * cosf(minorScale);
                    CGFloat yOfMinorScale1 = self.padding + radius - radius * sinf(minorScale);
                    CGFloat xOfMinorScale2 = self.padding + radius + (radius - self.minorScaleLength) * cosf(minorScale);
                    CGFloat yOfMinorScale2 = self.padding + radius - (radius - self.minorScaleLength) * sinf(minorScale);
                    
                    CGContextSetLineWidth(context, self.minorScaleWidth);
                    CGContextMoveToPoint(context, xOfMinorScale1, yOfMinorScale1);
                    CGContextAddLineToPoint(context, xOfMinorScale2, yOfMinorScale2);
                    CGContextStrokePath(context);
                } // end of minor scale for loop
            } // end of minor scale if statement
        } // end of major scale for loop
    } // end of major scale if statement
    
    // Draw Scale Digit
    if(self.displayMajorScaleDigits){
        if([self.majorScaleDigitPositions count] == [self.majorScaleDigitTexts count]){
            for(int i = 0; i < [self.majorScaleDigitPositions count]; i++){
                float pos = [[self.majorScaleDigitPositions objectAtIndex:i] floatValue];
                NSString *digit = [self.majorScaleDigitTexts objectAtIndex:i];
                
                CFStringRef majorScaleDigitFontName = (__bridge CFStringRef)self.majorScaleDigitFont.fontName;
                CGFloat majorScaleDigitFontSize = self.majorScaleDigitFont.pointSize;
                CTFontRef majorScaleDigitFontRef = CTFontCreateWithName(majorScaleDigitFontName, majorScaleDigitFontSize, NULL);
                NSMutableAttributedString *attributeMajorScaleDigit = [[NSMutableAttributedString alloc] initWithString:digit];
                NSDictionary *majorScaleDigitDict = @{
                                          (__bridge id)kCTForegroundColorAttributeName:(__bridge id)foregroundColor,
                                          (__bridge id)kCTFontAttributeName: (__bridge id)majorScaleDigitFontRef
                                          };
                [attributeMajorScaleDigit setAttributes:majorScaleDigitDict range:NSMakeRange(0, digit.length)];
                CGSize majorScaleDigitSize = [attributeMajorScaleDigit size];
                
                CGFloat majorScaleDigitX = self.padding + radius + (radius - self.majorScaleLength - self.majorScaleDigitMargin) * cosf((90 - pos) * M_PI / 180.0) + majorScaleDigitSize.width * cosf((180 - pos) * M_PI / 180.0) / 2;
                CGFloat majorScaleDigitY = self.padding + radius - (radius - self.majorScaleLength - self.majorScaleDigitMargin) * sinf((90 - pos) * M_PI / 180.0) - majorScaleDigitSize.width * sinf((180 - pos) * M_PI / 180.0) / 2;
                
                CGContextTranslateCTM(context, majorScaleDigitX, majorScaleDigitY);
                CGContextRotateCTM(context, pos * M_PI / 180.0);
                
                [attributeMajorScaleDigit drawInRect:CGRectMake(0, 0, majorScaleDigitSize.width, majorScaleDigitSize.height)];
                
                CGContextRotateCTM(context, -pos * M_PI / 180.0);
                CGContextTranslateCTM(context, -majorScaleDigitX, -majorScaleDigitY);

            } // end of major scale digit for loop
        } // end of if 'major scale digit pos" and "major scale digit text" equal
    } // end of major scale digit if statement
}


@end
