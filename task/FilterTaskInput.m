#import "FilterTaskInput.h"

@implementation FilterTaskInput

- (instancetype) initWithTreeContext:(TreeContext *)treeContext
                           filterSet:(FilterSet *)filterSet {
  if (self = [super init]) {
    _treeContext = treeContext;
    _filterSet = filterSet;
  }
  return self;
}


@end
