#import "NamedFilter.h"

#import "Filter.h"


@implementation NamedFilter

+ (NamedFilter *)emptyFilterWithName:(NSString *)name {
  return [[NamedFilter alloc] initWithFilter: [Filter filter] name: name];
}

+ (NamedFilter *)namedFilter:(Filter *)filter name:(NSString *)name {
  return [[NamedFilter alloc] initWithFilter: filter name: name];
}


- (instancetype) initWithFilter:(Filter *)filter name:(NSString *)name {
  return [self initWithFilter: filter name: name implicit: NO];
}

- (instancetype) initWithFilter:(Filter *)filter name:(NSString *)name implicit:(BOOL)implicit {
  if (self = [super init]) {
    _filter = filter;
    _name = name;
    _isImplicit = implicit;
  }
  return self;
}


- (NSString *)localizedName {
  return [NSBundle.mainBundle localizedStringForKey: self.name value: nil table: @"Names"];
}

@end
