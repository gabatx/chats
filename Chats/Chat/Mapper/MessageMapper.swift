//
//  MessageMapper.swift
//  Chats
//
//  Created by gabatx on 17/2/23.
//

import Foundation


struct MessageMapper {
    func map(messageCellViewModel: MessageCellViewModel) -> Message {
        return Message (
            id: messageCellViewModel.id,
            conversationId: messageCellViewModel.conversationId,
            senderUserId: messageCellViewModel.senderUserId,
            messageContent: messageCellViewModel.messageContent,
            messageTimestamp: messageCellViewModel.messageTimestamp,
            readStatus: messageCellViewModel.readStatus
        )
    }
}
