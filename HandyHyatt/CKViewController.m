#import <CoreGraphics/CoreGraphics.h>
#import "CKViewController.h"
#import "CKCalendarView.h"
#import <Parse/Parse.h>

@interface CKViewController () <CKCalendarDelegate>

@property(nonatomic, weak) CKCalendarView *calendar;
@property(nonatomic, strong) UILabel *dateLabel;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property(nonatomic, strong) NSDate *minimumDate;
@property(nonatomic, strong) NSMutableArray *disabledDates;


@property(nonatomic, strong) IBOutlet UIView *selectedDateView;
@property(nonatomic, strong) IBOutlet UILabel *selectedDateLabel;
@property(nonatomic, weak) IBOutlet UIImageView *bgImageView;


// "day/monthyear" => ["Shift(P/M)", "Shift2(P/M)", "Shift3(P/M)", ..., "ShiftN(P/M)"]
@property(nonatomic, strong) NSMutableDictionary *scheduleDates;


@end

@implementation CKViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)closeSelectedView:(id)sender {
    
    NSArray *viewsToRemove = [_selectedDateView subviews];
    for (UIView *v in viewsToRemove) {
        if (v.tag == 2) {
            [v removeFromSuperview];
        }
    }
    
    _selectedDateView.hidden = YES;
}

- (void) viewWillAppear:(BOOL)animated
{
    //applying background for the calendar
    UIImage *bg=self.bgImage;
    [self.bgImageView setImage:bg];
    

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     [self.navigationController viewDidAppear:false];
    
    
    
    
    //Get from parse
    
    PFQuery *query = [PFQuery queryWithClassName:@"Schedule"];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    NSArray *stuff = [query findObjects];

   
    _scheduleDates = [[NSMutableDictionary alloc] init];
    
    for (NSDictionary *data in stuff) {
        NSDate *from = [data objectForKey:@"from"];
        NSDate *to = [data objectForKey:@"to"];
        
        
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:from];
        NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:to];
        
        NSString *date = [NSString stringWithFormat:@"%ld/%ld/%ld", (long)[components day], (long)[components month], (long)[components year]];
        
        NSString *toStrFrom = [NSString stringWithFormat:@"%ld:%ld - %ld:%ld", (long)[components hour], (long)[components minute], (long)[components2 hour], (long)[components2 minute]];
        
        if ([_scheduleDates objectForKey:date] == nil) {
            [_scheduleDates setObject:@[] forKey:date];
        }
        
        NSMutableArray *temp = [[_scheduleDates objectForKey:date] mutableCopy];
        [temp addObject:toStrFrom];
        
        [_scheduleDates setObject:temp forKey:date];
        
    }
    
    //Load shedule
//    _scheduleDates = [NSDictionary dictionaryWithObjectsAndKeys:
//                      @[@"12:00P - 4:30P"],
//                      @"28/11/2014",
//                      @[@"8:00A - 11:30A", @"12:30P - 4:30P"],
//                      @"29/11/2014",
//                      @[@"8:00A - 11:30A", @"12:30P - 4:30P"],
//                      @"30/11/2014", nil];
    
    self.bgImageView.image = self.bgImage;
    
	// Do any additional setup after loading the view, typically from a nib.
    CKCalendarView *calendar = [[CKCalendarView alloc] initWithStartDay:startMonday];
    self.calendar = calendar;
    calendar.delegate = self;
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
    self.minimumDate = [self.dateFormatter dateFromString:@"20/09/2012"];
    
    self.disabledDates = [@[] mutableCopy];
    
    for (NSString* key in _scheduleDates) {
        [_disabledDates addObject:[self.dateFormatter dateFromString:key]];
    }
    
    calendar.onlyShowCurrentMonth = NO;
    calendar.adaptHeightToNumberOfWeeksInMonth = YES;
    
    calendar.frame = CGRectMake(162, 30, 700, 600);
    [self.view addSubview:calendar];
//    
//    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(calendar.frame) + 4, self.view.bounds.size.width, 24)];
//    [self.view addSubview:self.dateLabel];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange) name:NSCurrentLocaleDidChangeNotification object:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)localeDidChange {
    [self.calendar setLocale:[NSLocale currentLocale]];
}

- (BOOL)dateIsDisabled:(NSDate *)date {
    for (NSDate *disabledDate in self.disabledDates) {
        if ([disabledDate isEqualToDate:date]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark -
#pragma mark - CKCalendarDelegate

- (void)calendar:(CKCalendarView *)calendar configureDateItem:(CKDateItem *)dateItem forDate:(NSDate *)date {
    // TODO: play with the coloring if we want to...
    if ([self dateIsDisabled:date]) {
        dateItem.backgroundColor = [UIColor colorWithRed:120.0f/255.0f green:161.0f/255.0f blue:204.0f/255.0f alpha:0.6f];
        dateItem.textColor = [UIColor whiteColor];
    }
}

- (BOOL)calendar:(CKCalendarView *)calendar willSelectDate:(NSDate *)date {
    return YES;
    return ![self dateIsDisabled:date];
}

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date {
//    self.dateLabel.text = [self.dateFormatter stringFromDate:date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"d/MM/yyyy"];
    
    NSString *stringFromDate = [formatter stringFromDate:date];
    
    if ([_scheduleDates objectForKey:stringFromDate] != nil) {
        
        NSArray *datesArr = [_scheduleDates objectForKey:stringFromDate];
        
        int i = 1;
        for (NSString *dates in datesArr) {
            _selectedDateLabel.text = stringFromDate;
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 50*i+20, 200, 24)];
            label.text = dates;
            label.font = [UIFont fontWithName:@"Verdana" size:18.0f];
            label.textColor = [UIColor colorWithRed:128/255 green:130/255 blue:132/255 alpha:1.0];
            label.tag = 2;
            
            [_selectedDateView addSubview:label];
            i++;
        }
        
        _selectedDateView.hidden = NO;
        [self.view bringSubviewToFront:_selectedDateView];
    }
    
}

- (void)calendar:(CKCalendarView *)calendar didLayoutInRect:(CGRect)frame {
    NSLog(@"calendar layout: %@", NSStringFromCGRect(frame));
}

@end