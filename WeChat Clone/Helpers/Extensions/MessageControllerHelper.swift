//
//  MessageControllerHelper.swift
//  WeChat Clone
//
//  Created by HaiboZhou on 2021/9/15.
//

import UIKit

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
        DispatchQueue.global().async { [weak self] in
            let image1 = UIImage(named: "geng_profile")
            CoreDataManager.shared.createFriend(name: "庚儿", profileImage: image1) { friend in
                guard let friend = friend else { return }
                CoreDataManager.shared.createMessage(friend: friend, text: "😎", minutesAgo: 20)
            }
            
            let image2 = UIImage(named: "book_store_profile")
            CoreDataManager.shared.createFriend(name: "熊孩子书店 ｜ 热爱生活的小伙伴们", profileImage: image2) { friend in
                guard let friend = friend else { return }
                // the 1st message for bookstore
                CoreDataManager.shared.createMessage(friend: friend, text: "Hey dear.", minutesAgo: 3)
                // the following messages
                CoreDataManager.shared.createMessage(friend: friend, text: "Everyone here is named Denny Crane. These are just the ones within driving distance, of course, since airplane travel is not an option.", minutesAgo: 2)
                CoreDataManager.shared.createMessage(friend: friend, text: "第一天，芹菜汁的口感比较顺滑，而且味道是咸的，不涩嘴。喝完16oz,约500毫升的芹菜汁后，反应比较明显，一天上了四次厕所。", minutesAgo: 1)
            }
            
            let image99 = UIImage(named: "Trump")
            CoreDataManager.shared.createFriend(name: "Donald Trump", profileImage: image99) { friend in
                guard let friend = friend else { return }
                CoreDataManager.shared.createMessage(friend: friend, text: "You're fired!", minutesAgo: 36)
            }
            
            let image3 = UIImage(named: "zan_profile")
            CoreDataManager.shared.createFriend(name: "先先贝", profileImage: image3) { friend in
                guard let friend = friend else { return }
                // 1 day
                CoreDataManager.shared.createMessage(friend: friend, text: "你吃基围虾也太奢侈了", minutesAgo: 24 * 60)
            }
            
            let image4 = UIImage(named: "Taylor-Swift-1")
            CoreDataManager.shared.createFriend(name: "Taylor Swift", profileImage: image4) { friend in
                guard let friend = friend else { return }
                // 8 days
                CoreDataManager.shared.createMessage(friend: friend, text: "How you doing?", minutesAgo: 24 * 60 * 8)
            }
            //
            //            let image5 = UIImage(named: "Taylor-Swift-2")
            //            CoreDataManager.shared.createFriend(name: "Taylor Swift's Fans", profileImage: image5) { friend in
            //                guard let friend = friend else { return }
            //                CoreDataManager.shared.createMessage(friend: friend, text: "People haven't always been there for me but music always has.", date: Date())
            //            }
            //
            //            let image6 = UIImage(named: "Taylor-Swift-3")
            //            CoreDataManager.shared.createFriend(name: "Taylor Swift 1987", profileImage: image6) { friend in
            //                guard let friend = friend else { return }
            //                CoreDataManager.shared.createMessage(friend: friend, text: "When I was a little girl I used to read fairy tales.", date: Date())
            //            }
            //
            //            let image7 = UIImage(named: "Taylor-Swift-4")
            //            CoreDataManager.shared.createFriend(name: "Taylor Swift #Num 8", profileImage: image7) { friend in
            //                guard let friend = friend else { return }
            //                CoreDataManager.shared.createMessage(friend: friend, text: "To me, Fearless is not the absense of fear.", date: Date())
            //            }
            //
            //            let image8 = UIImage(named: "Taylor-Swift-5")
            //            CoreDataManager.shared.createFriend(name: "Best of Taylor Swift", profileImage: image8) { friend in
            //                guard let friend = friend else { return }
            //                CoreDataManager.shared.createMessage(friend: friend, text: "This is a new year. A new beginning. And things will change.", date: Date())
            //            }
            //
            //            let image9 = UIImage(named: "Robert-Downey-JR-1")
            //            CoreDataManager.shared.createFriend(name: "Robert Downey JR", profileImage: image9) { friend in
            //                guard let friend = friend else { return }
            //                CoreDataManager.shared.createMessage(friend: friend, text: "I think that we all do heroic things, but hero is not a noun, it's a verb.", date: Date())
            //            }
            //
            //            let image10 = UIImage(named: "Robert-Downey-JR-2")
            //            CoreDataManager.shared.createFriend(name: "Best of RDJ", profileImage: image10) { friend in
            //                guard let friend = friend else { return }
            //                CoreDataManager.shared.createMessage(friend: friend, text: "The lesson is that you can still make mistakes and be forgiven.", date: Date())
            //            }
            //
            //            let image11 = UIImage(named: "Robert-Downey-JR-3")
            //            CoreDataManager.shared.createFriend(name: "RDJ's fans", profileImage: image11) { friend in
            //                guard let friend = friend else { return }
            //                CoreDataManager.shared.createMessage(friend: friend, text: "I've noticed that worrying is like praying for what you don't want to happen.", date: Date())
            //            }
            //
            //            let image12 = UIImage(named: "Alan-Shore")
            //            CoreDataManager.shared.createFriend(name: "Alan Shore", profileImage: image12) { friend in
            //                guard let friend = friend else { return }
            //                CoreDataManager.shared.createMessage(friend: friend, text: "I demand only one thing in a relationship that I remain utterly alone.", date: Date())
            //            }
            //            let image13 = UIImage(named: "Denny-Crane")
            //            CoreDataManager.shared.createFriend(name: "Denny Crane", profileImage: image13) { friend in
            //                guard let friend = friend else { return }
            //                CoreDataManager.shared.createMessage(friend: friend, text: "Denny Crane, Reasonable Doubt for a reasonable fee.", date: Date())
            //            }
            //
            //            let image14 = UIImage(named: "subscription_account")
            //            CoreDataManager.shared.createFriend(name: "订阅号消息", profileImage: image14) { friend in
            //                guard let friend = friend else { return }
            //                CoreDataManager.shared.createMessage(friend: friend, text: "[11条] 大连本地宝：在大连千万别忘记办这个证！", date: Date())
            //                print("🌈 Data creation complete")
            //            }
            
            // load data after creating it in CoreData
            self?.loadData()
        }
    }
    
    func loadData() {
        CoreDataManager.shared.fetchFriends { [weak self] friends in
            guard let friends = friends else { return }
            
            // init messages array
            self?.messages = [Message]()
            for friend in friends {
                print(friend.name ?? "")
                
                CoreDataManager.shared.fetchMessages(from: friend, completion: { messages in
                    guard let fetchedMessages = messages else { return }
                    self?.messages?.append(contentsOf: fetchedMessages)
                })
            }
            
            self?.messages?.sort {($0.date ?? Date() > $1.date ?? Date())}
            
            print("🌈 start to load \(self?.messages?.count ?? 0) messages")
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.removeSpinner()
            }
        }
    }
}
