//
//  Conversation.swift
//  WeChat Clone
//
//  Created by HaiboZhou on 2021/9/14.
//

import UIKit
import CoreData

// MARK: - Test Models before creating CoreDate entities
/*
class Friend: Codable {
    var name: String?
    var profileImageName: String?
}

class Message: Codable {
    var text: String?
    var date: Date?

    var friend: Friend?
}
*/


// MARK: - create mocking messages in CoreData

extension MessageViewController {
    
    func clearData() {
        CoreDataManager.shared.removeAllFromEntity(entityName: "Message")
        CoreDataManager.shared.removeAllFromEntity(entityName: "Friend")
    }
    
    func setupData() {
        
//        if let image = UIImage(named: "geng_profile") {
//            let ratio = image.size.width / image.size.height
//            image.draw(in: CGRect(x: 0, y: 0, width: self.view.frame.size.width * 0.4, height: self.view.frame.size.width * 0.4 / ratio))
//        }
//
        
        print("🌈  clear data in DB 🍎")
        clearData()
        
        print("🌈 🍎 Start to create mocking data in DB")
        self.showSpinner()
        DispatchQueue.global().async {
            let image1 = UIImage(named: "geng_profile")
            CoreDataManager.shared.createFriend(name: "庚儿", profileImage: image1) { friend in
                guard let friend = friend else { return }
                CoreDataManager.shared.createMessage(friend: friend, text: "您吃了么？", date: Date())
            }
            
            let image2 = UIImage(named: "book_store_profile")
            CoreDataManager.shared.createFriend(name: "熊孩子书店 ｜ 热爱生活的小伙伴们", profileImage: image2) { friend in
                guard let friend = friend else { return }
                CoreDataManager.shared.createMessage(friend: friend, text: "杜丘: 健谈但却不是话唠那种？", date: Date())
            }
            
            let image3 = UIImage(named: "zan_profile")
            CoreDataManager.shared.createFriend(name: "先先贝", profileImage: image3) { friend in
                guard let friend = friend else { return }
                CoreDataManager.shared.createMessage(friend: friend, text: "你吃基围虾也太奢侈了", date: Date())
            }
//
//            CoreDataManager.shared.createFriend(name: "Taylor Swift", profileImageName: "Taylor-Swift-1") { friend in
//                guard let friend = friend else { return }
//                CoreDataManager.shared.createMessage(friend: friend, text: "How you doing?", date: Date())
//            }
//
//            CoreDataManager.shared.createFriend(name: "Taylor Swift's Fans", profileImageName: "Taylor-Swift-2") { friend in
//                guard let friend = friend else { return }
//                CoreDataManager.shared.createMessage(friend: friend, text: "People haven't always been there for me but music always has.", date: Date())
//            }
//
//            CoreDataManager.shared.createFriend(name: "Taylor Swift 1987", profileImageName: "Taylor-Swift-3") { friend in
//                guard let friend = friend else { return }
//                CoreDataManager.shared.createMessage(friend: friend, text: "When I was a little girl I used to read fairy tales.", date: Date())
//            }
//
//            CoreDataManager.shared.createFriend(name: "Taylor Swift #Num 8", profileImageName: "Taylor-Swift-4") { friend in
//                guard let friend = friend else { return }
//                CoreDataManager.shared.createMessage(friend: friend, text: "To me, Fearless is not the absense of fear.", date: Date())
//            }
//
//            CoreDataManager.shared.createFriend(name: "Best of Taylor Swift", profileImageName: "Taylor-Swift-5") { friend in
//                guard let friend = friend else { return }
//                CoreDataManager.shared.createMessage(friend: friend, text: "This is a new year. A new beginning. And things will change.", date: Date())
//            }
//
//            CoreDataManager.shared.createFriend(name: "Robert Downey JR", profileImageName: "Robert-Downey-JR-1") { friend in
//                guard let friend = friend else { return }
//                CoreDataManager.shared.createMessage(friend: friend, text: "I think that we all do heroic things, but hero is not a noun, it's a verb.", date: Date())
//            }
//
//            CoreDataManager.shared.createFriend(name: "Best of RDJ", profileImageName: "Robert-Downey-JR-2") { friend in
//                guard let friend = friend else { return }
//                CoreDataManager.shared.createMessage(friend: friend, text: "The lesson is that you can still make mistakes and be forgiven.", date: Date())
//            }
//
//            CoreDataManager.shared.createFriend(name: "RDJ's fans", profileImageName: "Robert-Downey-JR-3") { friend in
//                guard let friend = friend else { return }
//                CoreDataManager.shared.createMessage(friend: friend, text: "I've noticed that worrying is like praying for what you don't want to happen.", date: Date())
//            }
//
//            CoreDataManager.shared.createFriend(name: "Alan Shore", profileImageName: "Alan-Shore") { friend in
//                guard let friend = friend else { return }
//                CoreDataManager.shared.createMessage(friend: friend, text: "I demand only one thing in a relationship that I remain utterly alone.", date: Date())
//            }
//
//            CoreDataManager.shared.createFriend(name: "Denny Crane", profileImageName: "Denny-Crane") { friend in
//                guard let friend = friend else { return }
//                CoreDataManager.shared.createMessage(friend: friend, text: "Denny Crane, Reasonable Doubt for a reasonable fee.", date: Date())
//            }
//
//            CoreDataManager.shared.createFriend(name: "订阅号消息", profileImageName: "subscription_account") { friend in
//                guard let friend = friend else { return }
//                CoreDataManager.shared.createMessage(friend: friend, text: "[11条] 大连本地宝：在大连千万别忘记办这个证！", date: Date())
//                print("🌈 Data creation complete")
//            }
            
            // load data after creating it in CoreData
            loadData()
        }
        
        
        func loadData() {
            CoreDataManager.shared.fetchMessages(completion: { [weak self] messages in
                guard let messages = messages else { return }
                self?.messages = messages
                print("🌈 prepare to load \(self?.messages?.count ?? 0) messages")
                
                DispatchQueue.main.async {
//                    print("refresh tableView")
//                    CoreDataManager.shared.printThreadStats()
                    self?.tableView.reloadData()
                    self?.removeSpinner()
                }
            })
        }
    }
}

