//
//  RateViewController.swift
//  Eat
//
//  Created by Yuliia Stelmakhovska on 2017-06-30.
//  Copyright © 2017 Yuliia Stelmakhovska. All rights reserved.
//

import UIKit

class RateViewController: UIViewController {
    
    @IBOutlet weak var ratingStackView: UIStackView!
    
    @IBOutlet weak var badButton: UIButton!
    @IBOutlet weak var goodButton: UIButton!
    @IBOutlet weak var brilliantButton: UIButton!
    var restRating: String?
    @IBAction func rateRestaurant(sender: UIButton){
        switch sender.tag {
        case 0 : restRating = "bad"
            case 1 : restRating = "good"
            case 2 : restRating = "brilliant"
        default: break
        }
        // принудительный переход
        performSegue(withIdentifier: "unwindSegueToDVC", sender: sender)
    }
    

    //animation@@
    override func viewDidAppear(_ animated: Bool) {
        //    //animation@@
//        UIView.animate(withDuration: 0.4) { 
//            self.ratingStackView.transform = CGAffineTransform(scaleX: 1, y: 1)
//        }
        
        let buttonArray = [badButton, goodButton, brilliantButton]
        
        //унопки появляются в зависимости от индекса в массиве
        //в кортеже перебираются и кнопки и индекс
        //
        for(index, button) in buttonArray.enumerated(){
            let delay = Double(index) * 0.2
        UIView.animate(withDuration: 0.6, delay: delay, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            button?.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //animation@@ CGAffineTransform
        badButton.transform = CGAffineTransform(scaleX: 0, y: 0)
        goodButton.transform = CGAffineTransform(scaleX: 0, y: 0)
        brilliantButton.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        let blurEffect = UIBlurEffect(style: .light)
        //созд навый фрейм с размерами картинки  который помкщается поверх картинки
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        //при перефоротк телефона будут менятся размеры
        blurEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        //размещаем эффект вью поверх фона
        self.view.insertSubview(blurEffectView, at: 1)
        
        
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
