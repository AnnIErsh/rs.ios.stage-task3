#import "DateHelper.h"

@implementation DateHelper

#pragma mark - First

-(NSString *)monthNameBy:(NSUInteger)monthNumber {
    if (monthNumber < 1 || monthNumber > 12)
        return nil;
    NSDateFormatter *formatterForMonth = [NSDateFormatter new];
    NSArray *months = formatterForMonth.monthSymbols;
    NSString *str = months[monthNumber - 1];
    return str;
}

#pragma mark - Second

- (long)dayFromDate:(NSString *)date {
    NSDateFormatter *form = [NSDateFormatter new];
    form.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    NSDate *myDate = [form dateFromString:date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSInteger day = [cal component:NSCalendarUnitDay fromDate:myDate];
    return day;
}

#pragma mark - Third

- (NSString *)getDayName:(NSDate*) date {
    return nil;
}

#pragma mark - Fourth

- (BOOL)isDateInThisWeek:(NSDate *)date {
    return NO;
}

@end
