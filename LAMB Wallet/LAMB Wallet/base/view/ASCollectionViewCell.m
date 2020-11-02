
#import "ASCollectionViewCell.h"

@implementation ASCollectionViewCell

+ (instancetype)cellFromCollectinoView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath {
    ASCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: NSStringFromClass(self) forIndexPath:indexPath];
    return cell;
}


@end
