import UIKit
import Alamofire

final class UsersTVC: UITableViewController {
    
    var user: User?
    var users: [User] = []
    
    @IBAction func addUserAction(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "AddNewUserVC") as! AddNewUserVC
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Override View
    
    override func viewWillAppear(_ animated: Bool) { fetchUsers() }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { users.count }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.username
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "InfoVC") as! InfoVC
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let userId = users[indexPath.row].id
            NetworkService.deleteUser(userID: userId) { result, error in
                self.users.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    // MARK: - FETCH Users
    
    private func fetchUsers() {
        guard let usersURL = ApiConstants.usersURL else { return }
        
        URLSession.shared.dataTask(with: usersURL) { [weak self] data, response, error in
            
            guard let self else { return }
            
            if let error = error {
                print(error)
            }
            
            if let data = data {
                do {
                    self.users = try JSONDecoder().decode([User].self, from: data)
                    print(users)
                } catch {
                    print(error)
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.resume()
    }
}

