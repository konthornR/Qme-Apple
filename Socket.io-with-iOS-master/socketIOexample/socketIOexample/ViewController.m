//
//  ViewController.m
//  socketIOexample
//
//  Created by Htain Lin Shwe on 21/10/13.
//  Copyright (c) 2013 saturngod. All rights reserved.
//

#import "ViewController.h"
#import "SocketIOPacket.h"
#import "BackgroundTask.h"
#import "retreiveData.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface ViewController ()

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic) BOOL isReading;
@property (nonatomic, readwrite, copy) NSString *socketidCode;
@property (nonatomic, readwrite, copy) NSString *CompanyID;



-(BOOL)startReading;
-(void)stopReading;
-(void)loadBeepSound;

@end

@implementation ViewController
@synthesize jsonArray,QrArray;
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    

    _waitingImg.hidden = YES;
    
    
    countAd=0;
    whichAlerts = @"1";
    [self changingLoadImg3];
    [self changingLoadImg2];
    [self changingLoadImg];
   
    
    UIColor * colorOne = [UIColor colorWithRed:33/255.0f green:129/255.0f blue:184/255.0f alpha:1.0f];
    UIColor * colorTwo = [UIColor colorWithRed:33/255.0f green:101/255.0f blue:163/255.0f alpha:1.0f];    UIColor * colorThree = [UIColor colorWithRed:33/255.0f green:53/255.0f blue:147/255.0f alpha:1.0f];
    
     //[[UILabel appearance] setFont:[UIFont fontWithName:@"AvenirNextCondensed-Medium " size:17.0]];
    
//    UIGraphicsBeginImageContext(self.view.frame.size);
//    [[UIImage imageNamed:@"bgbim.png"] drawInRect:self.view.bounds];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
//    self.viewPreview.backgroundColor = [UIColor colorWithPatternImage:image];
// 
  
//    
//    [self.QrLabel setTextColor:[UIColor whiteColor]];
//    [self.QrLabel setBackgroundColor:[UIColor clearColor]];
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.frame = self.QrLabel.bounds;
//    [gradientLayer setColors:[NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor,nil]];
//    gradientLayer.endPoint=CGPointMake(1.0, 0.0);
//       [self.QrLabel.layer addSublayer:gradientLayer];
  
   
    NSTimer *timer = [NSTimer timerWithTimeInterval:5.1
                                             target:self
                                           selector:@selector(onTimer)
                                           userInfo:nil
                                            repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [timer fire];
    

   
   
    
    
    // Initially make the captureSession object nil.
    _captureSession = nil;
    
    // Set the initial value of the flag to NO.
    _isReading = NO;
      // Begin loading the sound effect so to have it ready for playback when it's needed.
    [self loadBeepSound];
    if (_audioPlayer) {
        
           //     [_audioPlayer play];
      
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
       
        
    }
    
//    // request extra running time in background for ranging
//    __block UIBackgroundTaskIdentifier background_task;
//    UIApplication *application = [UIApplication sharedApplication];
//    
//    background_task = [application beginBackgroundTaskWithExpirationHandler:^ {
//        NSLog(@"cleanup code for end of background allowed running time");
//        [application endBackgroundTask: background_task];
//        background_task = UIBackgroundTaskInvalid;
//    }];
//    
//    // run background loop in a separate process
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSLog(@"start of background loop");
//        while (TRUE)
//        {
//            NSTimeInterval remaining = [[UIApplication sharedApplication] backgroundTimeRemaining];
//            // background audio resets remaining time
//            if (remaining < 60) {
//                //  [self speakMessageWithString:@"up"];
//                
//                [_audioPlayer play];
//
//            }
//            [NSThread sleepForTimeInterval:1]; //wait for 1 sec
//        }
//        NSLog(@"end of background loop");
//        [application endBackgroundTask: background_task];
//        background_task = UIBackgroundTaskInvalid;
//    });

   
    count = 0;

   Qr = @"Touch to Scan Qme";
    Qr2 = @"กดเพื่อแสกน Qr Code ที่หน้าร้าน";
 //       Qr2 = @"อีก 2 คิว";
    _QrLabel.font = [UIFont fontWithName:@"Franklin Gothic Book" size:18];
    _QrLabel2.font = [UIFont fontWithName:@"Franklin Gothic Book" size:15];

   _QrLabel.text = Qr;
    _QrLabel2.text = Qr2;
  
    
  
    
    
//    NSDictionary *dict = @{@"key" : @"value"};
//    NSData *jsonDicdata = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
//   NSLog(@"%@", [[NSString alloc] initWithData:jsonDicdata encoding:NSUTF8StringEncoding]);
 
   
    
       _socketIO = [[SocketIO alloc] initWithDelegate:self];
    [_socketIO connectToHost:@"murmuring-fjord-5701.herokuapp.com" onPort:80];
    [_socketIO sendEvent:@"test connection" withData:@"iOSuser"];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)sendMsg:(id)sender {
//    [_socketIO sendEvent:@"message" withData:_chatbox.text];
//    [self addNewEventWithNickName:@"iOSuser" AndMessage:_chatbox.text];
//    _chatbox.text = @"";
    [_socketIO sendEvent:@"test connection" withData:@"iOSuser"];
    

}

-(void)changingLoadImg{
   // NSString*uu = @"http://duiclub.5gbfree.com/promo/fuji_promo3.jpg";
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
  
    [manager downloadWithURL:@"http://duiclub.5gbfree.com/promo/fuji_promo3.jpg"
                     options:0
                    progress:^(NSInteger receivedSize, NSInteger expectedSize)
     {
         // progression tracking code
     }
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished)
     {
         if (image)
         {
             // do something with image
             //_Advertise.image = image;
             fivepic  = image;
             
         }
     }];
}
-(void)changingLoadImg2{
    SDWebImageManager *manager2 = [SDWebImageManager sharedManager];
    
    [manager2 downloadWithURL:@"http://duiclub.5gbfree.com/promo/fuji_promo2.jpg"
                     options:0
                    progress:^(NSInteger receivedSize2, NSInteger expectedSize2)
     {
         // progression tracking code
     }
                   completed:^(UIImage *image2, NSError *error, SDImageCacheType cacheType, BOOL finished)
     {
         if (image2)
         {
             // do something with image
             //_Advertise.image = image;
             fourpic  = image2;
           
             
         }
     }];
    }
-(void)changingLoadImg3{
    SDWebImageManager *manager3 = [SDWebImageManager sharedManager];
    
    [manager3 downloadWithURL:@"http://duiclub.5gbfree.com/promo/fuji_promo.jpg"
                      options:0
                     progress:^(NSInteger receivedSize2, NSInteger expectedSize2)
     {
         // progression tracking code
     }
                    completed:^(UIImage *image3, NSError *error, SDImageCacheType cacheType, BOOL finished)
     {
         if (image3)
         {
             // do something with image
             //_Advertise.image = image;
             threepic  = image3;
             
         }
     }];
}

-(void)addNewEventWithNickName:(NSString*)nickname AndMessage:(NSString*)message
{
 //   _chatLog.text = [_chatLog.text stringByAppendingFormat:@"%@ - %@\n",nickname,message];
 
}

-(void)onTimer{
    [UIView animateWithDuration:1.0 animations:^{
        _Advertise.alpha = 0.0;
        
    }];
    [UIView animateWithDuration:1.0 animations:^{
        _Advertise.alpha = 1.0;
        
        
        
        
            }];
}
# pragma mark -
# pragma mark socket.IO-objc delegate methods

- (void) socketIODidConnect:(SocketIO *)socket
{
    NSLog(@"socket.io connected.");
    
 
}

- (void) socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet
{
    NSLog(@"didReceiveEvent()");
    NSLog(@"in here");
    if([packet.name isEqualToString:@"message"])
    {
        NSArray* args = packet.args;
        NSDictionary* arg = args[0];
        
        [self addNewEventWithNickName:arg[@"nickname"] AndMessage:arg[@"message"]];
        
    }
      else if ([packet.name isEqualToString:@"socket id connection"])
    {
     
        if ([_QrLabel.text rangeOfString:@"CompanyId"].location == NSNotFound) {
            NSLog(@"string does not contain bla");
        } else {
            NSLog(@"string contains bla!");
        }
        
        NSArray* args = packet.args;
        NSDictionary* arg = args[0];
        NSLog(@"---------------");
        NSLog(arg[@"SocketId"]);
        socketidCode = arg[@"SocketId"];
        NSLog(@"f--f--f--");
        NSLog(socketidCode);
        [_socketIO sendEvent:@"test connection" withData:@"Duiclub"];

        
        // [self addNewEventWithNickName:arg[@"SocketId"] AndMessage:arg[@"message"]];
        
    }
    
      else if ([packet.name isEqualToString:@"test connection back"])
      {
        
          
          
          NSLog(@"test connection back");
          _Advertise.animationImages=[NSArray arrayWithObjects:
                                      //                                [UIImage imageNamed:@"shabupic.jpg"],
                                      //
                                      //                                [UIImage imageNamed:@"QrPic.png"],
                                      
                                      //  onePic,
                                      threepic,
                                      
                                      fivepic,fourpic,nil
                                      ];
          
          _Advertise.animationDuration=20.0;
          _Advertise.animationRepeatCount=0;
          [ _Advertise startAnimating];
          [self.view addSubview: _Advertise];
          
          if(socketidCode!= nil){
              NSLog(token);
              NSString*start =  @"{\"";
              NSString*send01 = [NSString stringWithFormat:@"%@%@",start,Qrcode];
              NSString*send02 = [NSString stringWithFormat:@"%@%@",send01,@"\",\""];
              NSString*send03 = [NSString stringWithFormat:@"%@%@",send02,CompanyID];
              
              NSString*send04 = [NSString stringWithFormat:@"%@%@",send03,@"\",\"PushNotificationToken\":\""];
              NSString*send05 = [NSString stringWithFormat:@"%@%@",send04,token];
              
              
              NSString*send06 = [NSString stringWithFormat:@"%@%@",send05,@"\",\"SocketId\":\""];
              NSString*send07 = [NSString stringWithFormat:@"%@%@",send06,socketidCode];
              
              NSString*send08 = [NSString stringWithFormat:@"%@%@",send07,@"\"}"];
              
              NSLog(send08);
              
              
              
              
              [_socketIO sendEvent:@"customer register code" withData:send08];
          }
          
      }
      else if ([packet.name isEqualToString:@"call queue"])
      {
          NSLog(@"call queue");
          NSArray* args = [[NSArray alloc]init];
          args = packet.args;
          
          NSDictionary* arg = args[0];
          
          NSLog(@"---------------");
        
         
          
          
            NSString *strFromInt =  [NSString stringWithFormat:@"%@",arg[@"QueueNumber"]];
          
          if([strFromInt isEqualToString: @"1"]){
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
              whichAlerts = @"2";
              [self addAlertView];
              [_audioPlayer play];
              NSString*calling2 = @"อีก ";
              NSString*calling3 = [NSString stringWithFormat:@"%@%@",calling2,strFromInt];
              NSString*final = [NSString stringWithFormat:@"%@%@", calling3,@" คิว"];
              
              _QrLabel2.text = final;
            
          }
          
          else if([strFromInt isEqualToString: @"0"]){
           
              
              _QrLabel2.text = @"ถึงคิวของคุณแล้วค่ะ";
              _waitingImg.hidden = YES;
                Qrcode = nil;
              CompanyID = nil;
              QrRead = nil;
              socketidCode = nil;
              clickOrNot = nil;
              
          }
          else{
              
              NSString*calling2 = @"อีก ";
              NSString*calling3 = [NSString stringWithFormat:@"%@%@",calling2,strFromInt];
              NSString*final = [NSString stringWithFormat:@"%@%@", calling3,@" คิว"];
              
              _QrLabel2.text = final;
              _waitingImg.hidden = NO;
             

            
             
          }
          
      }

    
      else if ([packet.name isEqualToString:@"customer information"])
      {
          NSLog(@"customer information");
          NSArray* args = packet.args;
          NSDictionary* arg = args[0];
          NSLog(@"---------------");
          NSLog(arg[@"NumberOfSeats"]);
          NSLog(arg[@"Name"]);
          NSLog(arg[@"GroupColor"]);
             NSString *Queue =  [NSString stringWithFormat:@"%@",arg[@"QueueNumber"]];
      //    NSLog(arg[@"QueueNumber"]);
          NSString*name =arg[@"Name"];
        NSString*appearlabel =    [NSString stringWithFormat:@"%@%@",name,@"\n"];
     //  appearlabel =    [NSString stringWithFormat:@"%@%@",appearlabel,@"reserved for "];
     //   appearlabel =  [NSString stringWithFormat:@"%@%@",appearlabel,arg[@"NumberOfSeats"]];
      //     appearlabel = [NSString stringWithFormat:@"%@%@",appearlabel,@" guest(s)"];
          appearlabel = [NSString stringWithFormat:@"%@%@",appearlabel,@"จองสำหรับ "];
        appearlabel =  [NSString stringWithFormat:@"%@%@",appearlabel,arg[@"NumberOfSeats"]];
          _QrLabel.text = [NSString stringWithFormat:@"%@%@",appearlabel,@" ท่าน"];
         // _QrLabel2.text = @"โปรดรอการเรียกคิวค่ะ";
          NSString*calling2 = @"อีก ";
          NSString*calling3 = [NSString stringWithFormat:@"%@%@",calling2,Queue];
          NSString*final = [NSString stringWithFormat:@"%@%@", calling3,@" คิว"];
          _waitingImg.hidden = NO;
          _QrLabel2.text =  final;
        
              }
   
    
     }

- (void) socketIO:(SocketIO *)socket onError:(NSError *)error
{
    NSLog(@"onError() %@", error);
}


- (void) socketIODidDisconnect:(SocketIO *)socket disconnectedWithError:(NSError *)error
{
    NSLog(@"socket.io disconnected. did error occur? %@", error);
    
    _socketIO = [[SocketIO alloc] initWithDelegate:self];
    [_socketIO connectToHost:@"murmuring-fjord-5701.herokuapp.com" onPort:80];
    [_socketIO sendEvent:@"test connection" withData:@"iOSuser"];
    
}


- (IBAction)QrButton:(id)sender {
    //check ก่อนว่า scan จากร้านรึยัง
    if (Qrcode!= nil) {
        whichAlerts = @"3";
        count=0;
        [self addAlertView];
        
    }

    if(Qrcode==nil){
    if (!_isReading) {
        // This is the case where the app should read a QR code when the start button is tapped.
             _QRimgButt.hidden = YES;
        if ([self startReading]) {
            // If the startReading methods returns YES and the capture session is successfully
            // running, then change the start button title and the status message.
//            [_bbitemStart setTitle:@"Stop"];
//            [_lblStatus setText:@"Scanning for QR Code..."];
          
        }
    }
    else{
        // In this case the app is currently reading a QR code and it should stop doing so.
        [self stopReading];
        
         _QRimgButt.hidden = NO;
       
        
        
   

    
        // The bar button item's title should change again.
      //  [_bbitemStart setTitle:@"Start!"];
    }
    }
        // Set to the flag the exact opposite value of the one that currently has.
    _isReading = !_isReading;
}


#pragma mark - Private method implementation


- (BOOL)startReading {
    NSError *error;
    
    // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video
    // as the media type parameter.
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Get an instance of the AVCaptureDeviceInput class using the previous device object.
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!input) {
        // If any error occurs, simply log the description of it and don't continue any more.
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    
    // Initialize the captureSession object.
    _captureSession = [[AVCaptureSession alloc] init];
    // Set the input device on the capture session.
    [_captureSession addInput:input];
    
    
    // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];
    
    // Create a new serial dispatch queue.
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:_viewPreview.layer.bounds];
    [_viewPreview.layer addSublayer:_videoPreviewLayer];
    
    
    
    // Start video capture.
    [_captureSession startRunning];
    
     return YES;
}




-(void)stopReading{
    // Stop video capture and make the capture session object nil.
      [self loadBeepSound];
    [_captureSession stopRunning];
    _captureSession = nil;
    
    // Remove the video preview layer from the viewPreview view's layer.
    [_videoPreviewLayer removeFromSuperlayer];
    count++;
    whichAlerts = @"1";
    NSLog([NSString stringWithFormat:@"%d",count]);
    if(count==12){
        [self addAlertView];
    
    }
    
   // [self performSelectorOnMainThread:@selector(addAlertView) withObject:nil waitUntilDone:NO];
  
    
}


-(void)loadBeepSound{
    // Get the path to the beep.mp3 file and convert it to a NSURL object.
    //NSString *beepFilePath = [[NSBundle mainBundle] pathForResource:@"beep" ofType:@"mp3"];
    NSString *beepFilePath = [[NSBundle mainBundle] pathForResource:@"Queue" ofType:@"mp3"];
    NSURL *beepURL = [NSURL URLWithString:beepFilePath];
    
    NSError *error;
    
    // Initialize the audio player object using the NSURL object previously set.
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:beepURL error:&error];
    if (error) {
        // If the audio player cannot be initialized then log a message.
        NSLog(@"Could not play beep file.");
        NSLog(@"%@", [error localizedDescription]);
    }
    
    else{
        // If the audio player was successfully initialized then load it in memory.
        [_audioPlayer prepareToPlay];
        NSLog(@"in sound");    }
}


#pragma mark - AVCaptureMetadataOutputObjectsDelegate method implementation

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    // Check if the metadataObjects array is not nil and it contains at least one object.
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        
        // Get the metadata object.
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            // If the found metadata is equal to the QR code metadata then update the status label's text,
            // stop reading and change the bar button item's title and the flag's value.
            // Everything is done on the main thread.
            
            
//            [_QrLabel performSelectorOnMainThread:@selector(setText:) withObject:[metadataObj stringValue] waitUntilDone:NO];
           
            
            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
            
            _isReading = NO;
         
         //   QrRead = _QrLabel.text;
            QrRead = [metadataObj stringValue] ;
            NSLog(@"duiclub");
            
              NSLog(QrRead);
            
            [_QrLabel performSelectorOnMainThread:@selector(setText:) withObject:Qr waitUntilDone:NO];
           
            
        }
        
    }
    
    
}

-(void)addAlertView{
    if([whichAlerts isEqual: @"1"]){
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                              @"Qme" message:@"ยืนยันการเข้าคิว?" delegate:self
                                             cancelButtonTitle:@"ยกเลิก" otherButtonTitles:@"ตกลง", nil];
        
        [alertView show];
    }
    if ([whichAlerts isEqual:@"2"]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                  @"Qme" message:@"คิวต่อไปคือคิวของคุณ\nยืนยันการเข้าคิว?" delegate:self
                                                 cancelButtonTitle:@"ยกเลิก" otherButtonTitles:@"ตกลง", nil];
        
        [alertView show];
    }
    
    
    if ([whichAlerts isEqual:@"3"]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                  @"Qme" message:@"คุณต้องการยกเลิกการเข้าคิวที่ได้จองไว้หรือไม่?" delegate:self
                                                 cancelButtonTitle:@"ต้องการยกเลิก" otherButtonTitles:@"ไม่ยกเลิก", nil];
        
        [alertView show];
    }
    
    //[alertView show];
    
}





#pragma mark - Alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:
(NSInteger)buttonIndex{
    if([whichAlerts isEqual:@"1"]){
    switch (buttonIndex) {
        case 1:
            NSLog(@"Accept button clicked");
            clickOrNot = @"accept";
          
            if([clickOrNot isEqual:@"accept"]){

               

                NSString*ror = @"{\"QrFind\":[";
                NSString*ror2 = @"]}";
                NSString*complete = [NSString stringWithFormat:@"%@%@",ror,QrRead];
                NSString*complete2 = [NSString stringWithFormat:@"%@%@",complete,ror2];
               
                
                
                NSData*data = [complete2 dataUsingEncoding:NSUTF8StringEncoding];
                NSString *newstr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            
                NSError *error;
                NSMutableDictionary *allcourses = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                NSArray *QrFinder = allcourses[@"QrFind"];
                
                for (NSDictionary *thecourse in QrFinder) {
                    NSLog(@"Id: %@",thecourse[@"Id"]);
                    NSString*tete = [NSString stringWithFormat:@"Id\": \"%@",thecourse[@"Id"]];
                   NSString*tete2 = [NSString stringWithFormat:@"CompanyId\": \"%@",thecourse[@"CompanyId"] ];
                    testQrcode = [NSString stringWithFormat:@"%@",thecourse[@"Id"]];
                   Qrcode = tete;
                    CompanyID = tete2;
                
                }
               
                NSLog(socketidCode);
                NSLog(CompanyID);
            
                 [_socketIO sendEvent:@"test connection" withData:@"iOSuser"];
//              NSString*start =  @"{\"";
//                NSString*send01 = [NSString stringWithFormat:@"%@%@",start,Qrcode];
//                 NSString*send02 = [NSString stringWithFormat:@"%@%@",send01,@"\",\""];
//                 NSString*send03 = [NSString stringWithFormat:@"%@%@",send02,CompanyID];
//                 NSString*send04 = [NSString stringWithFormat:@"%@%@",send03,@"\",\"SocketId\":\""];
//                 NSString*send05 = [NSString stringWithFormat:@"%@%@",send04,socketidCode];
//                 NSString*send06 = [NSString stringWithFormat:@"%@%@",send05,@"\"}"];
//                
//
                
  
                NSLog(token);
                NSString*start =  @"{\"";
                NSString*send01 = [NSString stringWithFormat:@"%@%@",start,Qrcode];
                NSString*send02 = [NSString stringWithFormat:@"%@%@",send01,@"\",\""];
                NSString*send03 = [NSString stringWithFormat:@"%@%@",send02,CompanyID];
                
                NSString*send04 = [NSString stringWithFormat:@"%@%@",send03,@"\",\"PushNotificationToken\":\""];
                NSString*send05 = [NSString stringWithFormat:@"%@%@",send04,token];
                
                
                NSString*send06 = [NSString stringWithFormat:@"%@%@",send05,@"\",\"SocketId\":\""];
                NSString*send07 = [NSString stringWithFormat:@"%@%@",send06,socketidCode];
               
                NSString*send08 = [NSString stringWithFormat:@"%@%@",send07,@"\"}"];
                
                NSLog(send08);
                
             

                
                [_socketIO sendEvent:@"customer register code" withData:send08];

            }
            break;
        case 0:
            NSLog(@"cancel button clicked");
            clickOrNot = @"cancel";
            NSLog(clickOrNot);
            count=0;
            break;
            
        default:
            NSLog(@"logging in def");
            break;
            
    }
        }
    if([whichAlerts isEqual:@"2"]){
        switch (buttonIndex) {
            case 1:
                NSLog(@"confirm button clicked");
                clickOrNot = @"confirm";
                NSLog(clickOrNot);
               
                break;
            case 0:
                NSLog(@"cancel button clicked");
                clickOrNot = @"cancel";
                NSLog(clickOrNot);
                
                NSString*start =  @"{\"";
                NSString*send01 = [NSString stringWithFormat:@"%@%@",start,Qrcode];
                NSString*send02 = [NSString stringWithFormat:@"%@%@",send01,@"\"}"];
                
                [_socketIO sendEvent:@"request cancel queue" withData:send02];
                count=0;
                Qrcode = nil;
                CompanyID = nil;
                QrRead = nil;
               //socketidCode = nil;
                clickOrNot = nil;
                _QrLabel.text = Qr;
                _QrLabel2.text = Qr2;
                   _waitingImg.hidden = YES;
                break;
                
                
        }
    }


    if([whichAlerts isEqual:@"3"]){
        switch (buttonIndex) {
            case 0:
                NSLog(@"confirm button clicked");
                clickOrNot = @"confirm";
               
                if([clickOrNot isEqual:@"confirm"]){
                    NSString*start =  @"{\"";
                    NSString*send01 = [NSString stringWithFormat:@"%@%@",start,Qrcode];
                    NSString*send02 = [NSString stringWithFormat:@"%@%@",send01,@"\"}"];
                    
                    [_socketIO sendEvent:@"request cancel queue" withData:send02];
                    count=0;
                    Qrcode = nil;
                    CompanyID = nil;
                    QrRead = nil;
                    //socketidCode = nil;
                    clickOrNot = nil;
                    _QrLabel.text = Qr;
                    _QrLabel2.text = Qr2;
                    _waitingImg.hidden = YES;
                                          if ([self startReading]) {
                            // If the startReading methods returns YES and the capture session is successfully
                            // running, then change the start button title and the status message.
                            //            [_bbitemStart setTitle:@"Stop"];
                            //            [_lblStatus setText:@"Scanning for QR Code..."];
                            
                        
                    }

                    
                }
                break;
            case 1:
                NSLog(@"cancel button clicked");
                
                              break;
                
                
        }
    }
    

    
}



@end
