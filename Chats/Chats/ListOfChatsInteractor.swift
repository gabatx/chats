//
//  ListOfChatsInteractor.swift
//  Chats
//
//  Created by gabatx on 14/2/23.
//

import Foundation

protocol ListChatsInteractable {
    func getListChats() -> [Chat]
}

class ListOfChatsInteractorUserDefaults: ListChatsInteractable{

    func getListChats() -> [Chat] {
        UserDefault.chats.count > 0 ? UserDefault.chats : []
    }
}

class ListOfChatsInteractorMock: ListChatsInteractable {
    let testData = TestData()

    func getListChats() -> [Chat]{
        testData.chats.count > 0 ? testData.chats : []
    }
}

// Dame todos los chats que se han abierto. Sería algo como:
    // Tabla mensajes: Dame todos los ids de senderUserId (que no sea este id el mío)
    // Tabla chats: Dame todas las conversaciones donde en participantIds se encuentre algún id de los senderUserId de la linea anterior
// El úlitmo mensaje de la conversación.
    // Tabla mensajes: De la conversación con id tal, dame el último mensaje (messageTimestamp)
