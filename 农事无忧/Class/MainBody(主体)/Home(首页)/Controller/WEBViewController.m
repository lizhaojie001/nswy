//
//  WEBViewController.m
//  
//
//  Created by Mac on 16/9/14.
//
//

#import "WEBViewController.h"

@interface WEBViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WEBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NXHMyLogFunction;
    self.webView.delegate = self;
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];

    [self.webView loadRequest:request];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    NXHMyLogFunction;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NXHMyLogFunction;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    MYLog(@"%@",error);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
