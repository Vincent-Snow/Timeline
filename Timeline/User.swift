//
//  User.swift
//  Timeline
//
//  Created by mac-admin on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

struct User: Equatable {
    let username: String
    let bio: String?
    let url: String?
    let identifier: String?
    
    init(username: String, bio: String? = nil, url: String? = nil, identifier: String?) {
        self.username = username
        self.bio = bio
        self.url = url
        self.identifier = identifier
        
        
        
    }
    
}

func ==(lhs: User, rhs: User) -> Bool {
    return lhs.username == rhs.identifier
}


