//
//  SKViewController.m
//  Score Keeper
//
//  Created by Douglas Voss on 4/28/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "SKViewController.h"
#import "NSObject+SKColorCategory.h"

CGFloat heightOfScoreBlock = 100.0;
int numberOfCells = 3;

@interface SKViewController () <UITextFieldDelegate>

@property (nonatomic, strong, readwrite) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *scoreLabels;
@property (nonatomic, strong) NSMutableArray *cells;

@end

@implementation SKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNavbarItems];
    
    self.title = @"Scroll View";
    
    CGFloat topMargin = 0;
    CGFloat scrollExtension = self.scoreLabels.count * heightOfScoreBlock;
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, topMargin, self.view.frame.size.width, self.view.frame.size.height - topMargin)];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + scrollExtension);
    [self.view addSubview:self.scrollView];
    
    self.scoreLabels = [NSMutableArray new];
    self.cells = [NSMutableArray new];
    
    for (int i = 0; i < numberOfCells; i ++) {
        [self addScoreView:i];
    }
    
    
}

- (void)addNavbarItems {
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithTitle:@"+" style:UIBarButtonSystemItemAction target:self action:@selector(addCell:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    UIBarButtonItem *minusButton = [[UIBarButtonItem alloc]initWithTitle:@"-" style:UIBarButtonSystemItemAction target:self action:@selector(removeCell:)];
    self.navigationItem.leftBarButtonItem = minusButton;
    
    
}

- (void)addCell:(id)sender {
    
    numberOfCells ++;
    [self addScoreView:(numberOfCells-1)];
    
    CGFloat scrollExtension = self.scoreLabels.count * heightOfScoreBlock;
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + scrollExtension);
}

- (void)removeCell:(id)sender {

    numberOfCells--;
    if (numberOfCells < 0) {
        numberOfCells = 0;
    }
    [self removeExtraCells];
    CGFloat scrollExtension = self.scoreLabels.count * heightOfScoreBlock;
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + scrollExtension);
}

- (void)removeExtraCells {
    for (int i=[self.cells count]-1; i >= numberOfCells; i--)
    {
        [[self.cells objectAtIndex:i] removeFromSuperview];
    }
}

- (void)addScoreView:(NSInteger)index {
    
    CGFloat widthOfLabel = 50.0;
    CGFloat xMargin = 15.0;
    
    //UIView *cellView = [[UIView alloc]initWithFrame:CGRectMake(0, (index) * heightOfScoreBlock, self.view.frame.size.width, heightOfScoreBlock)];
    
    [self.cells addObject:[[UIView alloc]initWithFrame:CGRectMake(0, (index) * heightOfScoreBlock, self.view.frame.size.width, heightOfScoreBlock)]];
    UIView *cellView = [self.cells objectAtIndex:([self.cells count]-1)];
    cellView.backgroundColor = [UIColor viewBackground];
    
    UILabel *scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(cellView.frame.size.width / 2 - 25, widthOfLabel / 2, widthOfLabel, widthOfLabel)];
    scoreLabel.text = @"0";
    scoreLabel.font = [UIFont fontWithName:@"Chalkduster" size:20];
    scoreLabel.textColor = [UIColor labelText];
    scoreLabel.backgroundColor = [UIColor labelBackground];
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    [self.scoreLabels addObject:scoreLabel];
    
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(xMargin, widthOfLabel / 2, cellView.frame.size.width / 3, 50)];
    textField.placeholder = @"Add Name";
    textField.delegate = self;
    textField.backgroundColor = [UIColor textFieldBackground];
    textField.textColor = [UIColor blackColor];
    textField.font = [UIFont fontWithName:@"Chalkduster" size:20];
    
    UIStepper *stepper = [[UIStepper alloc]initWithFrame:CGRectMake(cellView.frame.size.width * .68, 38, widthOfLabel + 30, widthOfLabel)];
    stepper.minimumValue = -10;
    stepper.maximumValue = 20;
    stepper.tag = index;
    [stepper addTarget:self action:@selector(stepperValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    [cellView addSubview:scoreLabel];
    [cellView addSubview:textField];
    [cellView addSubview:stepper];
    
    [self.scrollView addSubview:cellView];
    
}

- (void)stepperValueChanged:(id)sender {
    
    UIStepper *stepper = sender;
    NSInteger index = stepper.tag;
    double value = stepper.value;
    UILabel *label = self.scoreLabels[index];
    label.text = [NSString stringWithFormat:@"%d", (int)value];
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
