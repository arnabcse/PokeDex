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

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    BOOL ret=YES;
    NSString * message = @"";
    if ([identifier isEqualToString:@"SignUpToHome"]) {
       if([self.txtFldFirstName.text isEqualToString:@""] || [self.txtFldLastName.text isEqualToString:@""] || [self.txtFldUserName.text isEqualToString:@""] || [self.txtFldPassword.text isEqualToString:@""]){
           message = @"Mandatory Field should not be left blank";
           [self showAlertMessage:(NSString *)message];
           [self.txtFldFirstName setText:@""];
           [self.txtFldLastName setText:@""];
           [self.txtFldUserName setText:@""];
           [self.txtFldPassword setText:@""];
            ret=NO;
       }else{
           [self saveData];
           message = @"New user data saved";
           [self showAlertMessage:(NSString *)message];
           ret=YES;
       }
    }
    return ret;
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

@end
