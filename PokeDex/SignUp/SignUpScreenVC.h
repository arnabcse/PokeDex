//
//  SignUpScreenVC.h
//  PokeDex
//
//  Created by arnab on 6/23/19.
//  Copyright © 2019 com.ibm.mobilefirst. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SignUpScreenVC : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtFldFirstName;
@property (weak, nonatomic) IBOutlet UITextField *txtFldLastName;
@property (weak, nonatomic) IBOutlet UITextField *txtFldUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtFldPassword;

@property (weak, nonatomic) IBOutlet UIButton *btnSignInReg;
@property (weak, nonatomic) IBOutlet UIButton *btnLoginScreennav;


@end

NS_ASSUME_NONNULL_END
