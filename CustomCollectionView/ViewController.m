//
//  ViewController.m
//  CustomCollectionView
//
//  Created by 谢小龙 on 16/3/23.
//  Copyright © 2016年 xintong. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}



- (IBAction)clicked:(id)sender {
    
    CollectionViewController *vc = [[CollectionViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
    
}

@end
