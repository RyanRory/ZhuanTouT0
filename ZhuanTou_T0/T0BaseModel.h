//
//  T0BaseModel.h
//  ZhuanTou_T0
//
//  Created by 赵润声 on 16/5/23.
//  Copyright © 2016年 Shanghai Momu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface T0BaseModel : NSObject

+ (void)saveToPlist:(NSString*)fileName data:(id)data;
+ (id)readFromPlist:(NSString*)fileName;
+ (void)saveToUserDefaults:(id)object key:(NSString*)str;
+ (id)readFromUserDefaultsForKey:(NSString*)str;

@end
