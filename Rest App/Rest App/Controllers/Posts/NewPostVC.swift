import UIKit
import SwiftyJSON
import Alamofire

final class NewPostVC: UIViewController {
    
    // MARK: - @IBOutlet UITextField
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var bodyTV: UITextView!
    @IBOutlet weak var urlSessionBtn: UIButton!
    @IBOutlet weak var AFBtn: UIButton!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func postURLSession() {
        if let userId = user?.id,
           let title = titleTF.text,
           let body = bodyTV.text,
           let url = ApiConstants.postsURL {
            
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let postBodyJSON: [String: Any] = [
                "userId": userId,
                "title": title,
                "body": body
            ]
            
            let httpBody = try? JSONSerialization.data(withJSONObject: postBodyJSON)
            request.httpBody = httpBody
            
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                if let data = data {
                    _ = JSON(data)
                    DispatchQueue.main.async {
                        self?.navigationController?.popViewController(animated: true)
                    }
                }
            }.resume()
        }
    }
    
    @IBAction func postAlamofire() {
        if let userId = user?.id,
           let title = titleTF.text,
           let body = bodyTV.text,
           let url = ApiConstants.postsURL {
            
            let parameters: Parameters = [
                "userId": userId,
                "title": title,
                "body": body
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
    
    private func setupUI() {
        hideKeyboardWhenTappedAround()
        ButtonHelper.configureButton(button: urlSessionBtn, backgroundColor: .black)
        ButtonHelper.configureButton(button: AFBtn, backgroundColor: .black)
    }
}
