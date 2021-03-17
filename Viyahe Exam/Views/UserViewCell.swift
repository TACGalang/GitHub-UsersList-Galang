//
//  UserViewCell.swift
//  Viyahe Exam
//
//  Created by Tristan Angelo Galang on 3/17/21.
//

import UIKit
import SnapKit
import SDWebImage

class UserViewCell: UITableViewCell {
    
    var viewModel: UserViewModel! {
        didSet {
            name.text = viewModel.displayName
            url.text = viewModel.displayHTMLURL
            thumbnail.sd_setImage(with: viewModel.getAvatarURL)
            container.layer.borderColor = viewModel.borderColor.cgColor
        }
    }
    
    lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.blueIndicator.cgColor
        view.layer.borderWidth = 10.0
        
        return view
    }()

    lazy var thumbnail: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 25.0
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .cellTitle
        label.textAlignment = .left
        label.textColor = .black
        
        return label
    }()
    
    lazy var url: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .cellSubTitle
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 2
        
        return label
    }()
    
    lazy var customAccessoryView: UIImageView = {
        let imageView = UIImageView(image: .chevronRight)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: - Layout
    func setupLayout() {
        
        addSubview(container)
        container.addSubview(thumbnail)
        container.addSubview(customAccessoryView)
        container.addSubview(name)
        container.addSubview(url)
        
        container.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        container.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        container.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        
        thumbnail.heightAnchor.constraint(equalToConstant: 50).isActive = true
        thumbnail.widthAnchor.constraint(equalTo: thumbnail.heightAnchor).isActive = true
        thumbnail.topAnchor.constraint(equalTo: container.topAnchor, constant: 35).isActive = true
        thumbnail.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -35).isActive = true
        thumbnail.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 30).isActive = true
        
        name.topAnchor.constraint(equalTo: thumbnail.topAnchor).isActive = true
        name.leftAnchor.constraint(equalTo: thumbnail.rightAnchor, constant: 10).isActive = true
        name.rightAnchor.constraint(equalTo: customAccessoryView.leftAnchor, constant: -8).isActive = true
        
        url.topAnchor.constraint(equalTo: name.bottomAnchor).isActive = true
        url.leftAnchor.constraint(equalTo: thumbnail.rightAnchor, constant: 10).isActive = true
        url.rightAnchor.constraint(equalTo: customAccessoryView.leftAnchor, constant: -8).isActive = true
        url.bottomAnchor.constraint(lessThanOrEqualTo: container.bottomAnchor, constant: -10).isActive = true
        
        customAccessoryView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        customAccessoryView.widthAnchor.constraint(equalTo: customAccessoryView.heightAnchor).isActive = true
        customAccessoryView.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -35).isActive = true
        customAccessoryView.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
    }
}
