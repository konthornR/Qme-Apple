//
//  AppDelegate.m
//  socketIOexample
//
//  Created by Htain Lin Shwe on 21/10/13.
//  Copyright (c) 2013 saturngod. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

//- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//     //Let the device know we want to receive push notifications
//    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
//        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge
//                                                                                                              categories:nil]];
//    
//    }    return YES;
//}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    //-- Set Notification
    if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
    {
        // iOS 8 Notifications
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [application registerForRemoteNotifications];
    }
    else
    {
        // iOS < 8 Notifications
        [application registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
    }
    //--- your custom code
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
   
    
//        NSDate *alarmTime = [[NSDate date] dateByAddingTimeInterval:5.0];
//    UIApplication* app = [UIApplication sharedApplication];
//    UILocalNotification *notifyAlarm = [[UILocalNotification alloc]init];
//    if(notifyAlarm){
//        notifyAlarm.fireDate = alarmTime;
//        notifyAlarm.timeZone = [NSTimeZone defaultTimeZone];
//        notifyAlarm.repeatInterval = 0;
//        notifyAlarm.soundName = @"Queue.aiff";
//        // @"chime.aiff";
//        notifyAlarm.alertBody = @"Your queue is alomost ready";
//        [app scheduleLocalNotification:notifyAlarm];
//    }
    
    
    


}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    UIApplication*app = [UIApplication sharedApplication];
    NSArray*oldNotifications = [app scheduledLocalNotifications];
    if([oldNotifications count]>0){
        [app cancelAllLocalNotifications];
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSLog(@"My token is: %@", deviceToken);
    token = [[deviceToken description]stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    // token = (deviceToken);
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}

@end
