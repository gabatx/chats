//
//  ContactsPresenter.swift
//  Chats
//
//  Created by Escuela de Tecnologias Aplicadas on 13/2/23.
//

import Foundation
import UIKit

protocol ListContactsUI: AnyObject{
    func update (contacts: [User])
}

class ListOfContactsPresenter {

    private let listOfContactsInteractor: ListContactsInteractable

    weak var uiDelegate: ListContactsUI?
    var listOfContactsRouter: ListOfContactsRouter
    var models: [User] = []

    init(listOfContactsInteractor: ListContactsInteractable,
         listOfContactsRouter: ListOfContactsRouter) {
        self.listOfContactsInteractor = listOfContactsInteractor
        self.listOfContactsRouter = listOfContactsRouter
    }

    func onViewAppear(){
        models = listOfContactsInteractor.getListContacts()
        uiDelegate?.update(contacts: models)
    }

    func onTapCell(atIndex: Int) {
        let userId = models[atIndex].id
        guard
            let chatId = listOfContactsInteractor.getChatIdBetweenUsers(token: UserDefault.token, contactId: userId) else {
            listOfContactsRouter.createNewChat(userId: userId)
            return
        }
        listOfContactsRouter.showChat(chatId: chatId)

    }
}
