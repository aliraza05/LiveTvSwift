//
//  AddBlockerDetector.h
//  liveTvSwift
//
//  Created by Ali Raza on 10/05/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddBlockerDetector : NSObject

+ (BOOL)isAddBlockerRunning;
+ (NSString*)getIP;
@end
