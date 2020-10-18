//
//  AnimationScreenViewController.swift
//  1l_GorshkovDmitriy
//
//  Created by Дмитрий Горшков on 22.04.2020.
//  Copyright © 2020 Дмитрий Горшков. All rights reserved.
//

import UIKit

class AnimationScreenViewController: UIViewController {

    @IBOutlet weak var point1: UIView!
    @IBOutlet weak var point2: UIView!
    @IBOutlet weak var point3: UIView!
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
    
    
//    [ваше изображение].layer.cornerRadius = [ваше изображение].frame.size.width / 2
//    [ваше изображение].clipsToBounds = true
    
    override func viewDidAppear(_ animated: Bool) {
        //self.performSegue(withIdentifier: "ViewController", sender: self)
        loadingAnimation()
    }
    
    func loadingAnimation(){
        point1.layer.cornerRadius = point1.frame.size.width / 2
        point2.layer.cornerRadius = point2.frame.size.width / 2
        point3.layer.cornerRadius = point3.frame.size.width / 2
        
        point1.alpha = 0
        point2.alpha = 0
        point3.alpha = 0
        
        UIView.animateKeyframes(withDuration: 4, delay: 0, options: .calculationModeCubic,
                                animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.11, animations: {
                self.point1.alpha = 1
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.11, relativeDuration: 0.11, animations: {
                self.point2.alpha = 1
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.22, relativeDuration: 0.11, animations: {
                self.point3.alpha = 1
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.33, relativeDuration: 0.11, animations: {
                self.point1.alpha = 0
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.44, relativeDuration: 0.11, animations: {
                self.point2.alpha = 0
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.55, relativeDuration: 0.11, animations: {
                self.point3.alpha = 0
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.66, relativeDuration: 0.11, animations: {
                self.point1.alpha = 1
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.77, relativeDuration: 0.11, animations: {
                self.point2.alpha = 1
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.88, relativeDuration: 0.11, animations: {
                self.point3.alpha = 1
            })
            
        },
                                
                                completion: { isComplite in
                                    self.performSegue(withIdentifier: "goVC", sender: nil)
                                    
                                    
        })
        
        
//        UIView.animate(withDuration: 6,
//                       animations: {
//                        self.point1.alpha = 0
//                        self.point1.superview?.layoutIfNeeded()
//        },
//                       completion: { isComplite in
//                        self.performSegue(withIdentifier: "goVC", sender: nil)
//
//
//        })
        
        
//            UIView.animate(withDuration: 0.5, animations: {
//                self.point1.alpha = 0
//                self.point1.superview?.layoutIfNeeded()
//            }
//        }, completion:{ finished in
            //self.performSegue(withIdentifier: "ViewController", sender: self)
//   })
        
        
   }
}
