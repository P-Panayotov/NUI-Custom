//
//  NUINavigationBarRenderer.m
//  NUIDemo
//
//  Created by Tom Benner on 11/24/12.
//  Copyright (c) 2012 Tom Benner. All rights reserved.
//

#import "NUINavigationBarRenderer.h"

@implementation NUINavigationBarRenderer

+ (void)render:(UINavigationBar*)bar withClass:(NSString*)className
{
    if ([bar respondsToSelector:@selector(setBarTintColor:)]) {
        if ([NUISettings hasProperty:@"bar-tint-color" withClass:className]) {
            [bar setBarTintColor:[NUISettings getColor:@"bar-tint-color" withClass:className]];
        }
    }
    
    if ([NUISettings hasProperty:@"background-tint-color" withClass:className]) {
        [bar setTintColor:[NUISettings getColor:@"background-tint-color" withClass:className]];
    }

    if ([NUISettings hasProperty:@"background-image" withClass:className]) {
        [bar setBackgroundImage:[NUISettings getImage:@"background-image" withClass:className] forBarMetrics:UIBarMetricsDefault];
    }
    if ([NUISettings hasProperty:@"shadow-image" withClass:className]) {
        [bar setShadowImage:[NUISettings getImage:@"shadow-image" withClass:className]];
    }

    NSString *property = @"title-vertical-offset";
    if ([NUISettings hasProperty:property withClass:className]) {
        float offset = [NUISettings getFloat:property withClass:className];
        [bar setTitleVerticalPositionAdjustment:offset forBarMetrics:UIBarMetricsDefault];
    }

    [self renderSizeDependentProperties:bar];

    NSDictionary *titleTextAttributes = [NUIUtilities titleTextAttributesForClass:className];

    if ([[titleTextAttributes allKeys] count] > 0) {
        bar.titleTextAttributes = titleTextAttributes;
    }
}

+ (void)sizeDidChange:(UINavigationBar*)bar
{
    [self renderSizeDependentProperties:bar];
}

+ (void)renderSizeDependentProperties:(UINavigationBar*)bar
{
    NSString *className = bar.nuiClass;

    if ([NUISettings hasProperty:@"background-color-top" withClass:className]) {
        CGRect frame = bar.bounds;
        CGPoint startPoint = CGPointMake(0.5f, 0.0f);
        CGPoint endPoint = CGPointMake(0.5f, 1.0f);
        
        if ([NUISettings hasProperty:@"gradient-start-point" withClass:className] && [NUISettings hasProperty:@"gradient-end-point" withClass:className]){
            startPoint = [NUISettings getPoint:@"gradient-start-point" withClass:className];
            endPoint = [NUISettings getPoint:@"gradient-end-point" withClass:className];
        }
        
        UIImage *gradientImage = [NUIGraphics gradientImageWithTop:[NUISettings getColor:@"background-color-top" withClass:className] bottom:[NUISettings getColor:@"background-color-bottom" withClass:className] frame:frame startP:startPoint endP:endPoint];
        [bar setBackgroundImage:gradientImage forBarMetrics:UIBarMetricsDefault];
    } else if ([NUISettings hasProperty:@"background-color" withClass:className]) {
        CGRect frame = bar.bounds;
        UIImage *colorImage = [NUIGraphics colorImage:[NUISettings getColor:@"background-color" withClass:className] withFrame:frame];
        [bar setBackgroundImage:colorImage forBarMetrics:UIBarMetricsDefault];
    }
}

@end
