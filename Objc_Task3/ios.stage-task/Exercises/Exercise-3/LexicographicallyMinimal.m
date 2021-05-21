#import "LexicographicallyMinimal.h"

@interface LexicographicallyMinimal()

@property (nonatomic, strong) NSMutableString *resultString;

@end

@implementation LexicographicallyMinimal

-(NSString *)findLexicographicallyMinimalForString1:(NSString *)string1 andString2:(NSString *)string2 {
    NSMutableString *str = [NSMutableString string];
    const char *s1 = [string1 UTF8String];
    const char *s2 = [string2 UTF8String];
    size_t len1 = string1.length;
    size_t len2 = string2.length;
    int i = 0;
    int j = 0;
    for ( ;i < string1.length && j < string2.length; )
    {
       if (*(s1 + i) <= *(s2 + j))
       {
           [str appendString:[NSString stringWithFormat:@"%c", *(s1 + i)]];
           i++;
           len1--;
       }
       else
       {
           [str appendString:[NSString stringWithFormat:@"%c", *(s2 + j)]];
           j++;
           len2--;
       }
    }
    if (len1)
        [str appendString:[string1 substringFromIndex:i]];
    if (len2)
        [str appendString:[string2 substringFromIndex:j]];
    return str;
}

@end
