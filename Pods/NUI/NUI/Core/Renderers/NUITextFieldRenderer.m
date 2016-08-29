//
//  NUITextFieldRenderer.m
//  NUIDemo
//
//  Created by Tom Benner on 11/24/12.
//  Copyright (c) 2012 Tom Benner. All rights reserved.
//

#import "NUITextFieldRenderer.h"
#import "NUIViewRenderer.h"

@implementation NUITextFieldRenderer

+ (void)render:(UITextField*)textField withClass:(NSString*)className
{
    if ([NUISettings hasFontPropertiesWithClass:className]) {
        [textField setFont:[NUISettings getFontWithClass:className baseFont:textField.font]];
    }
    
    // Set font color
    if ([NUISettings hasProperty:@"font-color" withClass:className]) {
        [textField setTextColor:[NUISettings getColor:@"font-color" withClass:className]];
    }
    
    // Set background color
    if ([NUISettings hasProperty:@"background-color" withClass:className]) {
        [textField setBackgroundColor:[NUISettings getColor:@"background-color" withClass:className]];
    }
    
    // Set background gradient
    if ([NUISettings hasProperty:@"background-color-top" withClass:className]) {
        CGPoint startPoint = CGPointMake(0.5f, 0.0f);
        CGPoint endPoint = CGPointMake(0.5f, 1.0f);
        
        if ([NUISettings hasProperty:@"gradient-start-point" withClass:className] && [NUISettings hasProperty:@"gradient-end-point" withClass:className]){
            startPoint = [NUISettings getPoint:@"gradient-start-point" withClass:className];
            endPoint = [NUISettings getPoint:@"gradient-end-point" withClass:className];
        }
        
        UIImage *gradientImage = [NUIGraphics gradientImageWithTop:[NUISettings getColor:@"background-color-top" withClass:className] bottom:[NUISettings getColor:@"background-color-bottom" withClass:className] frame:textField.bounds startP:startPoint endP:endPoint];
        [textField setBackground:gradientImage];
    }
    
    // Set background image
    if ([NUISettings hasProperty:@"background-image" withClass:className]) {
        [textField setBackground:[NUISettings getImage:@"background-image" withClass:className]];
    }
    
    if ([NUISettings hasProperty:@"vertical-align" withClass:className]) {
        [textField setContentVerticalAlignment:[NUISettings getControlContentVerticalAlignment:@"vertical-align" withClass:className]];
    }

    // Set border style
    if ([NUISettings hasProperty:@"border-style" withClass:className]) {
        [textField setBorderStyle:[NUISettings getBorderStyle:@"border-style" withClass:className]];
    }

    [NUIViewRenderer renderSize:textField withClass:className];
    [NUIViewRenderer renderBorder:textField withClass:className];
    [NUIViewRenderer renderShadow:textField withClass:className];
}

@end
