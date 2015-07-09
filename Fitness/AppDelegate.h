//
//  AppDelegate.h
//  Fitness
//
//  Created by Rahul Singha Roy on 25/03/15.
//  Copyright (c) 2015 Esolz Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "PTPusherDelegate.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSString *PUSHER_API_KEY;
    NSString *PUSHER_CHANNEL;
    NSString *PUSHER_EVENT;

}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@property (nonatomic, strong) PTPusher *pusherClient;

@end

