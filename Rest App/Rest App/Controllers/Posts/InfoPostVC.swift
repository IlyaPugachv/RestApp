import UIKit

final class InfoPostVC: UIViewController {
    
    // MARK: - @IBOutlet UILabel
    
    @IBOutlet weak var namePost: UILabel!
    @IBOutlet weak var surNamePost: UILabel!
    @IBOutlet weak var infoPostBtn: UIButton!
    
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        userData(post: post)
    }
    
    @IBAction func editPostBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "PostFlow", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "EditPostVC") as! EditPostVC
        vc.post = post
        navigationController?.present(vc, animated: true)
    }
    
    private func userData(post: Post?) {
        namePost.text = post?.title ?? "Error"
        surNamePost.text = post?.body ?? "Error"
    }
    
    private func setupUI() {
        ButtonHelper.configureButton(button: infoPostBtn, backgroundColor: .black)
    }
}
