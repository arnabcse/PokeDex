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
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self constructUI];
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
    [self.btnSignUp setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
            [self.txtFldUserName setText:@""];
            [self.txtFldPassoword setText:@""];
            ret=NO;
        }
        else{
            ret=YES;
        }
    }
    return ret;
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
