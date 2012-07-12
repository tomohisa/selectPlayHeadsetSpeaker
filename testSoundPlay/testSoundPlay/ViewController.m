//
//  ViewController.m
//  testSoundPlay
//
//  Created by Tomohisa Takaoka on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioServices.h>

@interface ViewController ()

@end

@implementation ViewController{
    AVAudioPlayer *player;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    AudioSessionInitialize(NULL, NULL, NULL, NULL);
    UInt32 sessionCategory = kAudioSessionCategory_PlayAndRecord; // 1
    AudioSessionSetProperty (
                             kAudioSessionProperty_AudioCategory, // 2
                             sizeof (sessionCategory), // 3
                             &sessionCategory // 4
                             );
    
    UInt32 ASRoute = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty (
                             kAudioSessionProperty_OverrideAudioRoute,
                             sizeof (ASRoute),
                             &ASRoute
                             );
    AudioSessionSetActive(YES);
    
    NSString* path = path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"wav"];
    NSURL* url = [NSURL fileURLWithPath:path];
    player= [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    player.numberOfLoops = -1;
    [player play];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(IBAction)actionChangeHeadsetOrSpeaker:(UISwitch*)sender{
    if (!sender.on) {
        UInt32 ASRoute = kAudioSessionOverrideAudioRoute_Speaker;
        AudioSessionSetProperty (
                                 kAudioSessionProperty_OverrideAudioRoute,
                                 sizeof (ASRoute),
                                 &ASRoute
                                 );
    }else {
        UInt32 ASRoute = kAudioSessionOverrideAudioRoute_None;
        AudioSessionSetProperty (
                                 kAudioSessionProperty_OverrideAudioRoute,
                                 sizeof (ASRoute),
                                 &ASRoute
                                 );

    }
}

@end
