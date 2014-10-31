//
//  ViewController.m
//  YoutubePlayer
//
//  Created by Rajesh on 27/08/14.
//  Copyright (c) 2014 Rajesh. All rights reserved.
//

#import "ViewController.h"
#import "CheckNetwork.h"

@interface ViewController ()
{
    
}
@end

@implementation ViewController
@synthesize Frame1Button, Frame2Button, Player1, Player2;


- (void)viewDidLoad
{
    [super viewDidLoad];

    Frame1Button.hidden = NO;
    Frame2Button.hidden = NO;
    
    [self YoutubePlayer1];
    [self YoutubePlayer2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


//-- Youtube player
-(void)YoutubePlayer1
{
    //-- Vedio id eg: end string of youtube url
    NSString *videoId = @"impZ7krcPzI";
    self.Player1.delegate = self;
    NSDictionary *playerVars = @{
                                 @"controls" : @1,
                                 @"playsinline" : @1,
                                 @"autohide" : @1,
                                 @"showinfo" : @1,
                                 @"modestbranding" : @1
                                 };
    [self.Player1 loadWithVideoId:videoId playerVars:playerVars];
    Frame1Button.hidden = NO;
}

-(void)YoutubePlayer2
{
    //-- Vedio id eg: end string of youtube url
    NSString *videoId = @"pJgrFEpDQFM";
    self.Player2.delegate = self;
    NSDictionary *playerVars = @{
                                 @"controls" : @1,
                                 @"playsinline" : @1,
                                 @"autohide" : @1,
                                 @"showinfo" : @1,
                                 @"modestbranding" : @1
                                 };

    [self.Player2 loadWithVideoId:videoId playerVars:playerVars];
    Frame2Button.hidden = NO;
}



- (IBAction)StartYoutube:(id)sender
{
    if ([CheckNetwork isNetwork])
    {
        if(sender == self.Frame1Button)
        {
            Frame1Button.hidden = YES;
            [self playVideo:self.Frame1Button];
            
            Frame2Button.userInteractionEnabled = NO;
            Player2.userInteractionEnabled = NO;
        }
        else if(sender == self.Frame2Button)
        {
            Frame2Button.hidden =YES;
            [self playVideo:self.Frame2Button];
            
            Frame1Button.userInteractionEnabled = NO;
            Player1.userInteractionEnabled = NO;
        }
    }
    else
    {
        [CheckNetwork NoNetworkAlert];
    }
}


//-- Play button
-(IBAction)playVideo:(id)sender
{
    if(sender == self.Frame1Button)
    {
        [self.Player2 pauseVideo];
        [self.Player1 playVideo];
    }
    else if(sender == self.Frame2Button)
    {
        [self.Player1 pauseVideo];
        [self.Player2 playVideo];
    }
}





//-- Handle player controlls
- (void)playerView:(YTPlayerView *)playerView didChangeToState:(YTPlayerState)state
{
    switch (state)
    {
        case kYTPlayerStatePlaying:
            if (playerView == self.Player1)
            {
                NSLog(@"Player1 started");
                [self.Player2 pauseVideo];
                [self.Player1 playVideo];
                
                Frame2Button.userInteractionEnabled = YES;
                Player2.userInteractionEnabled = YES;
            }
            else
            {
                NSLog(@"Player2 started");
                [self.Player1 pauseVideo];
                [self.Player2 playVideo];
                
                Frame1Button.userInteractionEnabled = YES;
                Player1.userInteractionEnabled = YES;
            }
            break;
            
        case kYTPlayerStatePaused:
            if (playerView == self.Player1)
            {
                NSLog(@"Player1 paused");
            }
            else
            {
                NSLog(@"Player2 paused");
            }
            break;
            
        case kYTPlayerStateEnded:
            if (playerView == self.Player1)
            {
                Frame1Button.hidden = NO;
                [self YoutubePlayer1];
                NSLog(@"Player1 Stoped");
            }
            else
            {
                Frame2Button.hidden = NO;
                [self YoutubePlayer2];
                NSLog(@"Player2 Stoped");
            }
            break;
        
        default:
            break;
    }
}

//-- Reallocate once error occured
- (void)playerView:(YTPlayerView *)playerView receivedError:(YTPlayerError)error
{
    if (playerView == self.Player1)
    {
        Frame1Button.hidden = NO;
        [self YoutubePlayer1];
        NSLog(@"Player1 error");
    }
    else
    {
        Frame2Button.hidden = NO;
        [self YoutubePlayer2];
        NSLog(@"Player2 error");
    }
}


//-- Other delegate properties
/*
 - (void)playerViewDidBecomeReady:(YTPlayerView *)playerView;
 - (void)playerView:(YTPlayerView *)playerView didChangeToState:(YTPlayerState)state;
 - (void)playerView:(YTPlayerView *)playerView didChangeToQuality:(YTPlaybackQuality)quality;
 - (void)playerView:(YTPlayerView *)playerView receivedError:(YTPlayerError)error;
 */


@end
