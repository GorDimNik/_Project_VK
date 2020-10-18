//
//  Session.swift
//  1l_GorshkovDmitriy
//
//  Created by Дмитрий Горшков on 13.05.2020.
//  Copyright © 2020 Дмитрий Горшков. All rights reserved.
//

import Foundation

class Session {
    private init() {}
    static let instance = Session()
    
    var token: String = ""
    var userId: Int = 0
    
}
