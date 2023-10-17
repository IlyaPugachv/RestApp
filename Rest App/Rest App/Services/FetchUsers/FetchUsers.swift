import UIKit

//class FetchUsers {
//    
//    var users: [User] = []
//    
//     static func fetchUsers() {
//        
//        guard let usersURL = ApiConstants.usersURL else { return }
//        
//        URLSession.shared.dataTask(with: usersURL) { [weak self] data, response, error in
//            
//            guard let self else { return }
//            
//            if let error = error {
//                print(error)
//            }
//            
//            if let data = data {
//                do {
//                    self.users = try JSONDecoder().decode([User].self, from: data)
//                    print(users)
//                } catch {
//                    print(error)
//                }
//            }
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }.resume()
//    }
//}
