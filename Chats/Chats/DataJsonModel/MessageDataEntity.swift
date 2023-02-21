//
//  MessageData.swift
//  Chats
//
//  Created by gabatx on 19/2/23.
//

import Foundation

struct MessageData: Codable {
    let id: Int
    let conversationId: Int
    let senderUserId: Int
    let messageContent: String
    let messageTimestamp: Int
    let readStatus: Bool
}
