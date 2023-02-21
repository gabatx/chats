//
//  MessageCellViewModel.swift
//  Chats
//
//  Created by gabatx on 15/2/23.
//

import Foundation

struct MessageCellViewModel {
    let id: Int
    let conversationId: Int
    let conversationName: String
    let senderUserId: Int
    let messageContent: String
    let messageTimestamp: Date
    let readStatus: Bool
    let userFront: Bool
}
