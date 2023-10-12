import UIKit

class InfoVC: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var websiteLbl: UILabel!
    
    @IBOutlet weak var postsBtn: UIButton!
    @IBOutlet weak var AlbumsBtn: UIButton!
    @IBOutlet weak var toDoBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        
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
