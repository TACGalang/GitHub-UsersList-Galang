//
//  ErrorPrompts.swift
//  Viyahe Exam
//
//  Created by Tristan Angelo Galang on 3/18/21.
//

import UIKit

class Prompt {
    
    /// Singleton for Client
    static let shared = Prompt()
    
    private init() {}
    
    func prompt(thisErrorModel errorModel:ErrorLimitViewModel, withViewController vc:UIViewController) {
        let alertController = UIAlertController(title: nil, message: errorModel.model.message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        let docuAction = UIAlertAction(title: "Documentation", style: .default) { _ in
            if let url = errorModel.getDocuURL {
                UIApplication.shared.open(url)
            }
        }
        
        alertController.addAction(okayAction)
        
        if errorModel.hasDocu {
            alertController.addAction(docuAction)
        }
        
        vc.present(alertController, animated: true, completion: nil)
    }
}
