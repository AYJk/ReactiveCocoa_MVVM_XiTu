//
//  TransparentLabel.m
//  PMXiTu
//
//  Created by AYJk on 16/6/7.
//  Copyright © 2016年 AYJk. All rights reserved.
//

#import "TransparentLabel.h"
@implementation TransparentLabel

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect viewBounds = self.bounds;
    NSString *str = @"AYJkAYJk";
    char *commentsMsg = (char *)[str UTF8String];
    CGContextTranslateCTM(ctx, 0, viewBounds.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextSetBlendMode(ctx, kCGBlendModeCopy);
    CGContextSetRGBFillColor(ctx, 1, 1, 1, 0);
    CGContextSetLineWidth(ctx, 2.0);
    CGContextSelectFont(ctx, "Arial", 20.0, kCGEncodingMacRoman);
    CGContextSetCharacterSpacing(ctx, 1.7);
    CGContextSetTextDrawingMode(ctx, kCGTextFill);
    CGContextShowTextAtPoint(ctx, 0, 50, commentsMsg, strlen(commentsMsg));
//    CFIndex count = CFStringGetLength((CFStringRef)str);
//    CGGlyph *glyphs = (CGGlyph *)malloc(sizeof(CGGlyph) * count);
//    CGContextShowGlyphsAtPoint(ctx, 0, 50, glyphs, str.length);
}

@end
