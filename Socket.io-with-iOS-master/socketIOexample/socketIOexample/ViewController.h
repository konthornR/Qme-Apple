//
//  ViewController.h
//  socketIOexample
//
//  Created by Htain Lin Shwe on 21/10/13.
//  Copyright (c) 2013 saturngod. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocketIO.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "BackgroundTask.h"
#import "retreiveData.h"
#import <SDWebImage/UIImageView+WebCache.h>
NSString*testQrcode;
NSString* token;
NSArray *news;
NSString *QrRead; //String ในฟอร์ม json ที่อ่านมาจาก Qr code
NSString *Qr; // string ที่ชื่อว่า touch to scan...
NSString *Qr2; // string ที่ชื่อว่า กดเพ่ือแสกน...
NSString *socketidCode; // Socket id รับจาก server
NSString *Qrcode;
NSString *CompanyID; // companyid จากสแกน
NSString *clickOrNot; // accept queue?
NSString*imgarray;
int*count;
int*countAd;

UIImage *fivepic; // รูป
UIImage *fourpic;// รูป
UIImage *threepic;// รูป
UIBackgroundTaskIdentifier newTaskId;
NSString*call;
BOOL* whichalert;
NSString* whichAlerts;

UIColor * colorOne ;
UIColor * colorTwo ;
UIColor * colorThree ;

@interface ViewController : UIViewController <SocketIODelegate,AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *Advertise;

@property (weak, nonatomic) IBOutlet UIView *viewPreview;
@property (nonatomic,strong) SocketIO* socketIO;
@property (weak, nonatomic) IBOutlet UIButton *QRimgHide;

@property (weak, nonatomic) IBOutlet UIImageView *QRimgButt;
@property (weak, nonatomic) IBOutlet UILabel *QrLabel;

@property (weak, nonatomic) IBOutlet UILabel *QrLabel2;
@property (weak, nonatomic) IBOutlet UIImageView *waitingImg;

@property (nonatomic,strong) NSMutableArray *jsonArray;
@property (nonatomic,strong) NSMutableArray *QrArray;



- (IBAction)QrButton:(id)sender;


-(void) heartbeatTimerCallback:(id)info;
@end

@interface UIColor (JPExtras)
+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha;
@end

//.m file
@implementation UIColor (JPExtras)
+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha {
    return [UIColor colorWithRed:(red/255.0) green:(green/255.0) blue:(blue/255.0) alpha:alpha];
}
@end
