//
//  CoreDataManager.swift
//  WeChat Clone
//
//  Created by HaiboZhou on 2021/9/14.
//

import UIKit
import CoreData

class CoreDataManager {
    let managedObjectContext: NSManagedObjectContext
    private let privateMOC = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    let coreDataStack = CoreDataStack()
    
    static let shared = CoreDataManager()
    
    private init() {
        self.managedObjectContext = coreDataStack.persistentContainer.viewContext
        privateMOC.parent = self.managedObjectContext
    }
    
    func fetchMessages(from friend: Friend, completion: @escaping ([Message]?) -> Void) {
        privateMOC.performAndWait {
            let fetchRequest: NSFetchRequest<Message> = Message.fetchRequest()
            // to sort each message per their sent time
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
            // fetch messages belong the each friend
            fetchRequest.predicate = NSPredicate(format: "friend.name = %@", friend.name ?? "")
            // fetch the latest message from this friend
            fetchRequest.fetchLimit = 1
            do {
                let messages: [Message] = try privateMOC.fetch(fetchRequest)
                completion(messages)
            } catch {
                print("fetch friends failed, \(error), \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    func fetchFriends(completion: @escaping ([Friend]?) -> Void) {
        privateMOC.performAndWait {
            let fetchRequest: NSFetchRequest<Friend> = Friend.fetchRequest()
            do {
                let friends: [Friend] = try privateMOC.fetch(fetchRequest)
                completion(friends)
            } catch {
                print("fetch friends failed, \(error), \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    // not used yet
    func createFriend(name: String, profileImage: UIImage?, completion: @escaping (Friend?) -> Void) {
        privateMOC.performAndWait {
//            print("create friend")
//            printThreadStats()
            let newFriend = Friend(context: privateMOC)
            newFriend.name = name
//            newFriend.profileImageName = profileImageName
            // convert image to data
            newFriend.profileImageData = profileImage?.cache_toData()
            synchronize()
            completion(newFriend)
        }
    }
    
    func createMessage(friend: Friend, text: String, minutesAgo: Double) {
        privateMOC.performAndWait {
//            print("create message")
//            printThreadStats()
            let newMessage = Message(context: privateMOC)
            newMessage.friend = friend
            newMessage.text = text
            newMessage.date = Date().addingTimeInterval(-minutesAgo * 60)
            synchronize()
        }
    }
    
    func createMessage(friend: Friend, text: String, date: Date, completion: @escaping (Message?) -> Void) {
        privateMOC.performAndWait {
            let newMessage = Message(context: privateMOC)
            newMessage.friend = friend
            newMessage.text = text
            newMessage.date = date
            synchronize()
            completion(newMessage)
        }
    }
    
    func removeAllFromEntity(entityName: String) {
        privateMOC.performAndWait {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try privateMOC.execute(deleteRequest)
                synchronize()
            } catch {
                print("removeAllFromEntity failed, \(error), \(error.localizedDescription)")
            }
        }
        
    }
    
    func synchronize() {
        do {
            // We call save on the the private context, which moves all of the changes into the main queue context without blocking the main queue.
            try privateMOC.save()
            managedObjectContext.performAndWait {
                do {
                    try managedObjectContext.save()
                } catch {
                    print("Could not synchonize data. \(error), \(error.localizedDescription)")
                }
            }
        } catch {
            print("Could not synchonize data. \(error), \(error.localizedDescription)")
        }
    }
    
    func printThreadStats() {
        if Thread.isMainThread {
            print(" --> on the main thread")
        } else {
            print(" --> off the main thread")
        }
    }
}
