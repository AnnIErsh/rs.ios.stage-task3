#import "LevelOrderTraversal.h"

typedef struct sNode
{
    NSInteger values;
    struct sNode *left;
    struct sNode *right;
    
} MyNode;

NSInteger GetLevelProcess(MyNode *node, NSInteger values, NSInteger level)
{
    if (node == NULL)
        return 0;
    if ((*node).values == values)
        return level;
    NSInteger end = GetLevelProcess((*node).left, values, level + 1);
    if (end)
        return end;
    end = GetLevelProcess((*node).right, values, level + 1);
    return end;
}

NSInteger GetLevel(MyNode *node, NSInteger values)
{
    return GetLevelProcess(node, values, 1);
}

MyNode *NewNode(NSInteger values)
{
    MyNode *node = (MyNode*)malloc(sizeof(MyNode));
    (*node).left = NULL;
    (*node).right = NULL;
    (*node).values = values;
    return node;
}

MyNode* InsertMyNode(MyNode* node, NSInteger values)
{
    if (node == NULL)
        return NewNode(values);
    if (values < (*node).values)
        (*node).left = InsertMyNode((*node).left, values);
    else if (values > (*node).values)
        (*node).right = InsertMyNode((*node).right, values);
    return node;
}

MyNode* InsertMyNodeWrongOrder(MyNode* node, NSInteger values, NSInteger empty)
{
    if (node == NULL)
        return NewNode(values);
    if (!empty || values < (*node).values)
        (*node).left = InsertMyNodeWrongOrder((*node).left, values, empty);
    else if (empty || (values > (*node).values))
    {
        empty = 0;
        (*node).right = InsertMyNodeWrongOrder((*node).right, values, empty);
    }
    return node;
}

BOOL CompareResults(int a, int b, char sign)
{
    BOOL res = NO;
    if (sign == '<')
        res = a < b;
    if (sign == '>')
        res = a > b;
    return res;
}

char CheckOrderOfTree(NSArray *tree)
{
    char order = '\0';
    NSNumber *n = 0;
    NSNumber *m = 0;
    tree[0] == [NSNull null] ? (m = @0) : (m = tree[0]);
    tree[1] == [NSNull null] ? (n = @0) : (n = tree[1]);
    [m intValue] > [n intValue] ? (order = '<') : (order = '>');
    return order;
}

NSArray *CheckArray(NSArray *tree, MyNode *root)
{
    NSMutableArray *levels = [NSMutableArray array];
    NSMutableArray *arr = [NSMutableArray array];
    NSMutableArray *results = [NSMutableArray array];
    for (int i = 0; i < tree.count; i++)
    {
        while (tree[i] == [NSNull null])
            i++;
        NSInteger lvl = GetLevel(root, [tree[i] intValue]);
        [levels addObject:@(lvl)];
        [arr addObject:tree[i]];
    }
    NSSet *set = [NSSet setWithArray:levels];
    for (int j = 0; j < set.count; j++)
        [results addObject:[@[] mutableCopy]];
    [results[0] addObject:arr[0]];
    for (int j = 1; j < arr.count; j++)
    {
        NSNumber *tmp = levels[j];
        if ([set containsObject:tmp])
            [results[tmp.intValue - 1] addObject:arr[j]];
    }
    return results;
}

NSArray *CheckValidArrayOfTree(NSArray *tree) {
    NSMutableArray *levels = [@[] mutableCopy];
    NSMutableArray *arr = [[tree subarrayWithRange:NSMakeRange(1, tree.count - 1)] mutableCopy];
    [levels addObject:[@[] mutableCopy]];
    int i = 0;
    char order = CheckOrderOfTree(tree);
    NSNumber *n = 0;
    NSNumber *m = 0;
    for (id numb in arr)
    {
        NSMutableArray *tmp = levels[i];
        tmp.lastObject == [NSNull null] ? (m = @0) : (m = tmp.lastObject);
        numb == [NSNull null] ? (n = @0) : (n = (NSNumber*)numb);
        if (CompareResults(n.intValue, m.intValue, order))
            [tmp addObject:numb];
        else
        {
            [levels addObject:[@[numb] mutableCopy]];
            i++;
        }
    }
    levels[0][0] = tree.firstObject;
    return levels;
}

NSArray *LevelOrderTraversalForTree(NSArray *tree) {
    if (!tree.count || [tree isEqualToArray:@[[NSNull null]]])
        return @[];
    if (tree.count == 1)
        return @[@[tree[0]]];
    int isWrong = 0;
    NSArray *checkedArr = CheckValidArrayOfTree(tree);
    for (NSArray *obj in checkedArr)
    {
        if (obj.firstObject == [NSNull null] &&
            obj.lastObject != [NSNull null])
            isWrong = 1;
    }
    MyNode *root = NewNode([tree.firstObject intValue]);
    NSMutableArray *arr = [[tree subarrayWithRange:NSMakeRange(1, tree.count - 1)] mutableCopy];
    NSNumber *n = @0;
    int empty = 0;
    for (int j = 0; j < arr.count; j++)
    {
        if (!isWrong)
        {
            (arr[j] == [NSNull null]) ? (n = @0) : (n = arr[j]);
            InsertMyNode(root, n.intValue);
        }
        else
        {
            empty = 0;
            while (arr[j] == [NSNull null])
            {
                j++;
                empty++;
            }
            n = arr[j];
            InsertMyNodeWrongOrder(root, n.intValue, empty);
        }
    }
    return CheckArray(tree, root);
}
