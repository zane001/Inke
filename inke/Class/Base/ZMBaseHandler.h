//
//  ZMBaseHandler.h
//  inke
//
//  Created by zm on 27/11/2016.
//  Copyright © 2016 zm. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompleteBlock) ();
typedef void(^SuccessBlock) (id obj);
typedef void(^FailureBlock) (id obj);

@interface ZMBaseHandler : NSObject


@end
