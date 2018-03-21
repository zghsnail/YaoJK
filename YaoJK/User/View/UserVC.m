//
//  UserVC.m
//  YaoJK
//
//  Created by IOS App on 18/1/15.
//  Copyright © 2018年 nova. All rights reserved.
//

#import "UserVC.h"
#import "UserInfoVC.h"
@interface UserVC ()

@end

@implementation UserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *info = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [info addTarget:self action:@selector(userinfo) forControlEvents:UIControlEventTouchUpInside];
    [info setTitle:@"详细信息" forState:UIControlStateNormal];
    [info setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.view addSubview:info];
    
    UIButton *info2 = [[UIButton alloc] initWithFrame:CGRectMake(220, 100, 100, 100)];
    [info2 addTarget:self action:@selector(userinfow) forControlEvents:UIControlEventTouchUpInside];
    [info2 setTitle:@"详细信息" forState:UIControlStateNormal];
    [info2 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.view addSubview:info2];
}

- (void)userinfo{//nova://presnet/LoginVC
    NSURL *url = [NSURL string:@"nova://push/UserInfoVC?titlestr=信息详情"];
    [[UIApplication sharedApplication] openURL:url];
}

- (void)userinfow{
    UserInfoVC *vc = [[UserInfoVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
