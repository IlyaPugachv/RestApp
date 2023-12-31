import UIKit

final class AlbumsTVC: UITableViewController {
    
    var user: User?
    var albums: [Album]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAlbums()
    }
    
    // MARK: - Override Table View
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { albums?.count ?? 0 }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let albom = albums?[indexPath.row]
        cell.textLabel?.text = albom?.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albom = albums?[indexPath.row]
        performSegue(withIdentifier: "showPhotos", sender: albom)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhotos",
           let vc = segue.destination as? PhotosCVC,
           let album = sender as? Album {
            vc.album = album
        }
    }
    
    // MARK: - FETCH Albums
    
    private func fetchAlbums() {
        guard let user = user else { return  }
        NetworkService.fetchAlbums(userID: user.id) { [weak self] albums, error in
            if let error = error {
                print(error)
            } else if let albums = albums {
                self?.albums = albums
                self?.tableView.reloadData()
            }
        }
    }
}
