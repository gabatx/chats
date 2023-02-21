//
//  ContactsInteractor.swift
//  Chats
//
//  Created by Escuela de Tecnologias Aplicadas on 13/2/23.
//

import Foundation

protocol ListContactsInteractable {
    func getListContacts() -> [User]
    func getChatIdBetweenUsers(token: String, contactId: Int) -> Int?
    func getUserById(id: Int) -> User
}

class ListOfContactsInteractorUserDefaults: ListContactsInteractable{

    func getListContacts() -> [User] {
        // Elimino el usuario que tenga mi token
        let users = UserDefault.users.filter{ $0.tokenID != UserDefault.token }
        return users
    }

    func getChatIdBetweenUsers(token: String, contactId: Int) -> Int? {
         // Busco el id del usuario que tiene el token
          let myId = UserDefault.users.first(where: { $0.tokenID == token })?.id
          // Busco el id del chat entre mi usuario y el contacto
          let chatId = UserDefault.chats.first(where: { $0.participantIds.contains(myId!) && $0.participantIds.contains(contactId) })?.id
          return chatId
    }

    func getUserById(id: Int) -> User {
        UserDefault.users.first(where: { $0.id == id })!
    }
}

class ListOfContactsInteractorMock: ListContactsInteractable{

    let testData = TestData()

    func getListContacts() -> [User] {
        testData.users
    }

    // Función que busca el id del chat entre dos usuarios, el mío (token) y el del contacto.
    func getChatIdBetweenUsers(token: String, contactId: Int) -> Int? {
        // Busco el id del usuario que tiene el token
        let myId = testData.users.first(where: { $0.tokenID == token })?.id
        // Busco el id del chat entre mi usuario y el contacto
        let chatId = testData.chats.first(where: { $0.participantIds.contains(myId!) && $0.participantIds.contains(contactId) })?.id
        return chatId!
    }

    func getUserById(id: Int) -> User {
        testData.users.first(where: { $0.id == id })!
    }
}
