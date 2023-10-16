import Foundation
import Alamofire
import SwiftyJSON
import AlamofireImage

class NetworkService {
    static func deletePost(postId: Int, callback: @escaping () -> ()) {
           let urlPath = "\(ApiConstants.postsPath)/\(postId)"
            AF.request(urlPath, method: .delete, encoding: JSONEncoding.default)
            .response { response in
                callback()
        }
    }
}

class NetworkService1 {
    static func deletePost(userId: Int, callback: @escaping () -> ()) {
           let urlPath = "\(ApiConstants.usersPath)/\(userId)"
            AF.request(urlPath, method: .delete, encoding: JSONEncoding.default)
            .response { response in
                callback()
        }
    }
} /// переименую и вынеси этот класс в отдельный файл!!!

        
    

