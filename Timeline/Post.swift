//
//  Post.swift
//  Timeline
//
//  Created by mac-admin on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

struct Post: Equatable {
    let imageEndPoint: Int
    let caption: String?
    let username: String
    let comments: [String]
    let likes: [String]
    let identifier: String?
    
    init(imageEndPoint: Int, caption: String?, username: String, comments: [String], likes: [String], identifier: String?) {
        self.imageEndPoint = imageEndPoint
        self.caption = nil
        self.username = username
        self.comments = []
        self.likes = []
        self.identifier = nil
        
        
        
        
    }
}

func ==(lhs: Post, rhs: Post) -> Bool {
    return lhs.username == rhs.identifier
}