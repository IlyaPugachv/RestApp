import UIKit

class ImageVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    private let imageURL = "https://images.squarespace-cdn.com/content/v1/535dcb0ce4b03ecd54f29b7a/1418620135456-Y2D9IJ7CVKOYADX7ZOGK/impala+poster+11x16.5+night+exclusive.jpg"
    
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
