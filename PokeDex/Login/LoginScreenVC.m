//
//  LoginScreenVC.m
//  PokeDex
//
//  Created by arnab on 6/22/19.
//  Copyright © 2019 com.ibm.mobilefirst. All rights reserved.
//

#import "LoginScreenVC.h"
#import <QuartzCore/QuartzCore.h>

@interface LoginScreenVC ()

@end

@implementation LoginScreenVC
@synthesize txtFldUserName,txtFldPassoword,btnSignIn,btnSignUp;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self constructUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self constructUI];
}


- (void)constructUI{
    self.btnSignIn.layer.cornerRadius = 20;
    self.btnSignIn.clipsToBounds = YES;
    [self.btnSignUp setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}


@end
