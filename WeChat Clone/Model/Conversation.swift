//
//  Conversation.swift
//  WeChat Clone
//
//  Created by HaiboZhou on 2021/9/14.
//

import Foundation

struct Conversation {
    var id: UUID?
    var title: String?
    var subTitle: String?
    var cover: ImageWrapper?
    var messages: [Message]? = nil
    var date: Date?
}

struct Message {
    var id: UUID?
    var people: Person?
    var body: Any
    var date: Date?
}

struct Person {
    var id: UUID?
    var name: String?
    var cover: ImageWrapper?
}
