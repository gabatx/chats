//
//  ContactCellMapper.swift
//  Chats
//
//  Created by gabatx on 14/2/23.
//

import Foundation
import UIKit

struct ChatCellMapper {
    func map(entity: Chat, chatLastMessage: String, user: User, initials: String) -> ChatCellViewModel {

        return ChatCellViewModel(
            idChat: entity.id,
            initials: initials,
            conversationName: user.name,
            chatLastMessage: chatLastMessage,
            startDate: entity.startDate
        )
    }
}
