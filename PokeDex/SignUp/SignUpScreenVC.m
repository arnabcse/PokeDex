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


-(IBAction) btnSignInTapped:(id) sender{

    /*
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    [newUser setValue:self.txtFldFirstName.text forKey:@"firstName"];
    [newUser setValue:self.txtFldLastName.text forKey:@"lastName"];
    [newUser setValue:self.txtFldUserName.text forKey:@"userName"];
    [newUser setValue:self.txtFldPassword.text forKey:@"password"];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
     */
}

@end
