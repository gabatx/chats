//
//  ChatEntity.swift
//  Chats
//
//  Created by gabatx on 14/2/23.
//

import Foundation

struct Chat: Codable {
    let id: Int
    let conversationName: String
    let participantIds: [Int]
    let startDate: Date
}

