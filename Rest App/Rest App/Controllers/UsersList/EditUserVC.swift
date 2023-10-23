import UIKit
import SwiftyJSON
import Alamofire

final class EditUserVC: UIViewController {
    
    // MARK: - @IBOutlet UITextField
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surNameTextField: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var websiteTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var doneBtn: UIButton!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func doneBtnAction(_ sender: UIButton) {
        if let userId1 = user?.id,
           let nameTextField = nameTextField.text,
           let surNameTextField = surNameTextField.text,
           let emailTextField = emailTF.text,
           let phoneTextField = phoneTF.text,
           let websiteTextField = websiteTF.text,
           
            let url = ApiConstants.usersURL {
            
            let parameters: Parameters = [
                "userId": userId1,
                "name": nameTextField,
                "username": surNameTextField,
                "email": emailTextField,
                "phone": phoneTextField,
                "website": websiteTextField,
            ]
            
            AF.request("\(url)/\(userId1)", method: .patch, parameters: parameters, encoding: JSONEncoding.default)
                .response { [weak self] response in
                    switch response.result {
                    case .success:
                        self?.navigationController?.popViewController(animated: true)
                    case .failure(let error):
                        print(error)
                    }
                }
            self.dismiss(animated: true, completion: nil)
        }
    }
}
