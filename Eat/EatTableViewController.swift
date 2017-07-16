//
//  EatTableViewController.swift
//  Eat
//
//  Created by Yuliia Stelmakhovska on 2017-06-26.
//  Copyright © 2017 Yuliia Stelmakhovska. All rights reserved.
//

import UIKit
import CoreData

class EatTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    
//    var names=["one", "two","three", "four", "five","six", "six", "nine", "one", "two","three", "four", "five","six", "seven", "nine"]
//
//    var images=["one.jpg", "two.jpg","three.jpg", "four.jpg", "five.jpg","six.jpg", "seven.jpg", "nine.jpg", "one.jpg", "two.jpg","three.jpg", "four.jpg", "five.jpg","six.jpg", "seven.jpg", "nine.jpg"]
//    
//    var itemsVisited = [Bool](repeatElement(false, count: 16))

    //manage the results returned from a Core Data fetch request to provide data for a UITableView object@@
    var fetchResultsController: NSFetchedResultsController <Restaurant>!
    
    
    var searchController: UISearchController!
    var filteredResultArray: [Restaurant] = []
    
    
    
    
    var restaurants : [Restaurant] = [] // [
//        Restaurant(name: "one", type: "restaurant", location: "Ytterby, Runangsgatan 11B", image: "one.jpg", isVisited: false),
//         Restaurant(name: "two", type: "cafe", location: "Lund", image: "two.jpg", isVisited: false),
//          Restaurant(name: "three", type: "club", location: "Malmo", image: "three.jpg", isVisited: false),
//           Restaurant(name: "four", type: "restaurant", location: "Malmo", image: "four.jpg", isVisited: false),
//            Restaurant(name: "five", type: "club", location: "Lund", image: "five.jpg", isVisited: false),
//             Restaurant(name: "six", type: "cafe", location: "Malmo", image: "six.jpg", isVisited: false),
//              Restaurant(name: "seven", type: "restaurant", location: "Lund", image: "seven.jpg", isVisited: false),
//        Restaurant(name: "nine", type: "restaurant", location: "Lund", image: "nine.jpg", isVisited: false),
//        Restaurant(name: "one", type: "restaurant", location: "Malmo", image: "one.jpg", isVisited: false),
//        Restaurant(name: "two", type: "cafe", location: "Lund", image: "two.jpg", isVisited: false),
//        Restaurant(name: "three", type: "club", location: "Malmo", image: "three.jpg", isVisited: false),
//        Restaurant(name: "four", type: "restaurant", location: "Malmo", image: "four.jpg", isVisited: false),
//        Restaurant(name: "five", type: "club", location: "Lund", image: "five.jpg", isVisited: false),
//        Restaurant(name: "six", type: "cafe", location: "Malmo", image: "six.jpg", isVisited: false),
//        Restaurant(name: "seven", type: "restaurant", location: "Lund", image: "seven.jpg", isVisited: false),
//        Restaurant(name: "nine", type: "restaurant", location: "Lund", image: "nine.jpg", isVisited: false)
//        
//    
//    ]
    
    //return from add new eatery screen
    @IBAction func close(segue:UIStoryboardSegue){}
    
    
    override func viewWillAppear(_ animated: Bool) {
        //hides bar on swipe
        navigationController?.hidesBarsOnSwipe = true
           }
  
    func filterContentFor(searchText text:String){
        filteredResultArray = restaurants.filter {(restaurant)-> Bool in
            return (restaurant.name?.lowercased().contains(text.lowercased()))!
        }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //results shows on the main screen searchResultsController: nil
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        //searching view parameters
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.delegate = self
        //to prevent appearence of the searchbar on next screen
        definesPresentationContext = true
        searchController.searchBar.barTintColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        searchController.searchBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        //remove app name from back button @@
        self.navigationItem.backBarButtonItem = UIBarButtonItem (title: "", style: .plain, target: nil, action: nil)
        tableView.estimatedRowHeight = 85
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //request to get data from core data !!!import CoreData
        let fetchRequest: NSFetchRequest <Restaurant> = Restaurant.fetchRequest()
        //data sorted by some descriptor: name true = increasinf
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

         if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
      //initialization of fetchResultsController
            fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
           
            
            // protocol realis.
            fetchResultsController.delegate = self
            
            
            
            do {
                try fetchResultsController.performFetch()
                restaurants = fetchResultsController.fetchedObjects!
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //get info if pages was watched
        let userDefaults = UserDefaults.standard
        let wasIntroWatched = userDefaults.bool(forKey: "wasIntroWatched")
        
        guard !wasIntroWatched else {
            return
        }
        
        
        //loads page view controller
        
        
        if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "pageViewController") as? PageViewController {
            present(pageViewController, animated: true, completion: nil)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    // MARK: - Fetch results controller delegate
    //подготовка tableView к обновлению
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        //в зависимости от действий пользователя меняет таблицу
        switch type {
        case .insert:
            guard let indexPath = newIndexPath else { break }
            tableView.insertRows(at: [indexPath], with: .fade)
        case .delete:
            guard let indexPath = indexPath else { break }
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .update:
            guard let indexPath = indexPath else { break }
            tableView.reloadRows(at: [indexPath], with: .fade)
        default:
            tableView.reloadData()
        }
        //refreshing array with data
        restaurants = controller.fetchedObjects as! [Restaurant]
    }
    //info tableView that uppdates are ready
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive && searchController.searchBar.text != ""{
        return filteredResultArray.count
        }
        return restaurants.count
    }

    func restaurantToDisrplay(indexParh: IndexPath)-> Restaurant{
        let restaurant: Restaurant
        if searchController.isActive && searchController.searchBar.text != "" {
            restaurant = filteredResultArray[indexParh.row]
        } else{
             restaurant = restaurants[indexParh.row]
        }
        return restaurant
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EatTableViewCell //CAST FROM UITableViewCell TO CREATED CUSTOM CLASS EatTableViewCell @@

    let restaurant = restaurantToDisrplay(indexParh: indexPath)
        cell.thumbnailImageView.image = UIImage(data: restaurant.image! as Data)
        cell.thumbnailImageView.layer.cornerRadius = 32.5
        cell.thumbnailImageView.clipsToBounds = true
        cell.nameLabel.text = restaurant.name
        cell.locationLabel.text = restaurant.location
        cell.typeLabel.text = restaurant.type
        // Configure the cell...
// drawing of cell@@
        if restaurant.isVisited{
       cell.accessoryType = .checkmark
        }
        else{
        cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //убирает выдыление пункта после возвращения на основной экран
        tableView.deselectRow(at: indexPath, animated: true)
    }
   
    //ALERT 
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let ac = UIAlertController(title: nil, message: "choose action", preferredStyle: .actionSheet)
//        let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
//        let callAction = UIAlertAction(title: "call +78428...\(indexPath.row)", style: .default){
//            (action: UIAlertAction)->Void in
//            
//            let alertC = UIAlertController(title: nil, message: "can not call", preferredStyle: .alert)
//            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
//            alertC.addAction(ok)
//            self.present(alertC, animated: true, completion: nil)
//        }
//        let isVisitedTitle =  self.itemsVisited[indexPath.row] ? "not visited" : "visited"
//        let isVisited = UIAlertAction(title: isVisitedTitle, style: .default)
//        {(action) in
//let cell = tableView.cellForRow(at: indexPath)
//            self.itemsVisited[indexPath.row] = !self.itemsVisited[indexPath.row]
//            //check and uncheck
//            cell?.accessoryType = self.itemsVisited[indexPath.row] ? .checkmark : .none
//            
//        }
//        ac.addAction(cancel)
//        ac.addAction(isVisited)
//        ac.addAction(callAction)
//        present(ac, animated: true, completion: nil)
//        
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
    
    //delete by swiping
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete{
//        self.names.remove(at: indexPath.row)
//            self.images.remove(at: indexPath.row)
//            self.itemsVisited.remove(at: indexPath.row)
//        }
//        //REFRESH all table
//       // tableView.reloadData()
//        //Deletes only one item
//        tableView.deleteRows(at: [indexPath], with: .fade)
//    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?{
        let share = UITableViewRowAction(style: .default, title: "share") { (action, indexPath) in
            let defaultText =  "Im in " + self.restaurants[indexPath.row].name!
            if let image = UIImage(data: self.restaurants[indexPath.row].image! as Data){
                let activityController = UIActivityViewController(activityItems: [defaultText,image], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
            }
        }
        
            let delete = UITableViewRowAction(style: .default, title: "delete") { (action, indexPath) in

                self.restaurants.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
                let objToDelete = self.fetchResultsController.object(at: indexPath)
                    context.delete(objToDelete)
                    
                    do{
                    try context.save()
                    }
                    catch{
                    print(error.localizedDescription)
                    }
                }
                
            }
        share.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        delete.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1) //color.literal + enter@@
            return [delete,share]
            
        }
    //перед переходом на другцю сцену исполняется этот метод  data passing@@
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue"{ //id of segue to next scene@@
            if let indexPath = tableView.indexPathForSelectedRow {
            let destinationViewController = segue.destination as! DetailViewController // cast to controller where I pass the data@@
            
                destinationViewController.restaurant = restaurantToDisrplay(indexParh: indexPath)
            }
        }
    }
}


//calls function for filter with text from searchbar
extension EatTableViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterContentFor(searchText: searchController.searchBar.text!)
        tableView.reloadData()
    }
    }

extension EatTableViewController: UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if searchBar.text == "" {
        navigationController?.hidesBarsOnSwipe = false
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
       navigationController?.hidesBarsOnSwipe = true
    }

}
