import UIKit
import SwiftyJSON
import Alamofire

class EditPostVC: UIViewController {
    
    @IBOutlet weak var namePostTF: UITextField!
    @IBOutlet weak var surNamePostTF: UITextField!
    
    var post: Post?
    
    @IBAction func doneBtnAction(_ sender: UIButton) {
        if let postId = post?.id,
           let namePostTF = namePostTF.text,
           let surNamePostTF = surNamePostTF.text,
           
            let url = ApiConstants.postsURL {
            
            let parameters: Parameters = [
                "title": namePostTF,
                "body": surNamePostTF,
            ]
            
            AF.request("\(url)/\(postId)", method: .patch, parameters: parameters, encoding: JSONEncoding.default)
                .response { [weak self] response in
                    switch response.result {
                    case .success:
                        self?.navigationController?.popViewController(animated: true)
                    case .failure(let error):
                        print(error)
                    }
                }
        }
    }
}

