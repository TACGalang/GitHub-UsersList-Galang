//
//  ErrorLimitViewModel.swift
//  Viyahe Exam
//
//  Created by Tristan Angelo Galang on 3/17/21.
//

import Foundation

struct ErrorLimitViewModel {
    
    let model: ErrorLimitModel
    
    var hasDocu: Bool {
        return model.documentationURL != nil
    }
    
    /// Return documentation as a URL
    var getDocuURL: URL? {
        guard let url = model.documentationURL else {
            return nil
        }
        
        return URL(string: url)
    }
    
    // MARK: - Initialization
    init(withModel model: ErrorLimitModel) {
        self.model = model
    }
}
