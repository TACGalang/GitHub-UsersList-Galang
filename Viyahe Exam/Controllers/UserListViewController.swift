//
//  UserListViewController.swift
//  Viyahe Exam
//
//  Created by Tristan Angelo Galang on 3/17/21.
//

import UIKit

class UserListViewController: UIViewController {
    
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
    
    var viewModels: [UserViewModel] = [] {
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
        Client.shared.get { [weak self] (userModels, error)  in
            guard let self = self else { return }
            
            if let models = userModels {
                self.viewModels = models.enumerated().map({ (index, model) -> UserViewModel in
                    let finalIndex = index + 1
                    return UserViewModel(withModel: model, withIndex: finalIndex)
                })
            } else if let errorModel = error {
                Prompt.shared.prompt(thisErrorModel: ErrorLimitViewModel(withModel: errorModel), withViewController: self)
            }
        }
    }
    
    // MARK: - Actions
    

    // MARK: - Layout
    // Layout using NSLayout Visual Format
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        let views = [
            "tableView": tableView
        ]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView]|", options: [], metrics: nil, views: views))
    }
    
    func setNavitation() {
        navigationItem.title = "GITHUB USERS"
    }
}

// MARK: - Data Source
extension UserListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UserViewCell
        cell.viewModel = viewModels[indexPath.row]
        
        return cell
    }
}

// MAKR: - Delegate
extension UserListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            if let cell = tableView.cellForRow(at: indexPath) as? UserViewCell {
                cell.setSelected(false, animated: true)
            }
        }
        
        let userDetailedVC = UserDetailedViewController()
        userDetailedVC.viewModel = viewModels[indexPath.row]
        navigationController?.pushViewController(userDetailedVC, animated: true)
        
    }
}

