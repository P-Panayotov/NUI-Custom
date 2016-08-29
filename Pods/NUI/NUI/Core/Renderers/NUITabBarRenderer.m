//
//  NUITabBarRenderer.m
//  NUIDemo
//
//  Created by Tom Benner on 11/24/12.
//  Copyright (c) 2012 Tom Benner. All rights reserved.
//

#import "NUITabBarRenderer.h"

@implementation NUITabBarRenderer

+ (void)render:(UITabBar*)bar withClass:(NSString*)className
{
    if ([NUISettings hasProperty:@"background-image" withClass:className]) {
        [bar setBackgroundImage:[NUISettings getImage:@"background-image" withClass:className]];
    }
    
    if ([NUISettings hasProperty:@"background-tint-color" withClass:className]) {
        [bar setTintColor:[NUISettings getColor:@"background-tint-color" withClass:className]];
    }
    
    if ([NUISettings hasProperty:@"selected-image" withClass:className]) {
        [bar setSelectionIndicatorImage:[NUISettings getImage:@"selected-image" withClass:className]];
    }
    
    if ([NUISettings hasProperty:@"selected-image-tint-color" withClass:className]) {
        [bar setSelectedImageTintColor:[NUISettings getColor:@"selected-image-tint-color" withClass:className]];
    }
    
    [self renderSizeDependentProperties:bar];
    
    // Apply UITabBarItem's background-image-selected property to bar.selectionIndicatorImage
    if ([[bar items] count] > 0) {
        UITabBarItem *firstItem = [[bar items] objectAtIndex:0];
        NSArray *firstItemClasses = [firstItem.nuiClass componentsSeparatedByString: @":"];
        for (NSString *itemClass in firstItemClasses) {
            if ([NUISettings hasProperty:@"background-image-selected" withClass:itemClass]) {
                [bar setSelectionIndicatorImage:[NUISettings getImage:@"background-image-selected" withClass:itemClass]];
            }
        }
    }
}

+ (void)sizeDidChange:(UITabBar*)bar
{
    [self renderSizeDependentProperties:bar];
}

+ (void)renderSizeDependentProperties:(UITabBar*)bar
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
        [bar setBackgroundImage:gradientImage];
    } else if ([NUISettings hasProperty:@"background-color" withClass:className]) {
        CGRect frame = bar.bounds;
        UIImage *colorImage = [NUIGraphics colorImage:[NUISettings getColor:@"background-color" withClass:className] withFrame:frame];
        [bar setBackgroundImage:colorImage];
    }
}

@end
