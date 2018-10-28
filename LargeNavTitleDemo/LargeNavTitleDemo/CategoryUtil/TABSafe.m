//
//  NSObject+TABSafe.m
//  TABBaseProject
//
//  Created by tigerAndBull on 2018/10/4.
//  Copyright © 2018年 tigerAndBull. All rights reserved.
//

#import "TABSafe.h"

@implementation NSString (TABSafe)

- (BOOL)tab_isValue {
    
    if (self != nil && ![self isKindOfClass:[NSNull class]] && self.length > 0) {
        return YES;
    }else {
        return NO;
    }
}

@end

@implementation NSData (TABSafe)

- (BOOL)tab_isValue {
    
    if (self != nil && ![self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    return NO;
}

@end

@implementation NSObject (TABSafe)

- (BOOL)tab_isValue {
    
    if (self != nil && ![self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    return NO;
}

@end

@implementation NSArray (TABSafe)

- (BOOL)tab_isValue {
    
    if (self != nil && ![self isKindOfClass:[NSNull class]] && self.count > 0) {
        return YES;
    }
    return NO;
}

- (id)tab_safeObjectAtIndex:(NSUInteger)index {
    
    if ([self tab_isValue] && index < self.count) {
        id value = [self objectAtIndex:index];
        return value;
    }
    return nil;
}

@end

@implementation NSMutableArray (TABSafe)

- (void)tab_addObject:(id)object {
    
    if ([object tab_isValue]) {
        [self addObject:object];
    }
}

- (void)tab_insertObject:(id)object atIndex:(NSUInteger)index {
    
    if ([object tab_isValue] && index <= self.count) {
        [self insertObject:object atIndex:index];
    }
}

@end

@implementation NSDictionary (TABSafe)

- (BOOL)tab_isValue {
    
    if (self != nil && ![self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    return NO;
}

- (int)tab_safeIntForKey:(NSString *)key {
    
    if ([self tab_isValue] && [key tab_isValue]) {
        
        id value = [self objectForKey:key];
        
        if ([value tab_isValue]) {
            return [value intValue];
        }
    }
    return 0;
}

- (BOOL)tab_safeBoolForKey:(NSString *)key {
    
    if ([self tab_isValue] && [key tab_isValue]) {
        
        id value = [self objectForKey:key];
        
        if ([value tab_isValue]) {
            return [value boolValue];
        }
    }
    return NO;
}

- (float)tab_safeFloatForKey:(NSString *)key {
    
    if ([self tab_isValue] && [key tab_isValue]) {
        
        id value = [self objectForKey:key];
        
        if ([value tab_isValue]) {
            return [value floatValue];
        }
    }
    return 0.0f;
}

- (double)tab_safeDoubleForKey:(NSString *)key {
    
    if ([self tab_isValue] && [key tab_isValue]) {
        
        id value = [self objectForKey:key];
        
        if ([value tab_isValue]) {
            return [value doubleValue];
        }
    }
    return 0.0f;
}

- (long long)tab_safeLongLongForKey:(NSString *)key {
    
    if ([self tab_isValue] && [key tab_isValue]) {
        
        id value = [self objectForKey:key];
        
        if ([value tab_isValue]) {
            return [value longLongValue];
        }
    }
    return 0.0f;
}

- (NSString *)tab_safeStringForKey:(NSString *)key {
    
    if ([self tab_isValue] && [key tab_isValue]) {
        
        id value = [self objectForKey:key];

        if ([value isKindOfClass:[NSString class]] && [value tab_isValue]) {
            return [NSString stringWithFormat:@"%@",value];
        }
    }
    return @"";
}

- (NSDictionary *)tab_safeDictionaryForKey:(NSString *)key {
    
    if ([self tab_isValue] && [key tab_isValue]) {
        
        id value = [self objectForKey:key];
        
        if ([value isKindOfClass:[NSDictionary class]] && [value tab_isValue]) {
            return value;
        }
    }
    return nil;
}

- (NSArray *)tab_safeArrayForKey:(NSString *)key {
    
    if ([self tab_isValue] && [key tab_isValue]) {
        
        id value = [self objectForKey:key];
        
        if ([value isKindOfClass:[NSArray class]] && [value tab_isValue]) {
            return value;
        }
    }
    return nil;
}

- (id)tab_safeObjectForKey:(NSString *)key {
    
    if ([self tab_isValue] && [key tab_isValue]) {
        
        id value = [self objectForKey:key];
        
        if ([value isKindOfClass:[NSObject class]] && [value tab_isValue]) {
            return value;
        }
    }
    return nil;
}

@end

@implementation NSMutableDictionary (TABSafe)

- (void)tab_setObject:(id)object Key:(NSString *)key {
    
    if ([self tab_isValue] && [object tab_isValue] && [key tab_isValue]) {
        [self setObject:object forKey:key];
    }
}

@end

@implementation NSNumber (TABSafe)

- (BOOL)tab_isValue {
    
    if (self != nil && ![self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    return NO;
}

@end
