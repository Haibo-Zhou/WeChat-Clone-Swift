//
//  ChatLogController.swift
//  WeChat Clone
//
//  Created by HaiboZhou on 2021/9/15.
//

import UIKit

class ChatLogController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var friend: Friend? {
        didSet {
            navigationItem.title = friend?.name
            messages = friend?.messages?.allObjects as? [Message]
            messages?.sort {($0.date ?? Date() < $1.date ?? Date())}
        }
    }
    
    var messages: [Message]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .myPink
        collectionView.register(ChatLogMessageCell.self, forCellWithReuseIdentifier: ChatLogMessageCell.cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatLogMessageCell.cellId, for: indexPath) as? ChatLogMessageCell else {
            fatalError("Unable to dequeue ChatLogMessageCell")
        }
        // configure the cell
        cell.messageTextView.text = self.messages?[indexPath.item].text

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
}

