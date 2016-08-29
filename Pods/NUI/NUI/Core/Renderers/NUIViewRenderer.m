//
//  NUIViewRenderer.m
//  NUIDemo
//
//  Created by Tom Benner on 11/24/12.
//  Copyright (c) 2012 Tom Benner. All rights reserved.
//

#import "NUIViewRenderer.h"

@implementation NUIViewRenderer

+ (void)render:(UIView*)view withClass:(NSString*)className
{
    if ([NUISettings hasProperty:@"background-image" withClass:className]) {
        if ([NUISettings hasProperty:@"background-repeat" withClass:className] && ![NUISettings getBoolean:@"background-repeat" withClass:className]) {
            view.layer.contents = (__bridge id)[NUISettings getImage:@"background-image" withClass:className].CGImage;
        } else {
            [view setBackgroundColor: [NUISettings getColorFromImage:@"background-image" withClass: className]];
        }
    } else if ([NUISettings hasProperty:@"background-color" withClass:className]) {
        [view setBackgroundColor: [NUISettings getColor:@"background-color" withClass: className]];
    } else if ([NUISettings hasProperty:@"background-color-top" withClass:className]) {
            
            CGPoint startPoint = CGPointMake(0.5f, 0.0f);
            CGPoint endPoint = CGPointMake(0.5f, 1.0f);
            
            if ([NUISettings hasProperty:@"gradient-start-point" withClass:className] && [NUISettings hasProperty:@"gradient-end-point" withClass:className]){
                startPoint = [NUISettings getPoint:@"gradient-start-point" withClass:className];
                endPoint = [NUISettings getPoint:@"gradient-end-point" withClass:className];
            }
        
        UIImage *gradientImage = [NUIGraphics gradientImageWithTop:[NUISettings getColor:@"background-color-top" withClass:className] bottom:[NUISettings getColor:@"background-color-bottom" withClass:className] frame:view.bounds startP:startPoint endP:endPoint];
        UIImageView *bg = [[UIImageView alloc]initWithFrame:view.bounds];
        [view insertSubview:bg atIndex:0];
        bg.translatesAutoresizingMaskIntoConstraints = NO;
        [view addConstraint:[NSLayoutConstraint constraintWithItem:bg attribute:NSLayoutAttributeWidth relatedBy:0 toItem:view attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
        [view addConstraint:[NSLayoutConstraint constraintWithItem:bg attribute:NSLayoutAttributeHeight relatedBy:0 toItem:view attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
        [view addConstraint:[NSLayoutConstraint constraintWithItem:bg attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        [view addConstraint:[NSLayoutConstraint constraintWithItem:bg attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
        [bg setImage:gradientImage];
        
    }

    [self renderSize:view withClass:className];
    [self renderBorder:view withClass:className];
    [self renderShadow:view withClass:className];
}

+ (void)renderBorder:(UIView*)view withClass:(NSString*)className
{
    CALayer *layer = [view layer];
    
    if ([NUISettings hasProperty:@"border-color" withClass:className]) {
        [layer setBorderColor:[[NUISettings getColor:@"border-color" withClass:className] CGColor]];
    }
    
    if ([NUISettings hasProperty:@"border-width" withClass:className]) {
        [layer setBorderWidth:[NUISettings getFloat:@"border-width" withClass:className]];
    }
    
    if ([NUISettings hasProperty:@"corner-radius" withClass:className]) {
        [layer setCornerRadius:[NUISettings getFloat:@"corner-radius" withClass:className]];
        layer.masksToBounds = YES;
    }
}

+ (void)renderShadow:(UIView*)view withClass:(NSString*)className
{
    CALayer *layer = [view layer];
    
    if ([NUISettings hasProperty:@"shadow-radius" withClass:className]) {
        [layer setShadowRadius:[NUISettings getFloat:@"shadow-radius" withClass:className]];
    }
    
    if ([NUISettings hasProperty:@"shadow-offset" withClass:className]) {
        [layer setShadowOffset:[NUISettings getSize:@"shadow-offset" withClass:className]];
    }
    
    if ([NUISettings hasProperty:@"shadow-color" withClass:className]) {
        [layer setShadowColor:[NUISettings getColor:@"shadow-color" withClass:className].CGColor];
    }
    
    if ([NUISettings hasProperty:@"shadow-opacity" withClass:className]) {
        [layer setShadowOpacity:[NUISettings getFloat:@"shadow-opacity" withClass:className]];
    }
}

+ (void)renderSize:(UIView*)view withClass:(NSString*)className
{
    CGFloat height = view.frame.size.height;
    if ([NUISettings hasProperty:@"height" withClass:className]) {
        height = [NUISettings getFloat:@"height" withClass:className];
    }
    
    CGFloat width = view.frame.size.width;
    if ([NUISettings hasProperty:@"width" withClass:className]) {
        width = [NUISettings getFloat:@"width" withClass:className];
    }

    if (height != view.frame.size.height || width != view.frame.size.width) {
        view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, width, height);
    }
}

+ (BOOL)hasShadowProperties:(UIView*)view withClass:(NSString*)className {
    
    BOOL hasAnyShadowProperty = NO;
    for (NSString *property in @[@"shadow-radius", @"shadow-offset", @"shadow-color", @"shadow-opacity"]) {
        hasAnyShadowProperty |= [NUISettings hasProperty:property withClass:className];
    }
    return hasAnyShadowProperty;
}

@end
