//
//  ChatInteractable.swift
//  Chats
//
//  Created by gabatx on 17/2/23.
//

import Foundation

protocol ChatIntaractable {
    func getMessagesChat(id: Int) -> [Message]
    func checkUserFrontMessageWithToken(message: Message) -> Bool
    func getUserIdWithToken() -> Int
    func lastIdMessages() -> Int
    func getChatById(id: Int?) -> Chat?
    func deleteMessage( id: Int)
    func saveMessageInBD(message: Message)
    func getUserById(id: Int) -> User?

}
