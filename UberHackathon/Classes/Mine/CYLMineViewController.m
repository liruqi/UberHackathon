//
//  CYLMineViewController.m
//  CYLCustomTabBarDemo
//
//  Created by 微博@iOS程序犭袁 (http://weibo.com/luohanchenyilong/) on 10/20/15.
//  Copyright © 2015 https://github.com/ChenYilong . All rights reserved.
//
// TableView section key
#define XHKSectionsKey @"Sections"
#define XHKSectionHeaderTitleKey @"SectionHeaderTitle"
#define XHKSectionFooterTitleKey @"SectionFooterTitle"

// TableView row key
#define XHKRowsKey @"Rows"
#define XHKSwitchKey @"Switch"
#define XHKTextKey @"Text"
#define XHKSubTitleKey @"SubTitle"
#define XHKUserAvatarImageNameKey @"userAvatarImageName"
#define XHKAccessoryViewTextKey @"AccessoryViewText"


#define XHKLoginButtonDisplayKey @"LoginButton"

// Controller key
#define XHKControllerTitleKey @"Title"

// NavigationController push ViewController Key
#define XHKWifiKey @"Wi-Fi"
#define XHKNotificationsKey @"Notifications"


#import "CYLMineViewController.h"
#import <AVOSCloud/AVUser.h>
#import "ViewController.h"
#import "AppDelegate.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AVUser+MCCustomUser.h"

@interface CYLMineViewController()
@property (nonatomic, copy) NSArray *setting;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;

@end
@implementation CYLMineViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //        self.title = @"我的";
    }
    return self;
}

#pragma mark - View lifecycle

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
    }
    return self;
}

- (NSDictionary *)settingDictionary {
    if (!_settingDictionary) {
        _settingDictionary = [[NSDictionary alloc] init];
    }
    return _settingDictionary;
}

- (NSUInteger)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return UIInterfaceOrientationMaskAll;
    } else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return YES;
    }
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}

//#pragma mark - Methods
//
//- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
//    [[cell textLabel] setText:[NSString stringWithFormat:@"%@ Controller Cell %ld", self.title, (long)indexPath.row]];
//}
//
//#pragma mark - Table view
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//
//    [self configureCell:cell forIndexPath:indexPath];
//
//    return cell;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 30;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [self.navigationController.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%ld", indexPath.row+1]];
//}

- (NSArray *)setting {
    if (!_setting) {
        _setting = [[NSArray alloc] init];
        NSLog(@"🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), self.setting);
    }
    return _setting;
}

- (void)_loadLoginViewControllers {
    NSMutableArray *setting = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"]];
    self.setting = setting;
    NSLog(@"🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), self.setting);
    [self.tableView reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _loadLoginViewControllers];
    NSLog(@"🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), self.setting);
    NSDictionary *settingDictionary = self.setting[1];
    
    self.settingDictionary = settingDictionary;
    self.title = [settingDictionary valueForKey:XHKControllerTitleKey];
    
    // Do any additional setup after loading the view.
    __weak __typeof(self) safeSelf = self;
    for (NSString *key in self.settingDictionary) {
        if ([key isEqualToString:XHKSectionsKey]) {
            NSArray *sections = [self.settingDictionary valueForKey:key];
            for (NSDictionary *sectionDictionary in sections) {
                [self addSection:^(XHTableViewSection *section, NSUInteger sectionIndex) {
                    for (NSString *sectionKey in sectionDictionary) {
                        if ([sectionKey isEqualToString:XHKSectionHeaderTitleKey]) {
                            NSString *sectionHeaderTitle = [sectionDictionary valueForKey:XHKSectionHeaderTitleKey];
                            if (sectionHeaderTitle) {
                                section.headerTitle = sectionHeaderTitle;
                            }
                        } else if ([sectionKey isEqualToString:XHKSectionFooterTitleKey]) {
                            NSString *sectionFooterTitle = [sectionDictionary valueForKey:XHKSectionFooterTitleKey];
                            if (sectionFooterTitle) {
                                section.footerTitle = sectionFooterTitle;
                            }
                        } else if ([sectionKey isEqualToString:XHKRowsKey]) {
                            NSArray *rows = [sectionDictionary valueForKey:XHKRowsKey];
                            if (rows.count) {
                                for (NSDictionary *rowDictionary in rows) {
                                    NSString *text = [rowDictionary valueForKey:XHKTextKey];
                                    if (text) {
                                        [section addCell:^(XHTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
                                            NSString *subTitle = [rowDictionary valueForKey:XHKSubTitleKey];
                                            if (subTitle) {
                                                staticContentCell.cellStyle = UITableViewCellStyleValue1;
                                                cell.detailTextLabel.text = subTitle;
                                                staticContentCell.reuseIdentifier = @"SubDetailTextCell";
                                            } else {
                                                staticContentCell.cellStyle = UITableViewCellStyleDefault;
                                                staticContentCell.reuseIdentifier = @"DetailTextCell";
                                            }
                                            
                                            
                                            cell.textLabel.text = text;
                                            AVUser *currentUser = [AVUser currentUser];

                                            NSString *userAvatarImageName = [rowDictionary valueForKey:XHKUserAvatarImageNameKey];
                                            if (userAvatarImageName) {
                                                AVFile *avatar = [currentUser objectForKey:KEY_AVATAR];
                                                
                                                [cell.imageView sd_setImageWithURL:[NSURL URLWithString:avatar.url] placeholderImage:[UIImage imageNamed:@"avator"]];
                                            }
                                            if ([text isEqualToString:@"UserName"]) {
                                                cell.textLabel.text = currentUser.username;
                                            }
                                            
                                            for (NSString *rowKey in rowDictionary) {
                                                if ([rowKey isEqualToString:XHKAccessoryViewTextKey]) {
                                                    NSString *accessoryViewText = [rowDictionary valueForKey:rowKey];
                                                    //                                                    if (accessoryViewText) {
                                                    //                                                        XHBadgeLabel *badgeLabel = [[XHBadgeLabel alloc] initWithFrame:CGRectZero];
                                                    //                                                        badgeLabel.text = accessoryViewText;
                                                    //                                                        cell.accessoryView = badgeLabel;
                                                    //                                                    }
                                                }
                                            }
                                            
                                            BOOL isSwitch = [[rowDictionary valueForKey:XHKSwitchKey] boolValue];
                                            if (isSwitch) {
                                                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                                                
                                                UISwitch *customSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
                                                cell.accessoryView = customSwitch;
                                            }
                                            
                                        } whenSelected:^(NSIndexPath *indexPath) {
                                            for (NSString *rowKey in rowDictionary) {
                                                if ([rowKey isEqualToString:XHKTextKey]) {
                                                    NSString *text = [rowDictionary valueForKey:rowKey];
                                                    if ([text isEqualToString:XHKWifiKey]) {
                                                        //                                                        [safeSelf.navigationController pushViewController:[[WifiViewController alloc] init] animated:YES];
                                                    } else if ([text isEqualToString:XHKNotificationsKey]) {
                                                        //                                                        [safeSelf.navigationController pushViewController:[[NotificationsViewController alloc] init] animated:YES];
                                                    }
                                                }
                                            }
                                        }];
                                    }
                                }
                            }
                        }
                    }
                }];
            }
        } else if ([key isEqualToString:XHKLoginButtonDisplayKey]) {
            BOOL disPlayLoginButton = [[self.settingDictionary valueForKey:key] boolValue];
            if (disPlayLoginButton) {
                [self addLoginButtonWithFooterViewCallBackBlock:^(BOOL selected) {
                    [safeSelf logoutUser];
                    NSLog(@"selected : %d", selected);
                }];
            }
        }
    }
}

- (void)logoutUser {
    AVUser *user = [AVUser currentUser];
    if (user) {
        [AVUser logOut];
        [self toLogin];
    }
}

- (void)toLogin {
    ViewController *loginViewController = [[ViewController alloc] init];
    __weak __typeof(loginViewController) weakLoginViewController = loginViewController;
    loginViewController.completionBlock = ^ {
        [[weakLoginViewController.view subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [weakLoginViewController dismissViewControllerAnimated:YES completion:^{
            [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        }];
    };
    [self presentViewController:loginViewController animated:YES completion:nil];
}

- (void)toMain {
    AppDelegate *delegate = ((AppDelegate *)[[UIApplication sharedApplication] delegate]);
    UIWindow *window = delegate.window;
    UITabBarController *tabbarController = (UITabBarController *)window.rootViewController;
    window.rootViewController = tabbarController;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 ) {
        if (indexPath.row == 0) {
            UIAlertControllerStyle style = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)? UIAlertControllerStyleAlert: UIAlertControllerStyleActionSheet;
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:style];
            
            [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Take Photo", nil) style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action) {
                [self actionSheet:nil didDismissWithButtonIndex:0];
            }]];
            
            [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Photo Library", nil) style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action) {
                [self actionSheet:nil didDismissWithButtonIndex:1];
            }]];
            
            [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:NULL]];
            
            [self presentViewController:alert animated:YES completion:NULL];
        }
    }
}

//- (void)xdd {
//    NSMutableArray *photoFiles = [NSMutableArray array];
//    NSError *theError;
//    for (UIImage *photo in photos) {
//        AVFile *photoFile = [AVFile fileWithData:UIImageJPEGRepresentation(photo, 0.6)];
//        [photoFile save:&theError];
//        if (theError) {
//            *error = theError;
//            return;
//        }
//        [photoFiles addObject:photoFile];
//    }
//}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    AVUser *currentUser = [AVUser currentUser];
    UIImage *image = info[UIImagePickerControllerEditedImage] ?: info[UIImagePickerControllerOriginalImage];
    AVFile *photoFile = [AVFile fileWithData:UIImageJPEGRepresentation(image, 0.6)];
    [photoFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            currentUser.avatar = photoFile;
            [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                [self.tableView reloadData];
            }];
        }
    }];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)actionSheet:(__unused UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    switch (buttonIndex)
    {
        case 0:
        {
            sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        }
        case 1:
        {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        }
        default:
        {
            return;
        }
    }
    if ([UIImagePickerController isSourceTypeAvailable:sourceType])
    {
        self.imagePickerController.sourceType = sourceType;
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
    }
}

- (UIImagePickerController *)imagePickerController
{
    if (!_imagePickerController)
    {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        _imagePickerController.allowsEditing = YES;
    }
    return _imagePickerController;
}


@end
