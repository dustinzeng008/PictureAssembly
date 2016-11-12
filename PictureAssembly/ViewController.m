//
//  ViewController.m
//  PictureAssembly
//
//  Created by Yong Zeng on 11/9/16.
//  Copyright © 2016 Yong Zeng. All rights reserved.
//

#define KDEVICEWIDTH [[UIScreen mainScreen] bounds].size.width

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *restartButton;
@property (nonatomic, strong) NSMutableArray *imageButtons;

@property (nonatomic, copy) NSArray *imageNames;
@property (nonatomic, copy) NSMutableArray *selectedImageIndexs;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    
    _imageNames = [[NSArray alloc] initWithObjects:@[@"1a", @"2a", @"3a"],
                     @[@"1b", @"2b", @"3b"], @[@"1c", @"2c", @"3c"], nil];
    _selectedImageIndexs = [[NSMutableArray alloc] initWithObjects:@11, @12, @13, nil];
    _imageButtons = [NSMutableArray array];
    
    
    // Button to restart game
    UIButton *restartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    restartButton.frame = CGRectMake((KDEVICEWIDTH - 300)/2, 100, 300, 45);
    [self.view addSubview:restartButton];
    _restartButton = restartButton;
    [restartButton setTitle:@"You win! Click here to play again." forState:UIControlStateNormal];
    [restartButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [restartButton setBackgroundColor:[UIColor colorWithRed:22/255.0
                                                      green:160/255.0
                                                       blue:133/255.0
                                                      alpha:1]];
    restartButton.clipsToBounds    =   YES;
    restartButton.layer.cornerRadius   =   10;
    restartButton.hidden = YES;
    [restartButton addTarget:self action:@selector(restartGame) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    CGFloat buttonWidth = 102.1*1.3;
    CGFloat buttonHeight = 42.6*1.3;
    CGFloat marginTop = 180;
    
    // Button to show picture
    for (NSInteger i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((KDEVICEWIDTH - buttonWidth)/2, marginTop + buttonHeight*i - i*1, buttonWidth, buttonHeight);
        [self.view addSubview:button];
        [_imageButtons addObject:button];
        
        button.tag = i;
        [[button layer] setBorderWidth:1.0f];
        [button.layer setBorderColor:[[UIColor blackColor] CGColor]];
        [button.layer setCornerRadius:5.0f];
        [button addTarget:self action:@selector(changeImage:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)changeImage:(id)sender{
    UIButton* button = (UIButton*)sender;
    NSInteger imageIndex = arc4random_uniform(3);
    NSArray *images = _imageNames[button.tag];
    
    [button setBackgroundImage:[UIImage imageNamed:images[imageIndex]] forState:UIControlStateNormal];
    [self.selectedImageIndexs replaceObjectAtIndex:[button tag] withObject:[NSNumber numberWithInteger:imageIndex]];
    NSSet *set = [NSSet setWithArray:self.selectedImageIndexs];
    if (([set count] == 1)) {
        _restartButton.hidden = NO;
    }
}

- (void)restartGame{
    _restartButton.hidden = YES;
    _selectedImageIndexs = [[NSMutableArray alloc] initWithObjects:@11, @12, @13, nil];
    for (UIButton *button in _imageButtons) {
        [button setBackgroundImage:nil forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
