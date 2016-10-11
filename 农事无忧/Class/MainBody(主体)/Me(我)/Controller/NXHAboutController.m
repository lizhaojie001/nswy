//
//  NXHAboutUsController.m
//  农事无忧
//
//  Created by Mac on 16/10/10.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

#import "NXHAboutController.h"
#import "CTDisplayView.h"
#import "CTFrameParser.h"
#import "CTFrameParserConfig.h"

#import "CoreTextLinkData.h"
#import "NXHAboutUsCell.h"
@interface NXHAboutController ()

@property (strong, nonatomic)   CTDisplayView *ctView;
/**scrollView*/
/**高度*/
@property (nonatomic,assign) CGFloat H;


@end

@implementation NXHAboutController
static NSString * Cell = @"reuseIdentifier";
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.tableView.bounces =NO;
    // [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:Cell];
    [self.tableView registerNib:[UINib nibWithNibName:@"NXHAboutUsCell" bundle:nil] forCellReuseIdentifier:Cell];
    [self setupUserInterface];
    [self setupNotifications];
}

- (void)setupUserInterface {
    CTFrameParserConfig *config = [[CTFrameParserConfig alloc] init];
    config.width = self.ctView.width;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"content" ofType:@"json"];
    CoreTextData *data = [CTFrameParser parseTemplateFile:path config:config];
    self.ctView.data = data;
    self.ctView.height = data.height;
    self.H = data.height;
    self.ctView.backgroundColor = [UIColor whiteColor];
}

- (void)setupNotifications {
    //     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imagePressed:)
    //                                                 name:CTDisplayViewImagePressedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(linkPressed:)
                                                 name:CTDisplayViewLinkPressedNotification object:nil];
    
}



- (void)linkPressed:(NSNotification*)notification {
    NSDictionary *userInfo = [notification userInfo];
    CoreTextLinkData *linkData = userInfo[@"linkData"];
    
    NSString * url = linkData.url;
    NSURL *URL = [NSURL URLWithString:url];
    [[UIApplication sharedApplication] openURL:URL];
    
    
    
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.H+30;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete implementation, return the number of rows
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NXHAboutUsCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell forIndexPath:indexPath];
    
    [cell.ctView addSubview:self.ctView];
    
    return cell;
}



- (CTDisplayView *)ctView {
    if(_ctView == nil) {
        _ctView = [[CTDisplayView alloc] init];
        _ctView.width = self.view.width-10;
        // _ctView.backgroundColor = [UIColor redColor];
        
    }
    return _ctView;
}

@end
