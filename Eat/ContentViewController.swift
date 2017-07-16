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

    var header = ""
    var subHeader = ""
    var imageFile = ""
    
//index of view controller in pageviewcontroller
    var index = 0
    
    override func viewDidLoad() {
               super.viewDidLoad()
        headerLabel.text = header
        subHeaderLabel.text = subHeader
        imageView.image = UIImage(named: imageFile)

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
