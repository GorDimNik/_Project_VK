//
//  FrendsViewCell.swift
//  1l_GorshkovDmitriy
//
//  Created by Дмитрий Горшков on 02.04.2020.
//  Copyright © 2020 Дмитрий Горшков. All rights reserved.
//

import UIKit

class FrendsViewCell: UITableViewCell {
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var friendAvatarImageView: UIImageView!
    @IBOutlet weak var friendAvatarView: UIView!
    
    let scaleOrigional = CGAffineTransform(scaleX: 1, y: 1)
    let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
    
    @objc func animationAvatar(){
        //print("123")
        
        UIView.animateKeyframes(withDuration: 1.0, delay: 0.0, options: [.autoreverse], animations: {
            self.friendAvatarView.transform = self.scale
        }, completion: { isComplite in
            self.friendAvatarView.transform = self.scaleOrigional
        }
        )}

    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(animationAvatar))
        friendAvatarView.addGestureRecognizer(tapGesture)
    }
}





