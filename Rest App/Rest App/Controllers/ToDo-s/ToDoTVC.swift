import UIKit

class ToDoTVC: UITableViewController {
    
    var user: User?
    var toDo: [ToDo]?

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchToDo()
    }

    // MARK: - Override func tableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { toDo?.count ?? 0 }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let toDo = toDo?[indexPath.row]
        cell.textLabel?.text = toDo?.title
        return cell
    }
    
    // MARK: - FETCH TODO
    
    private func fetchToDo() {
        let userId = user?.id.description ?? ""
        let urlPath = "\(ApiConstants.todosPath)?userId=\(userId)"
        guard let url = URL(string: urlPath) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self,
                  let data = data else { return }
            do {
                toDo = try JSONDecoder().decode([ToDo].self, from: data)
            } catch let error {
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
}

