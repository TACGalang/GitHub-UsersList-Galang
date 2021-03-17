//
//  UserViewModel.swift
//  Viyahe Exam
//
//  Created by Tristan Angelo Galang on 3/17/21.
//

import UIKit

struct UserViewModel {
    let model: UserModel
    let index: Int
    
    /// Return URL of avatar
    var getAvatarURL: URL? {
        return URL(string: model.avatarURL)
    }
    
    /// Return login name with @ prefix as stated in wireframe
    var displayLoginName: String {
        return "@\(model.login)"
    }
    
    /// Return login name with @ prefix as stated in wireframe
    var displayHTMLURL: String {
        return "@\(model.htmlURL)"
    }
    
    /// Return border color according to even number
    var borderColor: UIColor {
        return index.isMultiple(of: 2) ? .greenIndicator : .blueIndicator
    }
    
    /// Return display string of following
    var displayFollowing: String {
        return "Following: \(model.following ?? 0)"
    }
    
    /// Return display string of followers
    var displayFollowers: String {
        return "Followers: \(model.followers ?? 0)"
    }
    
    /// Return display string of full name
    var displayName: String {
        return "NAME: \n\n\(model.name ?? "")"
    }
    
    /// Return display string of account type
    var displayAccountType: String {
        return "Account Type: \n\n\(model.type.rawValue)"
    }
    
    /// Return optional string of display blog
    var displayBlog: String? {
        guard let blog = model.blog else {
            return nil
        }
        
        return "Blog: \n\n\(blog)"
    }
    
    // MARK: - Initialization
    init(withModel model:UserModel, withIndex index:Int) {
        self.model = model
        self.index = index
    }
}
