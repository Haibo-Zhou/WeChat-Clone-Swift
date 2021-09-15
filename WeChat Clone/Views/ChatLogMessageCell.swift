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
    lazy var messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 18)
        textView.text = "Sample message"
        textView.backgroundColor = .clear
        return textView
    }()
    
    lazy var textBubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = .msgGrayBgColor
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
//        imageView.backgroundColor = .systemRed
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
//        backgroundColor = .brown
        addSubview(textBubbleView)
        addSubview(messageTextView)
        addSubview(profileImageView)
        
        let g = contentView
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 8),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
            profileImageView.topAnchor.constraint(equalTo: g.topAnchor),
//            profileImageView.bottomAnchor.constraint(equalTo: g.bottomAnchor)
            
        ])

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
