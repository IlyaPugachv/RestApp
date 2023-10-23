import UIKit

enum UserActions: String, CaseIterable {
    case downloadImage = "Download image"
    case users = "Open users list"
}

final class CollectionVC: UICollectionViewController {
    
    private let reuseIdentifier = "Cell"
    private let userActions = UserActions.allCases
    
    // MARK: - Override Colection View
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { userActions.count }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ActionCVCell
        let userAction = userActions[indexPath.row].rawValue
        cell.infoLbl.text = userAction
        cell.layer.cornerRadius = 30
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.row]
        switch userAction {
        case .downloadImage: performSegue(withIdentifier: "goToImageVC", sender: nil)
        case .users: performSegue(withIdentifier: "openUsersList", sender: nil)
        }
    }
}

// MARK: - Extension UICollectionViewDelegateFlowLayout

extension CollectionVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { CGSize(width: UIScreen.main.bounds.width - 50, height: 80) } }

