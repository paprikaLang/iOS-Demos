//
//  NSMutableArray+Safe.m
//  SafeArrayTest
//
//  Created by paprika on 2017/12/28.
//  Copyright © 2017年 paprika. All rights reserved.
//

#import "NSMutableArray+Safe.h"
#import "Swizzling.h"
@implementation NSMutableArray (Safe)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzlingMethod(objc_getClass("__NSArrayM"),@selector(setObject:atIndexedSubscript:) , @selector(arrayM_setObject:atIndexedSubscript:));
    });
    
}
-(void)arrayM_setObject:(id)str atIndexedSubscript:(NSUInteger)index{
    if (index < self.count) {
        [self arrayM_setObject:str atIndexedSubscript:index];
    }else{
        NSLog(@"index %lu beyond bounds",(unsigned long)index);
    }
    
}

@end
