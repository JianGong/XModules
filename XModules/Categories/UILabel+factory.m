//
//  UILabel+factory.m
//  SXClient
//
//  Created by iBcker on 13-11-6.
//
//

#import "UILabel+factory.h"

@implementation UILabel (factory)

+(UILabel*)defaultLb{
    UILabel *lb=[[UILabel alloc] init];
    lb.backgroundColor=[UIColor clearColor];
    return lb;
}

@end
