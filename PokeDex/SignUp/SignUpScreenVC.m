//
//  SignUpScreenVC.m
//  PokeDex
//
//  Created by arnab on 6/23/19.
//  Copyright © 2019 com.ibm.mobilefirst. All rights reserved.
//

#import "SignUpScreenVC.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface SignUpScreenVC ()

@end

@implementation SignUpScreenVC
@synthesize txtFldFirstName,txtFldLastName,txtFldUserName,txtFldPassword,btnSignInReg,btnLoginScreennav;

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
    self.txtFldFirstName.delegate = self;
    self.txtFldLastName.delegate = self;
    self.txtFldUserName.delegate = self;
    self.txtFldPassword.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}


- (void)constructUI{
    self.btnSignInReg.layer.cornerRadius = 20;
    self.btnSignInReg.clipsToBounds = YES;
    UIColor *color = [UIColor whiteColor];
    NSString *string = @"Already have an account? Login";
    NSDictionary *attrs = @{ NSForegroundColorAttributeName : color,
                             NSUnderlineColorAttributeName: color,
                             NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)
                             };
    NSAttributedString *attrStrSignUp = [[NSAttributedString alloc] initWithString:string attributes:attrs];
    self.btnLoginScreennav.titleLabel.attributedText = attrStrSignUp;
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    BOOL ret=YES;
    NSString * message = @"";
    if ([identifier isEqualToString:@"SignUpToHome"]) {
       if([self.txtFldFirstName.text isEqualToString:@""] || [self.txtFldLastName.text isEqualToString:@""] || [self.txtFldUserName.text isEqualToString:@""] || [self.txtFldPassword.text isEqualToString:@""]){
           message = @"Mandatory Field should not be left blank";
           [self showAlertMessage:(NSString *)message];
           [self clearTextFieldEntry];
           ret=NO;
       }else{
           [self saveData];
           if([activeTextField isFirstResponder])
               [activeTextField resignFirstResponder];
           activeTextField = nil;
           [self clearTextFieldEntry];
           message = @"New user data saved";
           [self showAlertMessage:(NSString *)message];
           ret=YES;
       }
    }
    return ret;
}

- (void) clearTextFieldEntry{
    [self.txtFldFirstName setText:@""];
    [self.txtFldLastName setText:@""];
    [self.txtFldUserName setText:@""];
    [self.txtFldPassword setText:@""];
}


-(IBAction) btnSignInTapped:(id) sender{

//    NSString * message = @"";
}

- (void) saveData{
    NSManagedObjectContext *context = ((AppDelegate*)[[UIApplication sharedApplication] delegate]).persistentContainer.viewContext;
    NSManagedObject *newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    [newUser setValue:self.txtFldFirstName.text forKey:@"firstName"];
    [newUser setValue:self.txtFldLastName.text forKey:@"lastName"];
    [newUser setValue:self.txtFldUserName.text forKey:@"userName"];
    [newUser setValue:self.txtFldPassword.text forKey:@"password"];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
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
    const int movementDistance = -200;
    const float movementDuration = 0.3f;
    int movement = (up ? movementDistance : -movementDistance);
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}


@end
