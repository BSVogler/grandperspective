#import "FilterTest.h"


@implementation FilterTest

+ (instancetype) filterTestWithName:(NSString *)name fileItemTest:(FileItemTest *)fileItemTest {
  return [[FilterTest alloc] initWithName: name fileItemTest: fileItemTest];
}

// Designated initialiser.
- (instancetype) initWithName:(NSString *)name fileItemTest:(FileItemTest *)fileItemTest {
  if (self = [super init]) {
    _name = name;
    _fileItemTest = fileItemTest;
  }
  return self;
}


@end
