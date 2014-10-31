//
//  ViewController.h
//  YoutubePlayer
//
//  Created by Rajesh on 27/08/14.
//  Copyright (c) 2014 Rajesh. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "YTPlayerView.h"


@interface ViewController : UIViewController<YTPlayerViewDelegate>

@property(nonatomic, strong) IBOutlet YTPlayerView *Player1;
@property(nonatomic, strong) IBOutlet YTPlayerView *Player2;

@property(nonatomic, strong) IBOutlet UIButton *Frame1Button;
@property(nonatomic, strong) IBOutlet UIButton *Frame2Button;

- (IBAction)StartYoutube:(id)sender;
- (IBAction)playVideo:(id)sender;




@end
