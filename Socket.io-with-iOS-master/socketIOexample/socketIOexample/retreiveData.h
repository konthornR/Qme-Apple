//
//  retreiveData.h
//  socketIOexample
//
//  Created by Nipoon Sintoowong on 23/7/58.
//  Copyright © พ.ศ. 2558 saturngod. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface retreiveData : NSObject
@property (nonatomic,strong) NSMutableArray *jsonArray;
@property (nonatomic,strong) NSMutableArray *QrArray;

-(void)retreive;
@end
