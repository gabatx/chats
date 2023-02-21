//
//  ListOfChatsPresenter.swift
//  Chats
//
//  Created by gabatx on 14/2/23.
//

import Foundation
import UIKit

protocol ListChatsUI: AnyObject {
    func update (chats: [ChatCellViewModel])
}

class ListOfChatsPresenter {

    private let listOfChatsInteractor: ListChatsInteractable
    var listOfChatsRouter: ListOfChatsRouter?
    weak var uiDelegate: ListChatsUI?
    private var mapper: ChatCellMapper
    var viewModelsChatCell: [ChatCellViewModel] = []
    private var models: [Chat] = []

    init(listOfChatsInteractor: ListChatsInteractable,
         listOfChatsRouter: ListOfChatsRouter,
         mapper: ChatCellMapper = ChatCellMapper()) {
        self.listOfChatsInteractor = listOfChatsInteractor
        self.listOfChatsRouter = listOfChatsRouter
        self.mapper = mapper
    }

    func onViewAppear(){
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            return
        }

        let chatRouter = sceneDelegate.chatRouter
        let listOfContactsRouter = sceneDelegate.listOfContactsRouter

        models = listOfChatsInteractor.getListChats()

        // Mostrar solo las conversaciones de mi usuario
        models = models.filter { $0.participantIds.contains(UserDefault.userFrontId) }
        viewModelsChatCell = models.map { chat in
            let chatLastMessage = chatRouter?.interactor?.getMessagesChat(id: chat.id)[(chatRouter?.interactor?.getMessagesChat(id: chat.id).count)! - 1]
            let user = listOfContactsRouter?.interactor!.getUserById(id: chat.participantIds.first(where: { $0 != UserDefault.userFrontId })!)
            let initials = String(user!.name.prefix(1)) + String(user!.surname.prefix(1))
            return mapper.map(entity: chat, chatLastMessage: chatLastMessage!.messageContent, user: user!, initials: initials)
        }
        uiDelegate?.update(chats: viewModelsChatCell)
    }

    func onTapCell(atIndex: Int) {
        let chatId = models[atIndex].id
        listOfChatsRouter?.showChat(chatId: chatId)
    }


}
