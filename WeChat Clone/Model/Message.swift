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
    
    func setupData() {
        print("🌈 🍎 Start to create mocking messages in CoreData")
        self.showSpinner()
        DispatchQueue.global().async { [weak self] in
            CoreDataManager.shared.createFriend(name: "庚儿", profileImageName: "geng_profile") { friend in
                guard let friend = friend else { return }
                CoreDataManager.shared.createMessage(friend: friend, text: "您吃了么？", date: Date())
            }
            
            CoreDataManager.shared.createFriend(name: "熊孩子书店 ｜ 热爱生活的小伙伴们", profileImageName: "book_store_profile") { friend in
                guard let friend = friend else { return }
                CoreDataManager.shared.createMessage(friend: friend, text: "杜丘: 健谈但却不是话唠那种？", date: Date())
            }
            
            CoreDataManager.shared.createFriend(name: "先先贝", profileImageName: "zan_profile") { friend in
                guard let friend = friend else { return }
                CoreDataManager.shared.createMessage(friend: friend, text: "你吃基围虾也太奢侈了", date: Date())
            }
            
            // abc
            
            CoreDataManager.shared.createFriend(name: "先先贝", profileImageName: "zan_profile") { friend in
                guard let friend = friend else { return }
                CoreDataManager.shared.createMessage(friend: friend, text: "你吃基围虾也太奢侈了", date: Date())
            }
            
            CoreDataManager.shared.createFriend(name: "先先贝", profileImageName: "zan_profile") { friend in
                guard let friend = friend else { return }
                CoreDataManager.shared.createMessage(friend: friend, text: "你吃基围虾也太奢侈了", date: Date())
            }
            
            CoreDataManager.shared.createFriend(name: "先先贝", profileImageName: "zan_profile") { friend in
                guard let friend = friend else { return }
                CoreDataManager.shared.createMessage(friend: friend, text: "你吃基围虾也太奢侈了", date: Date())
            }
            
            CoreDataManager.shared.createFriend(name: "先先贝", profileImageName: "zan_profile") { friend in
                guard let friend = friend else { return }
                CoreDataManager.shared.createMessage(friend: friend, text: "你吃基围虾也太奢侈了", date: Date())
            }
            
            CoreDataManager.shared.createFriend(name: "先先贝", profileImageName: "zan_profile") { friend in
                guard let friend = friend else { return }
                CoreDataManager.shared.createMessage(friend: friend, text: "你吃基围虾也太奢侈了", date: Date())
            }
            
            CoreDataManager.shared.createFriend(name: "先先贝", profileImageName: "zan_profile") { friend in
                guard let friend = friend else { return }
                CoreDataManager.shared.createMessage(friend: friend, text: "你吃基围虾也太奢侈了", date: Date())
            }
            
            CoreDataManager.shared.createFriend(name: "先先贝", profileImageName: "zan_profile") { friend in
                guard let friend = friend else { return }
                CoreDataManager.shared.createMessage(friend: friend, text: "你吃基围虾也太奢侈了", date: Date())
            }
            
            CoreDataManager.shared.createFriend(name: "先先贝", profileImageName: "zan_profile") { friend in
                guard let friend = friend else { return }
                CoreDataManager.shared.createMessage(friend: friend, text: "你吃基围虾也太奢侈了", date: Date())
            }
            
            CoreDataManager.shared.createFriend(name: "先先贝", profileImageName: "zan_profile") { friend in
                guard let friend = friend else { return }
                CoreDataManager.shared.createMessage(friend: friend, text: "你吃基围虾也太奢侈了", date: Date())
            }
            
            CoreDataManager.shared.createFriend(name: "先先贝", profileImageName: "zan_profile") { friend in
                guard let friend = friend else { return }
                CoreDataManager.shared.createMessage(friend: friend, text: "你吃基围虾也太奢侈了", date: Date())
            }
            
            CoreDataManager.shared.createFriend(name: "先先贝", profileImageName: "zan_profile") { friend in
                guard let friend = friend else { return }
                CoreDataManager.shared.createMessage(friend: friend, text: "你吃基围虾也太奢侈了", date: Date())
            }
            
            CoreDataManager.shared.createFriend(name: "先先贝", profileImageName: "zan_profile") { friend in
                guard let friend = friend else { return }
                CoreDataManager.shared.createMessage(friend: friend, text: "你吃基围虾也太奢侈了", date: Date())
            }
            
            CoreDataManager.shared.createFriend(name: "先先贝", profileImageName: "zan_profile") { friend in
                guard let friend = friend else { return }
                CoreDataManager.shared.createMessage(friend: friend, text: "你吃基围虾也太奢侈了", date: Date())
            }
            
            CoreDataManager.shared.createFriend(name: "先先贝", profileImageName: "zan_profile") { friend in
                guard let friend = friend else { return }
                CoreDataManager.shared.createMessage(friend: friend, text: "你吃基围虾也太奢侈了", date: Date())
            }
            
            CoreDataManager.shared.createFriend(name: "先先贝", profileImageName: "zan_profile") { friend in
                guard let friend = friend else { return }
                CoreDataManager.shared.createMessage(friend: friend, text: "你吃基围虾也太奢侈了", date: Date())
            }
            
            CoreDataManager.shared.createFriend(name: "先先贝", profileImageName: "zan_profile") { friend in
                guard let friend = friend else { return }
                CoreDataManager.shared.createMessage(friend: friend, text: "你吃基围虾也太奢侈了", date: Date())
            }
            
            CoreDataManager.shared.createFriend(name: "先先贝", profileImageName: "zan_profile") { friend in
                guard let friend = friend else { return }
                CoreDataManager.shared.createMessage(friend: friend, text: "你吃基围虾也太奢侈了", date: Date())
            }
            
            CoreDataManager.shared.fetchMessages(completion: { messages in
                guard let messages = messages else { return }
                self?.messages = messages
                
                DispatchQueue.main.async {
                    print("refresh tableView")
                    CoreDataManager.shared.printThreadStats()
                    self?.tableView.reloadData()
                    self?.removeSpinner()
                }
            })
        }
    }
}

