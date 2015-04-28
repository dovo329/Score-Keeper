//
//  NSObject+SKColorCategory.m
//  Score Keeper
//
//  Created by Douglas Voss on 4/28/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "NSObject+SKColorCategory.h"

@implementation NSObject (SKColorCategory)

+ (UIColor *)viewBackground {
    
    return [UIColor colorWithRed:(35/255.0) green:(170/255.0) blue:(150/255.0) alpha:1.0];
    
}

+ (UIColor *)labelBackground {
    
    return [UIColor colorWithRed:(200/255.0) green:(90/255.0) blue:(80/255.0) alpha:1.0];
}

+ (UIColor *)labelText {
    
    return [UIColor colorWithRed:(45/255.0) green:(225/255.0) blue:(180/255.0) alpha:1.0];
}

+ (UIColor *)textFieldBackground {
    
    return [UIColor colorWithRed:(125/255.0) green:(165/255.0) blue:(35/255.0) alpha:1.0];

}

@end
