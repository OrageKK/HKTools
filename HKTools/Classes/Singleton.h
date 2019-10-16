
#define singleton_h(name) +(instancetype)shared##name;

#if __has_feature(objc_arc)
// ARC
#define singleton_m(name) static id _instance;\
\
+(instancetype)shared##name\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
\
_instance = [[self alloc] init];\
\
});\
\
return _instance;\
}\
\
\
-(id)copyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
\
+(instancetype)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
\
return _instance;\
}

#else
// MRC
#define singleton_m(name) static id _instance;\
\
+(instancetype)shared##name\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
\
_instance = [[self alloc] init];\
\
});\
\
return _instance;\
}\
\
\
-(id)copyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
\
+(instancetype)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
\
return _instance;\
}\
-(instancetype)retain\
{\
    return _instance;\
}\
\
-(NSUInteger)retainCount\
{\
    return 1;\
}\
\
-(oneway void)release\
{\
    \
}\
\
-(instancetype)autorelease\
{\
    return _instance;\
}

#endif




