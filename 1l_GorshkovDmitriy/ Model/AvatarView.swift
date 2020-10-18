//
//  AvatarView.swift
//  1l_GorshkovDmitriy
//
//  Created by Дмитрий Горшков on 06.04.2020.
//  Copyright © 2020 Дмитрий Горшков. All rights reserved.
//

import UIKit

@IBDesignable final class AvatarView: UIView {
    
    @IBInspectable
    var shadowColor: UIColor?{
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set{
            layer.shadowColor = newValue?.cgColor
        }
    }

    @IBInspectable
    var shadowOpacity: Float = 1 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat = 5  {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    //задем цвет и ширину рамки
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 0
        layer.borderColor = UIColor.black.cgColor
    }
       //делаем View круглой
    override func layoutSubviews() {
        super.layoutSubviews()
        //скругляем края нашей View
        layer.cornerRadius = bounds.height / 2

        //устанавливаем тень
        layer.shadowOffset = CGSize.zero
        
        
    }
}

class FriendAvatarImageView: UIImageView{
    override func layoutSubviews() {
        super.layoutSubviews()
        //скругляем края нашей ImageView - чтобы не выходила за края View
        layer.cornerRadius = bounds.height / 2
    }
    
}
