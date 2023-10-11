import UIKit

class ImageVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    private let imageURL = "https://w.forfun.com/fetch/55/550a7b8cefbad7d3b83f651aa7d8d46e.jpeg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
    }
    
    private func fetchImage() {
        
        guard let url = URL(string: imageURL) else { return }
        
        let urlRequest = URLRequest(url: url)
        
//        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
//            print(data)
//            print(response)
//            print(error)
//        }.resume()
        
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            
            DispatchQueue.main.async {
                
                self?.activityIndicatorView.stopAnimating()
                
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                if let response = response {
                    print(response)
                }
                
                if let data = data,
                let image = UIImage(data: data) {
                    self?.imageView.image = image
                } else {
                    // тут можно пользователю показать ошибку картинки
                }
            }
        }
        task.resume()
    }
}
