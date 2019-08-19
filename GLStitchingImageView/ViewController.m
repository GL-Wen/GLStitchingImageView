//
//  ViewController.m
//  GLStitchingImageView
//
//  Created by william on 2019/8/19.
//  Copyright © 2019 william. All rights reserved.
//

#import "ViewController.h"
#import "StitchingImageView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet StitchingImageView *stitchingView;
@property (weak, nonatomic) IBOutlet UITextField *numTF;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.stitchingView.width = 120;
}

- (IBAction)btnAction:(UIButton *)btn
{
    NSInteger count = self.numTF.text.integerValue;
    if (count < 1) { count = 1; };
    if (count > 9) { count = 9; };
    
    [self.stitchingView reload:count];
}

@end
