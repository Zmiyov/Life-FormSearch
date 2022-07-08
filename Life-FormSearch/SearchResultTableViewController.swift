//
//  SearchResultTableViewController.swift
//  Life-FormSearch
//
//  Created by Vladimir Pisarenko on 05.07.2022.
//

import UIKit

class SearchResultTableViewController: UITableViewController {
    
    
    @IBOutlet var searchBar: UISearchBar!
    
    var items = [SearchItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    func fetchMatchingItems() {
        self.items = []
        self.tableView.reloadData()
        let searchItemController = SearchItemController()
        
        let searchTerm = searchBar.text ?? ""

        if !searchTerm.isEmpty {
            
            let query = ["q" : searchTerm, "page" : "1"]

            Task {
                do {
                    let fetchedItems = try await searchItemController.fetchItemsFromSearch(matching: query)
                    self.items = fetchedItems
                    self.tableView.reloadData()
                } catch {
                    print("Error fetching data \(error)")
                }
            }
        }
    }
    
    @IBSegueAction func showDetails(_ coder: NSCoder, sender: Any?) -> DetailsViewController? {
        guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {
            return nil
        }
        let item = items[indexPath.row]
        
        return DetailsViewController(coder: coder, searchItem: item)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchItemCell", for: indexPath)
        let searchItem = items[indexPath.row]

        var content = cell.defaultContentConfiguration()
        content.text = searchItem.commonName
        content.secondaryText = searchItem.scientificName
        cell.contentConfiguration = content

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */


    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


}

extension SearchResultTableViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        fetchMatchingItems()
        searchBar.resignFirstResponder()
    }
}
