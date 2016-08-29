//
//  NUITableViewCellRenderer.m
//  NUIDemo
//
//  Created by Tom Benner on 11/24/12.
//  Copyright (c) 2012 Tom Benner. All rights reserved.
//

#import "NUITableViewCellRenderer.h"

@implementation NUITableViewCellRenderer

+ (void)render:(UITableViewCell*)cell withClass:(NSString*)className
{
    [self renderSizeDependentProperties:cell];
    
    // Set the labels' background colors to clearColor by default, so they don't show a white
    // background on top of the cell background color
    if (cell.textLabel != nil) {
        [cell.textLabel setBackgroundColor:[UIColor clearColor]];
        // Set Font
        [NUIRenderer renderLabel:cell.textLabel withClass:className];
    }
    
    if (cell.detailTextLabel != nil) {
        [cell.detailTextLabel setBackgroundColor:[UIColor clearColor]];
        // Set font
        [NUIRenderer renderLabel:cell.detailTextLabel withClass:className withSuffix:@"Detail"];
    }
    
}

+ (void)sizeDidChange:(UITableViewCell*)cell
{
    [self renderSizeDependentProperties:cell];
}

+ (void)renderSizeDependentProperties:(UITableViewCell*)cell
{
    NSString *className = cell.nuiClass;
    
    // Set background color
    if ([NUISettings hasProperty:@"background-color" withClass:className]) {
        UIImage *colorImage = [NUISettings getImageFromColor:@"background-color" withClass:className];
        cell.backgroundView = [[UIImageView alloc] initWithImage:colorImage];
    }
    
    // Set background gradient
    if ([NUISettings hasProperty:@"background-color-top" withClass:className]) {
        CGPoint startPoint = CGPointMake(0.5f, 0.0f);
        CGPoint endPoint = CGPointMake(0.5f, 1.0f);
        
        if ([NUISettings hasProperty:@"gradient-start-point" withClass:className] && [NUISettings hasProperty:@"gradient-end-point" withClass:className]){
            startPoint = [NUISettings getPoint:@"gradient-start-point" withClass:className];
            endPoint = [NUISettings getPoint:@"gradient-end-point" withClass:className];
        }
        
        UIImage *gradientImage = [NUIGraphics gradientImageWithTop:[NUISettings getColor:@"background-color-top" withClass:className] bottom:[NUISettings getColor:@"background-color-bottom" withClass:className] frame:cell.bounds startP:startPoint endP:endPoint];
        cell.backgroundView = [[UIImageView alloc] initWithImage:gradientImage];
    }
    
    // Set selected background color
    if ([NUISettings hasProperty:@"background-color-selected" withClass:className]) {
        UIImage *colorImage = [NUISettings getImageFromColor:@"background-color-selected" withClass:className];
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:colorImage];
    }
    
    // Set selected background gradient
    if ([NUISettings hasProperty:@"background-color-top-selected" withClass:className]) {
        CGPoint startPoint = CGPointMake(0.5f, 0.0f);
        CGPoint endPoint = CGPointMake(0.5f, 1.0f);
        
        if ([NUISettings hasProperty:@"gradient-start-point" withClass:className] && [NUISettings hasProperty:@"gradient-end-point" withClass:className]){
            startPoint = [NUISettings getPoint:@"gradient-start-point" withClass:className];
            endPoint = [NUISettings getPoint:@"gradient-end-point" withClass:className];
        }
        
        UIImage *gradientImage = [NUIGraphics gradientImageWithTop:[NUISettings getColor:@"background-color-top" withClass:className] bottom:[NUISettings getColor:@"background-color-bottom" withClass:className] frame:cell.bounds startP:startPoint endP:endPoint];
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:gradientImage];
    }
}

@end
