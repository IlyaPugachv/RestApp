import UIKit

final class PhotosCVC: UICollectionViewController {
    
    var album: Album?
    var photos: [Photo]?
    var user: User?
    
    @IBOutlet var collectionViewCell: UICollectionView!
    
    // MARK: - Override func collectionView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "PhotoCVCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        fetchPhotos()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let layout = UICollectionViewFlowLayout()
        let sizeWH = UIScreen.main.bounds.width / 2 - 5
        layout.itemSize = CGSize(width: sizeWH, height: sizeWH)
        collectionView.collectionViewLayout = layout
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { photos?.count ?? 0 }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photo = photos?[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCVCell
        cell.thumbnailUrl = photo?.thumbnailUrl
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photos?[indexPath.row]
        let vc = PhotoVC()
        vc.photo = photo
        self.present(vc, animated: true)
    }
    
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let touchPoint = gestureRecognizer.location(in: collectionView)
            
            if let indexPath = collectionView.indexPathForItem(at: touchPoint) {
                showContextualMenu(at: indexPath)
            }
        }
    }

    private func showContextualMenu(at indexPath: IndexPath) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] (_) in
            self?.deleteThumbnail(at: indexPath)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        if let cell = collectionView.cellForItem(at: indexPath) {
            alertController.popoverPresentationController?.sourceView = cell
            alertController.popoverPresentationController?.sourceRect = cell.bounds
        }
        
        present(alertController, animated: true, completion: nil)
    }

    private func deleteThumbnail(at indexPath: IndexPath) {
        guard let photo = photos?[indexPath.row] else { return }
        
        NetworkService.deletePhoto(photoID: photo.id) { [weak self] result, error in
            if let error = error {
                print(error)
            } else {
                self?.photos?.remove(at: indexPath.row)
                self?.collectionView.deleteItems(at: [indexPath])
            }
        }
    }
    
    private func setupUI() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        collectionView.addGestureRecognizer(longPressGesture)
    }

    // MARK: - FETCH Photos
    
    private func fetchPhotos() {
        guard let album = album else { return }
        NetworkService.fetchPhotos(albumID: album.id) { [weak self] photos, error in
            if let error = error {
                print(error)
            } else if let photos = photos {
                self?.photos = photos
                self?.collectionView.reloadData()
            }
        }
    }
}
