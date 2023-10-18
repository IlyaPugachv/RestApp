import UIKit

class InfoPostVC: UIViewController {
    
    @IBOutlet weak var namePost: UILabel!
    @IBOutlet weak var surNamePost: UILabel!
    
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userData(post: post)
    }
    
    @IBAction func editPostBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "PostFlow", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "EditPostVC") as! EditPostVC
        vc.post = post
        navigationController?.present(vc, animated: true)
    }
    
    
    
    private func userData(post: Post?) {
        if let post = post {
            namePost.text = post.title
            surNamePost.text = post.body
        } else {
            namePost.text = "Error"
            surNamePost.text = "Error"
        }
    }
}
