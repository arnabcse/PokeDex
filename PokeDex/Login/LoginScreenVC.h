//
//  LoginScreenVC.h
//  PokeDex
//
//  Created by arnab on 6/22/19.
//  Copyright © 2019 com.ibm.mobilefirst. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginScreenVC : UIViewController<UITextFieldDelegate>
{
    NSMutableArray *userData;
    UITextField *activeTextField;
}

@property (weak, nonatomic) IBOutlet UITextField *txtFldUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtFldPassoword;
@property (weak, nonatomic) IBOutlet UIButton *btnSignIn;
@property (weak, nonatomic) IBOutlet UIButton *btnSignUp;

@property (strong) NSMutableArray *userData;

@end

NS_ASSUME_NONNULL_END
