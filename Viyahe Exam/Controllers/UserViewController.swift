//
//  UserViewController.swift
//  Viyahe Exam
//
//  Created by Tristan Angelo Galang on 3/17/21.
//

import UIKit

class UserViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(UserViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    var userViewModels: [UserViewModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavitation()
        clientCall()
    }
    
    func clientCall() {
        Client.shared.get { [weak self] (userModels) in
            if let models = userModels {
                self?.userViewModels = models.enumerated().map({ (index, model) -> UserViewModel in
                    return UserViewModel(withModel: model, withIndex: index)
                })
            }
        }
    }

    // MARK: - Layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    
    func setNavitation() {
        navigationItem.title = "GITHUB USERS"
    }
}

// MARK: - Data Source
extension UserViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UserViewCell
        cell.viewModel = userViewModels[indexPath.row]
        
        return cell
    }
}

// MAKR: - Delegate
extension UserViewController: UITableViewDelegate {
    
}
