//
//  ConversationTableViewCell.swift
//  WeChat Clone
//
//  Created by HaiboZhou on 2021/9/14.
//

import UIKit

class ConversationTableViewCell: UITableViewCell {
    // cell id
    static let cellIdentifier = "conversationCell"
    
    // UI elements
    lazy var imageCover: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var bellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .lightGray
        return imageView
    }()
    
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 1
        // default Compression priority is 750, to put a lower value as 749 let this label truncate
        // if there is a overlapping
        label.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 749), for: .horizontal)
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 749), for: .horizontal)
        label.textColor = .lightGray
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .lightGray
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: ConversationTableViewCell.cellIdentifier)
        
        setupLayout()
    }
    
    func setupLayout() {
        contentView.addSubview(imageCover)
        contentView.addSubview(bellImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(dateLabel)
        
        let g = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            imageCover.centerYAnchor.constraint(equalTo: g.centerYAnchor),
            imageCover.leadingAnchor.constraint(equalTo: g.leadingAnchor),
            imageCover.widthAnchor.constraint(equalToConstant: 54),
            imageCover.heightAnchor.constraint(equalTo: imageCover.widthAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageCover.trailingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: imageCover.topAnchor, constant: 6),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: dateLabel.leadingAnchor),

            subTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subTitleLabel.bottomAnchor.constraint(equalTo: imageCover.bottomAnchor, constant: -6),
            subTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: bellImageView.leadingAnchor),

            dateLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: g.trailingAnchor),

            bellImageView.centerYAnchor.constraint(equalTo: subTitleLabel.centerYAnchor),
            bellImageView.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            bellImageView.widthAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
