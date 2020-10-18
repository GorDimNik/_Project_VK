//
//  User.swift
//  1l_GorshkovDmitriy
//
//  Created by Дмитрий Горшков on 03.04.2020.
//  Copyright © 2020 Дмитрий Горшков. All rights reserved.
//

import UIKit

struct Friend {
    var title: String
    var avatar: UIImage?
    var photos: [UIImage?]
}

struct SectionFriend {
    var sectionName: String
    var frendStruct: [Friend]
}
