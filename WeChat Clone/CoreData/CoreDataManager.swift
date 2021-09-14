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
    
    func fetchMessages(completion: @escaping ([Message]?) -> Void) {
        privateMOC.performAndWait {
            do {
//                print("fetch all messages")
//                printThreadStats()
                let messages: [Message] = try privateMOC.fetch(Message.fetchRequest())
                completion(messages)
            } catch {
                completion(nil)
            }
        }
    }
    
    func createFriend(name: String, profileImageName: String, completion: @escaping (Friend?) -> Void) {
        privateMOC.performAndWait {
//            print("create friend")
//            printThreadStats()
            let newFriend = Friend(context: privateMOC)
            newFriend.name = name
            newFriend.profileImageName = profileImageName
            synchronize()
            completion(newFriend)
        }
    }
    
    func createMessage(friend: Friend, text: String, date: Date) {
        privateMOC.performAndWait {
//            print("create message")
//            printThreadStats()
            let newMessage = Message(context: privateMOC)
            newMessage.friend = friend
            newMessage.text = text
            newMessage.date = date
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
