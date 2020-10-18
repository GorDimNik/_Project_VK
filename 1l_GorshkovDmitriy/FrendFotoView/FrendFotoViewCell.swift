//
//  FrendFotoViewCell.swift
//  1l_GorshkovDmitriy
//
//  Created by Дмитрий Горшков on 02.04.2020.
//  Copyright © 2020 Дмитрий Горшков. All rights reserved.
//

import UIKit

class FrendFotoViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var lableLike: UILabel!
    @IBOutlet weak var buttonLike: UIButton!
    @IBOutlet weak var ViewLike: LikeView!
    
    let scaleOrigional = CGAffineTransform(scaleX: 1, y: 1)
    let scale = CGAffineTransform(scaleX: 0.4, y: 0.4)
    
    
    @IBAction func actionLikeButton(_ sender: Any) {
       

        
        
        if !buttonLike.isSelected {             //если кновка не выбрана
            buttonLike.isSelected = true        //выделяем кнопку
            let t:Int? = Int(lableLike.text!)   //получаем количество лайков (сколько было)
            lableLike.text = String(t! + 1)     //+1 к лайкам
            
            //анимация нажатия на кнопку лайк
            UIView.animate(withDuration: 0.5, animations: {
                self.buttonLike.transform = self.scale
            }, completion: { isComplite in
                UIView.animate(withDuration: 1.0 , animations: {
                    self.buttonLike.transform = self.scaleOrigional
                })
            })
        }else{
            buttonLike.isSelected = false
            let t:Int? = Int(lableLike.text!)
            lableLike.text = String(t! - 1)
        }
        
        
//        UIView.animate(withDuration: 1.0, animations: {
//            self.lableLike.transform = self.scale
//        }, completion: { isComplite in
//            self.lableLike.transform = self.scaleOrigional
//        })
        
        
        
        
        
        
        
        
        
        
//        UIView.animateKeyframes(withDuration: 1.0, delay: 0.0, options: [.autoreverse], animations: {
//            self.lableLike.transform = self.scale
//        }, completion: { isComplite in
//            self.lableLike.transform = self.scaleOrigional
//        })
        
    }    
    
}
