//
//  ViewController.m
//  Tamagotchi
//
//  Created by Rizki Calame on 08-11-13.
//  Copyright (c) 2013 Rizki Calame. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    NSString *healthString;
    NSString *healthAmount;
    NSString *coinString;
    NSString *coinAmount;
    
    int healthInt;
    int coinInt;
    
    UILabel *healthLabel;
    UILabel *coinLabel;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
 
    // Get values from PLIST file
    NSURL *file = [[NSBundle mainBundle] URLForResource:@"values" withExtension:@"plist"]; //Lets get the file location
    NSDictionary *plistContent = [NSDictionary dictionaryWithContentsOfURL:file];
    NSString *coinsPlist = [plistContent objectForKey:@"coins"];
    NSString *healthPlist = [plistContent objectForKey:@"health"];
    
    
    // Set PLIST values to integers
    coinInt = [coinsPlist intValue];
    healthInt = [healthPlist intValue];

    
    // Health label
    healthString = @"Health: ";
    healthAmount = [NSString stringWithFormat:@"%i", healthInt];
    
    healthLabel = [[UILabel alloc] initWithFrame: CGRectMake(10, 30, 100, 100)];
    [healthLabel setText:[NSString stringWithFormat:@"%@%@", healthString, healthAmount]];
    [healthLabel sizeToFit];
    
    [self.view addSubview:healthLabel];
    
    
    // Coins label
    coinString = @"Coins: ";
    coinAmount = [NSString stringWithFormat:@"%i", coinInt];
    
    coinLabel = [[UILabel alloc] init];
    [coinLabel setText:[NSString stringWithFormat:@"%@%@", coinString, coinAmount]];
    [coinLabel setFrame:CGRectMake(self.view.frame.size.width - 10 - 200, 30, 100, 100)];
    [coinLabel sizeToFit];
    
    [self.view addSubview:coinLabel];
    
    
    // Feed button bottom left
    UIButton *feedButton = [[UIButton alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height - 10 - 50, 100, 50)];
    [feedButton setBackgroundColor:[UIColor whiteColor]];
    [feedButton setTitle:@"Feed me!" forState:UIControlStateNormal];
    [feedButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [feedButton.layer setBorderColor:[UIColor blackColor].CGColor];
    [feedButton.layer setBorderWidth:1.0f];
    [feedButton addTarget:self action:@selector(healthAdd) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:feedButton];
    
    
    // Play button bottom right
    UIButton *play = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 10 - feedButton.frame.size.width, self.view.frame.size.height - 10 - 50, 100, 50)];
    [play setBackgroundColor:[UIColor whiteColor]];
    [play setTitle:@"Fap!" forState:UIControlStateNormal];
    [play setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [play.layer setBorderColor:[UIColor blackColor].CGColor];
    [play.layer setBorderWidth:1.0f];
    [play addTarget:self action:@selector(coinAdd) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:play];
    
    
    
    
    
    
    
    
    
    
    
    NSTimer *healthDecTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(decreaseHealth) userInfo:self repeats:YES];

    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)decreaseHealth { // Woops! Tamagotchi is dying :(
    healthInt--;
    [self updateHealth];
    
    NSLog(@"%i", healthInt);
}

- (void)healthAdd { // Add health to integer and update to PLIST file
    if (coinInt > 10 && healthInt > 91) {
        healthInt = 100;
        coinInt -= 10;
    } else if (coinInt > 10 && healthInt <= 90) {
        healthInt += 10;
        coinInt -= 10;
    } else {
        NSLog(@"No munni");
    }
    
    [self updateCoins];
    [self updateHealth];
}

- (void)coinAdd { // Add coin to integer and update to PLIST file
    coinInt++;
    
    [self updateCoins];
}

- (void)updateCoins { // Update coins in the label on the screen
    coinAmount = [NSString stringWithFormat:@"%i", coinInt];
    [coinLabel setText:[NSString stringWithFormat:@"%@%@", coinString, coinAmount]];
    
    [coinLabel sizeToFit];
}

- (void)updateHealth { // Update health in the label on the screen
    healthAmount = [NSString stringWithFormat:@"%i", healthInt];
    [healthLabel setText:[NSString stringWithFormat:@"%@%@", healthString, healthAmount]];
}

@end
