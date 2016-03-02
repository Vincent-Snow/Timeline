//
//  UserSearchTableViewController.swift
//  Timeline
//
//  Created by mac-admin on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class UserSearchTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var usersDataSource: [User] = []
    
    var searchController: UISearchController!
    
    @IBOutlet weak var modeSegmentedControl: UISegmentedControl!
    
    enum ViewMode: Int {
        case Friends
        case All
        
        func users(completion:(users: [User]?) -> Void) {
            switch self {
            case .Friends:
                UserController.followedByUser(UserController.sharedController.currentUser, completion: { (users) -> Void in
                    completion(users: users)
                })
            case .All:
                UserController.fetchAllUsers() { (users) -> Void in
                    completion(users: users)
                }
            }
            
        }
    }
    
    var mode: ViewMode {
        get {
            return ViewMode(rawValue: modeSegmentedControl.selectedSegmentIndex)!
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViewBasedOnMode()
        setUpSearchController()
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    func updateViewBasedOnMode() {
        mode.users { (users) -> Void in
            if let users = users {
                self.usersDataSource = users
            } else {
                self.usersDataSource = []
            }
            
            self.tableView.reloadData()
        }
    }
    
    func setUpSearchController() {
       let resultsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("UserSearchResultsTableViewController")
        
        searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.hidesNavigationBarDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        
        definesPresentationContext = true
    }
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchTerm = searchController.searchBar.text!.lowercaseString
        
        let resultsViewController = searchController.searchResultsController as! UserSearchResultsTableViewController
        
        resultsViewController.userResultsDataSource = usersDataSource.filter({$0.username.lowercaseString.containsString(searchTerm)})
        resultsViewController.tableView.reloadData()
    }
    
    @IBAction func selectedIndexChanged(sender: AnyObject) {
        updateViewBasedOnMode()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return usersDataSource.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath)

        let user = usersDataSource[indexPath.row]
        
        cell.textLabel?.text = user.username

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toProfileView" {
            guard let cell = sender as? UITableViewCell else { return }
            
            if let indexPath = tableView.indexPathForCell(cell) {
                
                let user = usersDataSource[indexPath.row]
                
                let destinationViewController = segue.destinationViewController as? ProfileViewController
                destinationViewController?.user = user
            } else if let indexPath = (searchController.searchResultsController as? UserSearchResultsTableViewController)?.tableView.indexPathForCell(cell) {
                
                let user = (searchController.searchResultsController as! UserSearchResultsTableViewController).userResultsDataSource[indexPath.row]
                
                let destinationViewController = segue.destinationViewController as? ProfileViewController
                destinationViewController?.user = user
            }
        }
        
        
    }
    

}
