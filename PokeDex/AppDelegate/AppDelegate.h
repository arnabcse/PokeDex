//
//  AppDelegate.h
//  PokeDex
//
//  Created by arnab on 6/22/19.
//  Copyright © 2019 com.ibm.mobilefirst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

