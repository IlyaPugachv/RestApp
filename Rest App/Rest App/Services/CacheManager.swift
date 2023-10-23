import Foundation
import Alamofire
import AlamofireImage

// MARK: - CacheManager

final class CacheManager {
    
    private init() {}
    
    static let shared = CacheManager()
    
    let imageCache = AutoPurgingImageCache(
        memoryCapacity: 100_000_000,
        preferredMemoryUsageAfterPurge: 60_000_000
    )
}
