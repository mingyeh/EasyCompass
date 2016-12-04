//
//  CompassView.m
//  EasyCompass
//
//  Created by 叶明 on 11/4/16.
//  Copyright © 2016 Ming Yeh. All rights reserved.
//

#import "CompassView.h"
#import "Math.h"

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
    
    //Handle the night mode
    if(self.isInNightMode){
        CGContextAddRect(context, self.frame);
        CGContextSetFillColorWithColor(context,self.nightModeBackgroundColor.CGColor);
        CGContextFillPath(context);
        CGContextSetStrokeColorWithColor(context, self.nightModeForegroundColor.CGColor);
    }
    else{
        CGContextAddRect(context, self.frame);
        CGContextSetFillColorWithColor(context,self.dayModeBackgroundColor.CGColor);
        CGContextFillPath(context);
        CGContextSetStrokeColorWithColor(context, self.dayModeForegroundColor.CGColor);
    }
    
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
        CGFloat radius = diameter / 2;
        for(int i = 0; i < self.majorScaleCount; i++){
            float scale = i * majorStep * M_PI / 180;
            
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
                    float minorScale = (i * majorStep + j * minorStep) * M_PI / 180;
                    
                    CGFloat xOfMinorScale1 = self.padding + radius + radius * cosf(minorScale);
                    CGFloat yOfMinorScale1 = self.padding + radius - radius * sinf(minorScale);
                    CGFloat xOfMinorScale2 = self.padding + radius + (radius - self.minorScaleLength) * cosf(minorScale);
                    CGFloat yOfMinorScale2 = self.padding + radius - (radius - self.minorScaleLength) * sinf(minorScale);
                    
                    CGContextSetLineWidth(context, self.minorScaleWidth);
                    CGContextMoveToPoint(context, xOfMinorScale1, yOfMinorScale1);
                    CGContextAddLineToPoint(context, xOfMinorScale2, yOfMinorScale2);
                    CGContextStrokePath(context);
                }
            }
        }
    }
}


@end
