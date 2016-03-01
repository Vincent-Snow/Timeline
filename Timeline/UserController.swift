//
//  UserController.swift
//  Timeline
//
//  Created by mac-admin on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class UserController {
    
    var currentUser: User! = UserController.mockUsers()[0]
   
    
    static let sharedController = UserController()
    
    static func userForIdentifier(identifier: String, completion: (user: User?) -> Void) {
        completion(user: mockUsers()[0])
    }

    static func fetchAllUsers(completion: (users: [User]) -> Void) {
        completion(users: mockUsers())
    }
    
    static func followUser(user: User, completion: (success: Bool) -> Void) {
        completion(success: true)
    }
    
    static func unfollowUser(user: User, completion: (success: Bool) -> Void) {
        completion(success: true)
    }
    
    static func userFollowsUser(user: User, userCheck: User, completion: (follows: Bool) -> Void) {
        completion(follows: true)
    }
    
    static func followedByUser(user: User, completion: (users: [User]?) -> Void) {
        completion(users: mockUsers())
    }
    
    static func authenticateUser(email: String, password: String, completion: (success: Bool, user: User?) -> Void) {
        completion(success: true, user: mockUsers()[0])
    }
    
    static func createUser(email: String, username: String, password: String, bio: String?, url: String?, completion: (success: Bool, user: User?) -> Void) {
        completion(success: true, user: mockUsers()[0])
    }
    
    static func updateUser(user: User, username: String, bio: String?, url: String?, completion: (success: Bool, user: User?) -> Void) {
        completion(success: true, user: mockUsers()[0])
    }
    
    static func logOutCurrentUser() {
        
    }
    
    static func mockUsers() -> [User] {
            
            let user1 = User(username: "Vincent", identifier: "@snow_van")
            let user2 = User(username: "vinstagram", identifier: "@___vints")
            let user3 = User(username: "cassidy", identifier: "@casshrabik")
            let user4 = User(username: "Vints", bio: "easily offended", url: "twitter.com/snow_van", identifier: "@vints")
            
            return [user1, user2, user3, user4]
        }


}


  