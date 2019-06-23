//
//  SignUpScreenVC.m
//  PokeDex
//
//  Created by arnab on 6/23/19.
//  Copyright © 2019 com.ibm.mobilefirst. All rights reserved.
//

#import "SignUpScreenVC.h"
#import <QuartzCore/QuartzCore.h>
@interface SignUpScreenVC ()

@end

@implementation SignUpScreenVC
@synthesize txtFldFirstName,txtFldLastName,txtFldUserName,txtFldPassword,btnSignInReg,btnLoginScreennav;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self constructUI];
}


- (void)constructUI{
    self.btnSignInReg.layer.cornerRadius = 20;
    self.btnSignInReg.clipsToBounds = YES;
    [self.btnLoginScreennav setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}


@end
