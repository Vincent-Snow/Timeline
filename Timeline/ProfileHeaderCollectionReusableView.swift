//
//  ProfileHeaderCollectionReusableView.swift
//  Timeline
//
//  Created by mac-admin on 3/1/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

protocol ProfileHeaderCollectionReusableViewDelegate {
    func userTappedFollowButton()
    func userTappedURLButton()
}

class ProfileHeaderCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var urlButton: UIButton!
    @IBOutlet weak var followButton: UIButton!
    
    var delegate: ProfileHeaderCollectionReusableViewDelegate?
    
    func updateWithUser(user: User) {
        if let bio = user.bio {
            bioLabel.text = bio
        } else {
            bioLabel.hidden = true
        }
        
        if let url = user.url {
            urlButton.setTitle(url , forState: .Normal)
        } else {
            urlButton.hidden = true
        }
        
        if user == UserController.sharedController.currentUser {
            followButton.setTitle("Logout", forState: .Normal)
        } else {
            UserController.userFollowsUser(UserController.sharedController.currentUser, userCheck: user, completion: { (follows) -> Void in
                if follows {
                    self.followButton.setTitle("Unfollow", forState: .Normal)
                } else {
                    self.followButton.setTitle("Follow", forState: .Normal)
                }
            })
        }
        
    }
    
    @IBAction func urlButtonTapped(sender: AnyObject) {
        delegate?.userTappedURLButton()
    }
    
    @IBAction func followButtonTapped(sender: AnyObject) {
        delegate?.userTappedFollowButton()
    }
    
    
        
}
