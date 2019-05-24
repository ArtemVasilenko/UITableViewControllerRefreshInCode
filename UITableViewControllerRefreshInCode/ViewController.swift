
import UIKit

class ViewController: UIViewController {
    
    let tableVC = UITableViewController(style: .plain)
    let id = "Cell"
    var allTime = [Date]()
    let refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTableView()
        refresh.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        refresh.tintColor = .red
        tableVC.tableView.addSubview(refresh)
        self.view.addSubview(tableVC.tableView)
    }
    
    func createTableView() {
        tableVC.tableView.register(UITableViewCell.self, forCellReuseIdentifier: id)
        tableVC.tableView.delegate = self
        tableVC.tableView.dataSource = self
    }
    
    @objc func handleRefresh() {
        allTime.append(Date())
        refresh.endRefreshing()
        
        let indexPathNewRow = IndexPath(row: allTime.count - 1, section: 0)
        tableVC.tableView.insertRows(at: [indexPathNewRow], with: .left)
        
        
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSourcePrefetching, UITableViewDataSource {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        print(indexPaths)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTime.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath)
        let item = allTime[indexPath.row]
        cell.textLabel?.text = "\(item)"
        
        return cell
    }
    
}

