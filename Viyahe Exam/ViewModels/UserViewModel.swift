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
    var displayName: String {
        return "@\(model.login)"
    }
    
    /// Return login name with @ prefix as stated in wireframe
    var displayHTMLURL: String {
        return "@\(model.htmlURL)"
    }
    
    var borderColor: UIColor {
        return index.isMultiple(of: 2) ? .greenIndicator : .blueIndicator
    }
    
    // MARK: - Initialization
    init(withModel model:UserModel, withIndex index:Int) {
        self.model = model
        self.index = index
    }
}
