//
//  ChatDataEntity.swift
//  Chats
//
//  Created by gabatx on 19/2/23.
//

import Foundation

struct ChatData: Codable {
    let id: Int
    let conversationName: String
    let participantIds: [Int]
    let startDate: Int
}
