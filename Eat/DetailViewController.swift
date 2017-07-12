//
//  DetailViewController.swift
//  Eat
//
//  Created by Yuliia Stelmakhovska on 2017-06-28.
//  Copyright © 2017 Yuliia Stelmakhovska. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    
    var restaurant : Restaurant?
    @IBOutlet weak var mapButton: UIButton!
    
    //calls unwind segue so i can get data here from another viewController
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
    
        //check if viewcontroller is that which sends data
        guard let sourceViewController = segue.source as? RateViewController else{ return }
        // get variable from sender
        guard let rating = sourceViewController.restRating else { return }
        rateButton.setImage(UIImage(named : rating), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //dont hide bar on swipe 
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let buttons = [rateButton, mapButton]
        for button in buttons {
            guard let button = button else {
                break
            }
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        }
        tableView.estimatedRowHeight = 38
        //переносить по словам@@ предварительно изменив в мейн сториборд /чяейка/ атриб инспект/ лайнс 0 количество строк будет меняться автоматом
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        imageView.image = UIImage(data: self.restaurant!.image! as Data)
//        tableView.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
//        tableView.separatorColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        tableView.tableFooterView = UIView (frame: CGRect.zero)// detele empty rows
        title = restaurant!.name
        

        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EatDetailTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.keyLabel.text = "Name"
            cell.valueLabel.text = restaurant!.name
            
        case 1:
            cell.keyLabel.text = "Type"
            cell.valueLabel.text = restaurant!.type
            
        case 2:
            cell.keyLabel.text = "Location"
            cell.valueLabel.text = restaurant!.location
            
        case 3:
            cell.keyLabel.text = "Visited"
            cell.valueLabel.text = restaurant!.isVisited ? "yes" : "no"
        default:
            
            break        }
        cell.backgroundColor = UIColor.clear //transparent
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapSegue"{
        let dvc = segue.destination as! MapViewController
            dvc.restaurant = self.restaurant
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
