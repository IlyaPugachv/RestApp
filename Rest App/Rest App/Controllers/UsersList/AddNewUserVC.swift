import UIKit
import SwiftyJSON
import Alamofire

final class AddNewUserVC: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var surNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var websiteTF: UITextField!
    
    var user: User?
    
    @IBAction func doneBtn(_ sender: UIButton) {
        if let nameTF = nameTF.text,
           let surNameTF = surNameTF.text,
           let emailTF = emailTF.text,
           let phoneTF = phoneTF.text,
           let websiteTF = websiteTF.text,
           
            let url = ApiConstants.usersURL {
            
            let parameters: Parameters = [
                "name": nameTF,
                "username": surNameTF,
                "email": emailTF,
                "phone": phoneTF,
                "website": websiteTF
            ]
            
            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
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
