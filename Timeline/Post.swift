//
//  Post.swift
//  Timeline
//
//  Created by mac-admin on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

struct Post: Equatable {
    let imageEndPoint: String
    let caption: String?
    let username: String
    let comments: [String]?
    let likes: [String]?
    let identifier: String?
    
    init(imageEndPoint: String, caption: String? = nil, username: String, comments: [Comment]? = nil, likes: [Like]? = nil, identifier: String? = nil) {
        self.imageEndPoint = imageEndPoint
        self.caption = caption
        self.username = username
        self.comments = []
        self.likes = []
        self.identifier = identifier
        
        
        
        
    }
}

func ==(lhs: Post, rhs: Post) -> Bool {
    return lhs.username == rhs.identifier
}