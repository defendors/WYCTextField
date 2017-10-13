//
//  ViewController.m
//  WYCTextField
//
//  Created by WD_王宇超 on 2017/10/11.
//

#import "ViewController.h"
#import "WYCTextField.h"
@interface ViewController ()

@end

@implementation ViewController
{
	WYCTextField* firstTextField;
	WYCTextField* secondTextField;
	WYCTextField* thirdTextField;
}
#pragma mark life cycle
- (void)viewDidLoad {
	[super viewDidLoad];
	[self addView];
	// Do any additional setup after loading the view, typically from a nib.
}
- (void)viewWillAppear:(BOOL)animated{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:nil];
}
- (void)viewWillDisappear:(BOOL)animated{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

#pragma mark private method
- (void)addView{
	firstTextField = [[WYCTextField alloc]initWithFrame:CGRectMake(40, 100, 250, 45)];
	firstTextField.isAllowAutoInsertSpace = YES;
	firstTextField.placeholder = @"手机号模式";
	firstTextField.textAutoInsertSpaceMode = autoInsertSpaceModeCellphone;
	firstTextField.backgroundColor = [UIColor yellowColor];
	[self.view addSubview:firstTextField];
	
	secondTextField = [[WYCTextField alloc]initWithFrame:CGRectMake(40, 100 + 45 + 10, 250, 45)];
	secondTextField.isAllowAutoInsertSpace = YES;
	secondTextField.placeholder = @"银行卡模式";
	secondTextField.textAutoInsertSpaceMode = autoInsertSpaceModeBackcardNumber;
	secondTextField.backgroundColor = [UIColor yellowColor];
	[self.view addSubview:secondTextField];
	
	thirdTextField = [[WYCTextField alloc]initWithFrame:CGRectMake(40, 100 + 45 + 10 + 45 + 10, 250, 45)];
	thirdTextField.isAllowAutoInsertSpace = YES;
	thirdTextField.font = [UIFont systemFontOfSize:12];
	thirdTextField.placeholder = @"其他模式(例如:第二，第四位为空格)";
	thirdTextField.spaceIndexes = [NSSet setWithArray:@[@2,@4]];
	thirdTextField.textAutoInsertSpaceMode = autoInsertSpaceModeOther;
	thirdTextField.backgroundColor = [UIColor yellowColor];
	[self.view addSubview:thirdTextField];
}

#pragma mark notification method
- (void)textFieldTextDidChangeNotification:(NSNotification*)notification{
	if ([notification.object isKindOfClass:[WYCTextField class]]) {
		WYCTextField* textField = notification.object;
		[textField textFieldTextDidChangeNotification:notification];
	}
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end


