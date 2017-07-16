//
//  ContentViewController.swift
//  Eat
//
//  Created by Yuliia Stelmakhovska on 2017-07-14.
//  Copyright © 2017 Yuliia Stelmakhovska. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var subHeaderLabel: UILabel!
@IBOutlet weak var pageControl: UIPageControl!
        @IBOutlet weak var pageButton: UIButton!
    
    var header = ""
    var subHeader = ""
    var imageFile = ""
    
//index of view controller in pageviewcontroller
    @IBAction func pageButtonPressed(_ sender: UIButton) {
        
        switch index {
        case 0:
            let pageVC = parent as! PageViewController
            pageVC.nextVC(atIndex: index)
        case 1:
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }

    var index = 0
    
    override func viewDidLoad() {
               super.viewDidLoad()
      
        pageButton.layer.cornerRadius = 15
        pageButton.clipsToBounds = true
        pageButton.layer.borderWidth = 2
        pageButton.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        pageButton.layer.borderColor = (#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)).cgColor
        
        
        switch index {
        case 0: pageButton.setTitle("next", for: .normal)
        case 1: pageButton.setTitle("open", for: .normal)
        default:
            break
        }
        headerLabel.text = header
        subHeaderLabel.text = subHeader
        imageView.image = UIImage(named: imageFile)

        pageControl.numberOfPages = 2
        pageControl.currentPage = index
        
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
