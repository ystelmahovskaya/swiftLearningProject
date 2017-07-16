//
//  PageViewController.swift
//  Eat
//
//  Created by Yuliia Stelmakhovska on 2017-07-14.
//  Copyright © 2017 Yuliia Stelmakhovska. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    var headersArray = ["write","find"]
    var subheadersArray = ["create list of favorites", "find and check on the map"]
    var imagesArray = ["food","iphoneMap"]

    override func viewDidLoad() {
        super.viewDidLoad()
self.dataSource = self
        //download first controller
        if let firstVC = displayViewController(atIndex: 0){
        setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayViewController(atIndex index:Int)->ContentViewController? {
        guard index >= 0 else {return nil}
        guard index < headersArray.count else { return nil }
//create view controller and send data
        guard let contentVC = storyboard?.instantiateViewController(withIdentifier: "contentViewController") as? ContentViewController else {return nil}
        
        contentVC.imageFile = imagesArray[index]
        contentVC.header = headersArray[index]
        contentVC.subHeader = subheadersArray[index]
        contentVC.index = index
        
     return contentVC
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

extension PageViewController:UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ContentViewController).index
        index-=1
     return   displayViewController(atIndex: index)
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ContentViewController).index
        index+=1
        return   displayViewController(atIndex: index)

    }
}
