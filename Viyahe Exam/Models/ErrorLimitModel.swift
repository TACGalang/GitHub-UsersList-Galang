//
//  ErrorLimitModel.swift
//  Viyahe Exam
//
//  Created by Tristan Angelo Galang on 3/17/21.
//

import Foundation

struct ErrorLimitModel: Decodable {
    let message: String
    let documentationURL: String?
    
    enum CodingKeys: String, CodingKey {
        case message
        case documentationURL = "Documentation_url"
    }
}

