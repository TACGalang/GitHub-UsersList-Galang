//
//  UserViewModel.swift
//  Viyahe Exam
//
//  Created by Tristan Angelo Galang on 3/17/21.
//

import Foundation

struct UserViewModel {
    let login: String
    let htmlURL: String
    let avatarURL: String
    
    /// Return URL of avatar
    var getAvatarURL: URL? {
        return URL(string: avatarURL)
    }
    
    // MARK: - Initialization
    init(withModel model:UserModel) {
        self.login = model.login
        self.htmlURL = model.htmlURL
        self.avatarURL = model.avatarURL
    }
}
