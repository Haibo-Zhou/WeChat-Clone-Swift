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
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 16)
        textView.text = "Sample message"
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    func setupViews() {
//        backgroundColor = .myBlue
        addSubview(messageTextView)
        
        let g = contentView
        NSLayoutConstraint.activate([
            messageTextView.leadingAnchor.constraint(equalTo: g.leadingAnchor),
            messageTextView.trailingAnchor.constraint(equalTo: g.trailingAnchor),
            messageTextView.topAnchor.constraint(equalTo: g.topAnchor),
            messageTextView.bottomAnchor.constraint(equalTo: g.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
