//
//  LoginScreenVC.m
//  PokeDex
//
//  Created by arnab on 6/22/19.
//  Copyright © 2019 com.ibm.mobilefirst. All rights reserved.
//

#import "LoginScreenVC.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface LoginScreenVC ()

@end

@implementation LoginScreenVC
@synthesize txtFldUserName,txtFldPassoword,btnSignIn,btnSignUp;
@synthesize userData;

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self constructUI];
    self.txtFldUserName.delegate = self;
    self.txtFldPassoword.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self fetchUserSavedData];
}

- (void)fetchUserSavedData{
    //NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSManagedObjectContext *managedObjectContext = ((AppDelegate*)[[UIApplication sharedApplication] delegate]).persistentContainer.viewContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    self.userData = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
}

- (void)constructUI{
    self.btnSignIn.layer.cornerRadius = 20;
    self.btnSignIn.clipsToBounds = YES;
    UIColor *color = [UIColor whiteColor];
    NSString *string = @"Sign Up";
    NSDictionary *attrs = @{ NSForegroundColorAttributeName : color,
                             NSUnderlineColorAttributeName: color,
                             NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)
                             };
    NSAttributedString *attrStrSignUp = [[NSAttributedString alloc] initWithString:string attributes:attrs];
    self.btnSignUp.titleLabel.attributedText = attrStrSignUp;
}

- (BOOL)validateLogin{
    BOOL ret=YES;
    NSManagedObject *userDataSet;
    for(NSInteger i=0;i<self.userData.count;i++){
        userDataSet = [self.userData objectAtIndex:i];
        if([self.txtFldUserName.text isEqualToString:[userDataSet valueForKey:@"userName"]] && [self.txtFldPassoword.text isEqualToString:[userDataSet valueForKey:@"password"]]){
            ret=NO;
            break;
        }
    }
    
    return ret;
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    BOOL ret=YES;
    NSString * message = @"";
    if ([identifier isEqualToString:@"loginToHome"]) {
        if([self.txtFldUserName.text isEqualToString:@""] || [self.txtFldPassoword.text isEqualToString:@""]){
            message = @"Mandatory Field should not be left blank";
            [self showAlertMessage:(NSString *)message];
            [self.txtFldUserName setText:@""];
            [self.txtFldPassoword setText:@""];
            ret=NO;
        }else if(self.validateLogin){
            message = @"Wrong Credentials - Username/Password Or Create a new User By Clicking Sign Up at the bottom";
            [self showAlertMessage:(NSString *)message];
            [self clearTextFieldEntry];
            ret=NO;
        }
        else{
            if([activeTextField isFirstResponder])
                [activeTextField resignFirstResponder];
            activeTextField = nil;
            [self clearTextFieldEntry];
            ret=YES;
        }
    }
    return ret;
}

- (void) clearTextFieldEntry{
    [self.txtFldUserName setText:@""];
    [self.txtFldPassoword setText:@""];
}

- (void) showAlertMessage:(NSString *)messageText{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle : @"Message"
                                                                    message : messageText
                                                             preferredStyle : UIAlertControllerStyleAlert];
    
    UIAlertAction * ok = [UIAlertAction
                          actionWithTitle:@"OK"
                          style:UIAlertActionStyleDefault
                          handler:^(UIAlertAction * action)
                          { }];
    
    [alert addAction:ok];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:YES completion:nil];
    });
}


#pragma mark - Text Field Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldShouldBeginEditing");
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldDidBeginEditing");
    activeTextField = textField;
    [self animateTextField:textField up:YES];
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSLog(@"textFieldShouldEndEditing");
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"textFieldDidEndEditing");
    [self animateTextField:textField up:NO];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    NSLog(@"textFieldShouldClear:");
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"textFieldShouldReturn:");
    [textField resignFirstResponder];
    if([textField isFirstResponder]){
        [self animateTextField:textField up:NO];
    } else {
       NSLog(@"textFieldFocusLost:");
    }
    return YES;
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    const int movementDistance = -90;
    const float movementDuration = 0.3f;
    int movement = (up ? movementDistance : -movementDistance);
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

@end
