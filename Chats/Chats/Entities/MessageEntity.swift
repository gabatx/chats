//
//  Message.swift
//  Chats
//
//  Created by gabatx on 14/2/23.
//

import Foundation

struct Message: Codable {
    let id: Int
    let conversationId: Int
    let senderUserId: Int
    let messageContent: String
    let messageTimestamp: Date
    let readStatus: Bool
}


