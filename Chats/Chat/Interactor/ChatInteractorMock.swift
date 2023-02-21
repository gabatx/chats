//
//  ChatInteractor.swift
//  Chats
//
//  Created by gabatx on 14/2/23.
//

import Foundation

class ChatInteractorMock: ChatIntaractable {

    var testData = TestData()

    func getUserById(id: Int) -> User? {
        return testData.users.first(where: { $0.id == id })
    }

    func getMessagesChat(id: Int) -> [Message]{
        if let chat =  testData.chats.first(where: { $0.id == id }) {
            return testData.messages.filter { $0.conversationId == chat.id }.sorted(by: { $0.messageTimestamp < $1.messageTimestamp })
        }
        return []
    }

    func checkUserFrontMessageWithToken(message: Message) -> Bool {
        // Comprueba que el id del mensaje corresponde a un usuario que tiene el token
        testData.users.contains(where: { $0.id == message.senderUserId && $0.tokenID == testData.token })
    }

    // Obtiene el id del usuario que tiene el token
    func getUserIdWithToken() -> Int {
        return testData.users.first(where: { $0.tokenID == testData.token })?.id ?? 0
    }

    // Obtiene el último id de todos los mensajes
    func lastIdMessages() -> Int {
        return testData.messages.last?.id ?? 0
    }

    // Obtiene el char por id
    func getChatById(id: Int?) -> Chat? {
        return testData.chats.first(where: { $0.id == id })
    }

    func deleteMessage( id: Int) {
        testData.messages.removeAll(where: { $0.id == id })
    }

    func saveMessageInBD(message: Message) {
        testData.messages.append(message)
    }

    // Implementar función que cuando se vaya a cerrar la vista de chat enviar la info del textField a la bbdd.

    // Implementar función que recupere de la bbdd la información del textField.

}

