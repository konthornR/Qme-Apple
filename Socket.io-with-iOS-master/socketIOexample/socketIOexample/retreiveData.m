//
//  retreiveData.m
//  socketIOexample
//
//  Created by Nipoon Sintoowong on 23/7/58.
//  Copyright © พ.ศ. 2558 saturngod. All rights reserved.
//

#import "retreiveData.h"

@implementation retreiveData
@synthesize jsonArray,QrArray;

-(void )retreive: (NSString*)dd{
    NSString*ror = @"{\"QrFind\":[";
    NSString*ror2 = @"]}";
    NSString*complete = [NSString stringWithFormat:@"%@%@",ror,dd];
    NSString*complete2 = [NSString stringWithFormat:@"%@%@",complete,ror2];
    
    
    
    NSData*data = [complete2 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *newstr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSError *error;
    NSMutableDictionary *allcourses = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    NSArray *QrFinder = allcourses[@"QrFind"];
    
    
    
    //
    for (NSDictionary *thecourse in QrFinder) {
        
        NSLog(@"CompanyId: %@",thecourse[@"CompanyId"]);
        NSLog(@"Id: %@",thecourse[@"Id"]);
    }

    
}


    





@end
