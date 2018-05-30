//
//  AddBlockerDetector.m
//  liveTvSwift
//
//  Created by Ali Raza on 10/05/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

#import "AddBlockerDetector.h"

@implementation AddBlockerDetector

+ (BOOL)isAddBlockerRunning
{
    NSDictionary *dict = CFBridgingRelease(CFNetworkCopySystemProxySettings());
    NSArray *keys = [dict[@"__SCOPED__"]allKeys];
    for (NSString *key in keys) {
        if ([key rangeOfString:@"tap"].location != NSNotFound ||
            [key rangeOfString:@"tun"].location != NSNotFound ||
            [key rangeOfString:@"ppp"].location != NSNotFound){
            return YES;
        }
    }
    return NO;
}
+(NSString*)getIP
{
    NSString *publicIP = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"https://icanhazip.com/"] encoding:NSUTF8StringEncoding error:nil];
    publicIP = [publicIP stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    return publicIP;
}

@end
