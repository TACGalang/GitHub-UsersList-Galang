//
//  ViewController.swift
//  Viyahe Exam
//
//  Created by Tristan Angelo Galang on 3/17/21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavitation()
    }

    // MARK: - Layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.backgroundColor = .white
        
    }
    
    func setNavitation() {
        navigationItem.title = "GITHUB USERS"
    }

}

