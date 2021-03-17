//
//  UserModel.swift
//  Viyahe Exam
//
//  Created by Tristan Angelo Galang on 3/17/21.
//

import Foundation

struct UserModel: Decodable {
    let login: String
    let id: Int
    let avatarURL: String
    let htmlURL: String
    let type: TypeEnum
    let name: String?
    let following: Int?
    let followers: Int?
    let blog: String?
    
    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
        case type
        case name
        case following
        case followers
        case blog
    }
}
