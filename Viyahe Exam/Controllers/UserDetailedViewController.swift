//
//  UserDetailedViewController.swift
//  Viyahe Exam
//
//  Created by Tristan Angelo Galang on 3/17/21.
//

import UIKit
import SnapKit

class UserDetailedViewController: UIViewController {
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.alwaysBounceVertical = true
        
        return view
    }()
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    lazy var nameContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 10.0
        
        return view
    }()
    
    lazy var accountTypeContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 10.0
        
        return view
    }()
    
    lazy var blogTypeContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 10.0
        view.isHidden = true
        
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .cellTitle
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var accountTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .cellTitle
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .cellTitle
        label.textAlignment = .left
        label.textColor = .black
        
        return label
    }()
    
    lazy var followersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .cellTitle
        label.textAlignment = .left
        label.textColor = .black
        
        return label
    }()
    
    lazy var blogLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .cellTitle
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        
        return label
    }()
    
    var viewModel:UserViewModel! {
        didSet {
            avatarImageView.sd_setImage(with: viewModel.getAvatarURL)
            followingLabel.text = viewModel.displayFollowing
            followersLabel.text = viewModel.displayFollowers
            nameLabel.text = viewModel.displayName
            accountTypeLabel.text = viewModel.displayAccountType
            navigationItem.title = viewModel.model.name
            
            if let displayBlog = viewModel.displayBlog {
                blogTypeContainer.isHidden = false
                blogLabel.text = displayBlog
            } else {
                blogTypeContainer.isHidden = true
            }
        }
    }

    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentInsetAdjustmentBehavior = .always
        clientCall()
    }
    
    func clientCall() {
        Client.shared.get(userDetail: viewModel.model.login) { [weak self] (userModel, error) in
            guard let self = self else { return }
            
            if let model = userModel {
                self.viewModel = UserViewModel(withModel: model, withIndex: 0)
            } else if let errorModel = error {
                Prompt.shared.prompt(thisErrorModel: ErrorLimitViewModel(withModel: errorModel), withViewController: self)
            }
        }
    }
  
    // MARK: Layout
    // Layout using library Snapkit
    // On my current employer we use this Snapkit to layout faster and more readable that apple provided layout framework.
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(avatarImageView)
        scrollView.addSubview(followingLabel)
        scrollView.addSubview(followersLabel)
        scrollView.addSubview(nameContainer)
        scrollView.addSubview(accountTypeContainer)
        scrollView.addSubview(blogTypeContainer)
        
        nameContainer.addSubview(nameLabel)
        accountTypeContainer.addSubview(accountTypeLabel)
        blogTypeContainer.addSubview(blogLabel)
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        avatarImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(200)
            make.leading.trailing.equalTo(view).offset(15).inset(15)
        }
        
        followingLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatarImageView.snp.bottom).offset(10)
            make.leading.equalTo(avatarImageView)
        }
        
        followersLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(followingLabel)
            make.trailing.equalTo(avatarImageView)
        }
        
        nameContainer.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(avatarImageView)
            make.top.equalTo(followingLabel.snp.bottom).offset(20)
        }
        
        accountTypeContainer.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(avatarImageView)
            make.top.equalTo(nameContainer.snp.bottom).offset(15)
        }
        
        blogTypeContainer.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(avatarImageView)
            make.top.equalTo(accountTypeContainer.snp.bottom).offset(15)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().offset(30).inset(30)
        }
        
        accountTypeLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().offset(30).inset(30)
        }
        
        blogLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().offset(30).inset(30)
        }
    }
}
