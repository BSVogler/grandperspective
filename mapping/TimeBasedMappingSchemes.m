#import "TimeBasedMappingSchemes.h"

#import "FileItem.h"
#import "TimeBasedMapping.h"

@interface MappingByCreation : TimeBasedMapping
@end // @interface MappingByCreation

@interface MappingByModification : TimeBasedMapping
@end // @interface MappingByModification

@interface MappingByAccess : TimeBasedMapping
@end // @interface MappingByAccess


@implementation CreationMappingScheme

- (FileItemMapping *)fileItemMappingForTree:(DirectoryItem *)tree {
  return [[MappingByCreation alloc] initWithTree: tree];
}

@end // @implementation CreationMappingScheme

@implementation ModificationMappingScheme

- (FileItemMapping *)fileItemMappingForTree:(DirectoryItem *)tree {
  return [[MappingByModification alloc] initWithTree: tree];
}

@end // @implementation ModificationMappingScheme

@implementation AccessMappingScheme

- (FileItemMapping *)fileItemMappingForTree:(DirectoryItem *)tree {
  return [[MappingByAccess alloc] initWithTree: tree];
}

@end // @implementation AccessMappingScheme


@implementation MappingByCreation

- (CFAbsoluteTime) timeForFileItem:(FileItem *)fileItem {
  return fileItem.creationTime;
}

@end // @implementation MappingByCreation

@implementation MappingByModification

- (CFAbsoluteTime) timeForFileItem:(FileItem *)fileItem {
  return fileItem.modificationTime;
}

@end // @implementation MappingByModification


@implementation MappingByAccess

- (CFAbsoluteTime) timeForFileItem:(FileItem *)fileItem {
  return fileItem.accessTime;
}

@end // @implementation MappingByAccess
