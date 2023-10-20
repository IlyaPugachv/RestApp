import UIKit
import SwiftyJSON
import Alamofire

final class EditUserVC: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surNameTextField: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var websiteTF: UITextField!
    @IBOutlet weak var doneBtn: UIButton!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func doneBtnAction(_ sender: UIButton) {
        if let userId1 = user?.id,
           let nameTextField = nameTextField.text,
           let surNameTextField = surNameTextField.text,
           let emailTF = emailTF.text,
           let phoneTF = phoneTF.text,
           let website = websiteTF.text,
           
            let url = ApiConstants.usersURL {
            
            let parameters: Parameters = [
                "userId": userId1,
                "name": nameTextField,
                "username": surNameTextField,
                "email": emailTF,
                "phone": phoneTF,
                "website": website,
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
    
    private func setupUI() {
        hideKeyboardWhenTappedAround()
        ButtonHelper.configureButton(button: doneBtn, backgroundColor: .black) /// не работает!
    }
}
