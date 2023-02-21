//
//  ChatInteractorUserDefaults.swift
//  Chats
//
//  Created by gabatx on 17/2/23.
//

import Foundation

class ChatInteractorUserDefaults: ChatIntaractable {

    func getUserById(id: Int)  -> User? {
        return UserDefault.users.first(where: { $0.id == id })
    }

    func getMessagesChat(id: Int) -> [Message] {
        if let chat =  UserDefault.chats.first(where: { $0.id == id }) {
            return UserDefault.messages.filter { $0.conversationId == chat.id }.sorted(by: { $0.messageTimestamp < $1.messageTimestamp })
        }
        return []
    }

    func checkUserFrontMessageWithToken(message: Message) -> Bool {
        UserDefault.users.contains(where: { $0.id == message.senderUserId && $0.tokenID == UserDefault.token })
    }

    // Obtiene el id del usuario que tiene el token
    func getUserIdWithToken() -> Int {
        return UserDefault.users.first(where: { $0.tokenID == UserDefault.token })?.id ?? 0
    }

    // Obtiene el último id de todos los mensajes
    func lastIdMessages() -> Int {
        return UserDefault.messages.last?.id ?? 0
    }

    // Obtiene el char por id
    func getChatById(id: Int?) -> Chat? {
        return UserDefault.chats.first(where: { $0.id == id })
    }

    func deleteMessage( id: Int) {
        UserDefault.messages.removeAll(where: { $0.id == id })
    }

    func saveMessageInBD(message: Message) {
        UserDefault.messages.append(message)
    }
}


