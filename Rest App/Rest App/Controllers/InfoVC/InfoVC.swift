import UIKit
import MapKit
import Lottie

final class InfoVC: UIViewController {
    
    // MARK: - @IBOutlet UILabel
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var websiteLbl: UILabel!
    @IBOutlet weak var addresLbl: UILabel!
    
    // MARK: - @IBOutlet UIButton
    
    @IBOutlet weak var postsBtn: UIButton!
    @IBOutlet weak var albumsBtn: UIButton!
    @IBOutlet weak var toDoBtn: UIButton!
    @IBOutlet weak var openMapsBtn: UIButton!
    @IBOutlet weak var editUserBtn: UIButton!
    
    var user: User?
    private let lottieView = LottieAnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        userData(user: user)
    }
    
    // MARK: - @@IBAction
    
    @IBAction func mapBtnAction(_ sender: UIButton) { openMapsForUserLocation() }
    
    @IBAction func editBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "EditUserVC") as! EditUserVC
        vc.user = user
        navigationController?.present(vc, animated: true)
    }
    
    @IBAction func postsBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "PostFlow", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "PostsTVC") as! PostsTVC
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func albumsBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "AlbumsAndPhotos", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "AlbumsTVC") as! AlbumsTVC
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func toDoBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "ToDo", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ToDoTVC") as! ToDoTVC
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func openMapsForUserLocation() {
        if let user = user,
           let latitudeString = user.address?.geo?.lat,
           let longitudeString = user.address?.geo?.lng,
           let latitude = Double(latitudeString),
           let longitude = Double(longitudeString)
        {
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let placemark = MKPlacemark(coordinate: coordinate)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = user.name
            mapItem.openInMaps(launchOptions: nil)
        }
    }
    
    private func userData(user: User?) {
        if let user = user {
            nameLbl.text = user.name
            userNameLbl.text = user.username
            emailLbl.text = user.email
            phoneLbl.text = user.phone
            websiteLbl.text = user.website
            if let city = user.address?.city,
               let street = user.address?.street,
               let suite = user.address?.suite,
               let zipcode = user.address?.zipcode {
                addresLbl.text = "\(city)\n\(street)\n\(suite)\n\(zipcode)"
            } else {
                addresLbl.text = "Address unknown"
            }
        }
    }
    
    private func setupUI() {
        setupLottieAnimation()
        ButtonHelper.configureButton(button: postsBtn, backgroundColor: .black)
        ButtonHelper.configureButton(button: albumsBtn, backgroundColor: .black)
        ButtonHelper.configureButton(button: toDoBtn, backgroundColor: .black)
        ButtonHelper.configureButton(button: openMapsBtn, backgroundColor: .black)
        ButtonHelper.configureButton(button: editUserBtn, backgroundColor: .black)
    }
    
    private func setupLottieAnimation() {
        let animation = LottieAnimation.named("animation3")
        lottieView.animation = animation
        lottieView.contentMode = .scaleAspectFit
        lottieView.loopMode = .playOnce
        lottieView.play()
        
        lottieView.frame = CGRect(x: view.frame.width - 80, y: 60, width: 65, height: 65)
        view.addSubview(lottieView)
    }
}
