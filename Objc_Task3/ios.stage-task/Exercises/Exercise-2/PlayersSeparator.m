#import "PlayersSeparator.h"

@implementation PlayersSeparator

- (NSInteger)dividePlayersIntoTeams:(NSArray<NSNumber *>*)ratingArray {
    NSInteger countInc = [self checkArray:ratingArray withSigh:'<'];
    NSInteger countDec = [self checkArray:ratingArray withSigh:'>'];
    return (countInc + countDec);
}

-(NSInteger)checkArray:(NSArray<NSNumber *>*)ratingArray withSigh:(char)sign {
    NSNumber *tmpI = 0;
    NSNumber *tmpJ = 0;
    NSNumber *tmpK = 0;
    int count = 0;
    NSMutableArray<NSNumber *> *arr = [NSMutableArray array];
    for (int i = 0; i < ratingArray.count; i++)
    {
        tmpI = ratingArray[i];
        [arr addObject:tmpI];
        for (int j = i; j < ratingArray.count; j++)
        {
            tmpJ = ratingArray[j];
            if ([self compareResults:tmpI.intValue and:tmpJ.intValue withSign:sign])
            {
                [arr addObject:tmpJ];
                for (int k = j; k < ratingArray.count; k++)
                {
                    tmpK = ratingArray[k];
                    if ([self compareResults:tmpJ.intValue and:tmpK.intValue withSign:sign])
                    {
                        [arr addObject:tmpK];
                        count++;
                    }
                }
            }
        }
    }
    return count;
}

-(BOOL)compareResults:(int)a and:(int)b withSign:(char)sign {
    BOOL res = NO;
    if (sign == '<')
        res = a < b;
    if (sign == '>')
        res = a > b;
    return res;
}

@end
