import Foundation

struct User: Decodable {
    let id: Int
    let name: String?
    let username: String?
    let email: String?
    let phone: String?
    let website: String?
//    let title: String?
//    let body: String?
    let address: Address?
    let company: Company?
}

//struct User111: Codable {
//    let name: String
//    let username: String
//    
//   
//}
