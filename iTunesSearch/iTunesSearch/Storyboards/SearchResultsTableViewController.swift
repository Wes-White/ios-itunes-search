//
//  SearchResultsTableViewController.swift
//  iTunesSearch
//
//  Created by Wesley Ryan on 4/6/20.
//  Copyright © 2020 Wesley Ryan. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    
    @IBOutlet weak var searchField: UISearchBar!
    @IBOutlet weak var segmentedControll: UISegmentedControl!
    
    
    let searchController = SearchResultsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchField.delegate  = self 
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchController.fromITunesResult.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath)
        
        let singleResult = searchController.fromITunesResult[indexPath.row]
        
        cell.textLabel?.text = singleResult.title
        cell.detailTextLabel?.text = singleResult.creator
     
   
    
        return cell
    }
    
}

extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else {
            return
        }
        var resultType: ResultType!
        
        let type = segmentedControll.selectedSegmentIndex
        switch type {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        case 2:
            resultType = .movie
        default:
            resultType = .software
        }
        
        searchController.performSearch(searchTerm: searchTerm, resultType: resultType) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
