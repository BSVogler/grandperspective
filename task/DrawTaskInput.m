#import "DrawTaskInput.h"

#import "FileItem.h"
#import "TreeLayoutBuilder.h"


@implementation DrawTaskInput

- (instancetype) initWithVisibleTree:(FileItem *)visibleTree
                          treeInView:(FileItem *)treeInView
                       layoutBuilder:(TreeLayoutBuilder *)layoutBuilder
                              bounds:(NSRect) bounds {
  if (self = [super init]) {
    _visibleTree = visibleTree;
    _treeInView = treeInView;
    _layoutBuilder = layoutBuilder;
    _bounds = bounds;
  }
  return self;
}


@end
