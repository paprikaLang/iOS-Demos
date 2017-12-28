//
//  ViewController.m
//  SafeArrayTest
//
//  Created by paprika on 2017/12/28.
//  Copyright © 2017年 paprika. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSArray *arrayI;
@property (nonatomic, strong) NSMutableArray *arrayM;
@property (nonatomic, strong) NSArray *array0;
@property (nonatomic, strong) NSArray *singleObjectArrayI;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.arrayI = @[@"a", @"s", @"d", @"f"];
    
    self.arrayM = [self.arrayI mutableCopy];
    
    self.array0 = @[];
    
    self.singleObjectArrayI = @[@"a"];
    
    //测试
    
    NSLog(@"self.array[5]: %@",self.arrayI[4]);
    NSLog(@"[self.array objectAtIndex:4]: %@",[self.arrayI objectAtIndex:4]);
    
    self.arrayM[5] = @4;
    NSLog(@"[self.mArray objectAtIndex:5]: %@",self.arrayM[5]);
    NSLog(@"[self.mArray objectAtIndex:5]: %@",[self.arrayM objectAtIndex:5]);
    
    NSLog(@"self.emptyArray[5]: %@",self.array0[4]);
    NSLog(@"[self.emptyArray objectAtIndex:4]: %@",[self.array0 objectAtIndex:4]);
    
    NSLog(@"self.signalArray[5]: %@",self.singleObjectArrayI[4]);
    NSLog(@"[self.signalArray objectAtIndex:4]: %@",[self.singleObjectArrayI objectAtIndex:4]);
}



@end
