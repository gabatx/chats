//
//  MessageCellMapper.swift
//  Chats
//
//  Created by gabatx on 15/2/23.
//

import Foundation

struct MessageCellMapper {


    func map(message: Message, isMessageUserFront: Bool, conversationName: String) -> MessageCellViewModel {
        MessageCellViewModel(
            id: message.id,
            conversationId: message.conversationId,
            conversationName: conversationName,
            senderUserId: message.senderUserId,
            messageContent: message.messageContent,
            messageTimestamp: message.messageTimestamp,
            readStatus: message.readStatus,
            userFront: isMessageUserFront
        )
    }
}
