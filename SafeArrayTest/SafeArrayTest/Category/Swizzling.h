//
//  Swizzling.h
//  SafeArrayTest
//
//  Created by paprika on 2017/12/28.
//  Copyright © 2017年 paprika. All rights reserved.
//

#ifndef Swizzling_h
#define Swizzling_h

#include <objc/runtime.h>

static inline void swizzlingMethod(Class clazz, SEL originalSelector, SEL exchangeSelector) {
 
    Method originalMethod = class_getInstanceMethod(clazz, originalSelector);
  
    Method exchangeMethod = class_getInstanceMethod(clazz, exchangeSelector);
    
    if (class_addMethod(clazz, originalSelector, method_getImplementation(exchangeMethod), method_getTypeEncoding(exchangeMethod))) {
        class_replaceMethod(clazz, exchangeSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod, exchangeMethod);
    }
    
}

#endif /* Swizzling_h */
