import UIKit
import MapKit
import Alamofire
import AlamofireImage

final class InfoVC: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var websiteLbl: UILabel!
    @IBOutlet weak var AddresLbl: UILabel!
    
    @IBOutlet weak var postsBtn: UIButton!
    @IBOutlet weak var AlbumsBtn: UIButton!
    @IBOutlet weak var toDoBtn: UIButton!
    @IBOutlet weak var openMapsBtn: UIButton!
    @IBOutlet weak var editUserBtn: UIButton!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        userData(user: user)
    }
        
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
        /// здесь у нас будет срабатываь открытие наших ToDo
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
                AddresLbl.text = "\(city)\n\(street)\n\(suite)\n\(zipcode)"
            } else {
                AddresLbl.text = "Address unknown"
            }
        }
    }
    
    private func setupUI() {
        openMapsBtn.backgroundColor = UIColor.darkGray
        openMapsBtn.tintColor = .white
        openMapsBtn.layer.cornerRadius = postsBtn.bounds.height / 2
        openMapsBtn.clipsToBounds = true
        
        editUserBtn.backgroundColor = UIColor.darkGray
        editUserBtn.tintColor = .white
        editUserBtn.layer.cornerRadius = postsBtn.bounds.height / 2
        editUserBtn.clipsToBounds = true
        
        postsBtn.backgroundColor = UIColor.darkGray
        postsBtn.tintColor = .white
        postsBtn.layer.cornerRadius = postsBtn.bounds.height / 2
        postsBtn.clipsToBounds = true
        
        AlbumsBtn.backgroundColor = UIColor.darkGray
        AlbumsBtn.tintColor = .white
        AlbumsBtn.layer.cornerRadius = postsBtn.bounds.height / 2
        AlbumsBtn.clipsToBounds = true
        
        toDoBtn.backgroundColor = UIColor.darkGray
        toDoBtn.tintColor = .white
        toDoBtn.layer.cornerRadius = postsBtn.bounds.height / 2
        toDoBtn.clipsToBounds = true
    }
}
