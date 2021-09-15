//
//  ChatLogMessageCell.swift
//  WeChat Clone
//
//  Created by HaiboZhou on 2021/9/15.
//

import UIKit

class ChatLogMessageCell: UICollectionViewCell {
    
    static let cellId = "ChatLogCellId"
    
    // MARK: UI elements
    lazy var messageImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
//        imageView.backgroundColor = .blue
        return imageView
    }()
    
    lazy var messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 18)
        textView.text = "Sample message"
        textView.backgroundColor = .clear
        return textView
    }()
    
    lazy var textBubbleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "my_picture")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    // MARK: - setupViews
    func setupViews() {
//        backgroundColor = .brown
        addSubview(textBubbleView)
        addSubview(messageTextView)
        addSubview(profileImageView)
        addSubview(myImageView)
        addSubview(messageImageView)
        
        let g = contentView
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 8),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
            profileImageView.topAnchor.constraint(equalTo: g.topAnchor),
            
            myImageView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -8),
            myImageView.widthAnchor.constraint(equalToConstant: 40),
            myImageView.heightAnchor.constraint(equalTo: myImageView.widthAnchor),
            myImageView.topAnchor.constraint(equalTo: g.topAnchor),
            
            messageImageView.topAnchor.constraint(equalTo: myImageView.topAnchor),
            messageImageView.trailingAnchor.constraint(equalTo: myImageView.leadingAnchor, constant: -16),
            messageImageView.widthAnchor.constraint(equalTo: g.widthAnchor, multiplier: 0.5),
            messageImageView.heightAnchor.constraint(equalTo: messageImageView.widthAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
