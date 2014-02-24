//
//  SECViewController.m
//  Lab2
//
//  Created by Sara Clayton on 1/30/14.
//  Copyright (c) 2014 USC. All rights reserved.
//

#import "SECViewController.h"

@interface SECViewController ()

@property (weak, nonatomic) IBOutlet UITextField *numberTF;
@property (weak, nonatomic) IBOutlet UITextField *powerTF;
@property (weak, nonatomic) IBOutlet UITextField *animalTF;
@property (weak, nonatomic) IBOutlet UIView *settingsView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mealChoose;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageStepperLabel;
@property (weak, nonatomic) IBOutlet UISwitch *endingSwitch;

@end

@implementation SECViewController

- (IBAction)backgroundButton:(id)sender {
    [self.numberTF resignFirstResponder];
    [self.powerTF resignFirstResponder];
    [self.animalTF resignFirstResponder];
}

- (IBAction)toggleShowHide:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    NSInteger segment = segmentedControl.selectedSegmentIndex;
    
    if (segment ==0) { //Less
        [self.settingsView setHidden:YES];
    }
    else { //More
        [self.settingsView setHidden:NO];
    }
}

//why doesn't the slider work and why can't i click on anything after I use it?
- (IBAction)changeNumSlide:(UISlider *)sender {
    double value = [sender value];
    
    [self.ageLabel setText:[NSString stringWithFormat:@"%d", (int)value]];
}

//stepper change
- (IBAction)changeStepperValue:(UIStepper *)sender {
    double value = [sender value];
    
    [self.ageStepperLabel setText:[NSString stringWithFormat:@"%d", (int)value]];
}

- (IBAction)createStoryButton:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Are you ready for your story?"
                                  delegate:self
                                  cancelButtonTitle:nil
                                  destructiveButtonTitle:@"Yes!"
                                  otherButtonTitles: nil];
    
    actionSheet.delegate=self;
    //no cancel button on iPad
    [actionSheet showInView:self.view];
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        //not a property, so not self.createStory
        [self createStory];
        
        
    }
    
}

//do I put all of this code under the "message" part of UIAlertView?

-(void)createStory {
    BOOL happyEnding;
    NSString *meal;
    NSString *ending = nil;
    NSString *msg = nil;
    
    NSInteger segment = self.mealChoose.selectedSegmentIndex;
    if (segment == 0)
        meal = @"breakfast";
    else if (segment ==1)
        meal = @"lunch";
    else
        meal = @"dinner";
    
    happyEnding = self.endingSwitch.isOn;
    if (happyEnding==0) {
        ending = @"They crowned me as their emperor.";
    }
    else {
        ending = [[NSString alloc] initWithFormat: @"They tried to make me their %@.", meal];
    }

    
    //to create a message...
    if ((self.powerTF.text.length > 0) && (self.animalTF.text.length > 0)) {
        msg = [[NSString alloc] initWithFormat: @"When I was %@ years old, I received the gift of %@. I was able to help %@s with my power. I am now %@ years old. %@", self.numberTF.text, self.powerTF.text, self.animalTF.text, self.ageStepperLabel.text, ending];
        
    }
    
    else {
        msg = [[NSString alloc] initWithFormat: @"Please enter in all of text fields."];
    }
    
    NSUInteger len = [msg length];
    NSLog(@"%i", len);
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"Mad Libs Story"
                          message: msg
                          delegate:self
                          cancelButtonTitle:@"Done"
                          otherButtonTitles:nil];
    
    [alert show];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
