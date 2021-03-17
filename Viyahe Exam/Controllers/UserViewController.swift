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
        tableView.tableFooterView = footerLoader
        
        return tableView
    }()
    
    lazy var footerLoader: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .gray)
        view.color = .darkGray
        view.hidesWhenStopped = true
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        
        return view
    }()
    
    var viewModels: [UserViewModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var lastLoginIndex: Int = 0
    var hasNext: Bool = true
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavitation()
        clientCall()
    }
    
    func clientCall() {
        Client.shared.get(userSinceID: lastLoginIndex) { [weak self] (userModels, error)  in
            guard let self = self else { return }
            
            if let models = userModels {
                let newViewModels = models.enumerated().map({ (index, model) -> UserViewModel in
                    let finalIndex = index + 1
                    return UserViewModel(withModel: model, withIndex: finalIndex)
                })
                
                self.viewModels.append(contentsOf: newViewModels)
            } else if let errorModel = error {
                self.prompt(thisErrorModel: ErrorLimitViewModel(withModel: errorModel))
                self.hasNext = false
            }
            
            self.footerLoader.stopAnimating()
        }
    }
    
    // MARK: - Actions
    func prompt(thisErrorModel errorModel:ErrorLimitViewModel) {
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
        
        present(alertController, animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
                
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height - scrollView.frame.height

        if offsetY > contentHeight &&
            !footerLoader.isAnimating &&
            hasNext, let lastModel = viewModels.last {
            
            lastLoginIndex = lastModel.model.id
            footerLoader.startAnimating()
            clientCall()
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
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UserViewCell
        cell.viewModel = viewModels[indexPath.row]
        
        return cell
    }
}

// MAKR: - Delegate
extension UserViewController: UITableViewDelegate {
    
}

