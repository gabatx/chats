//
//  ContactsRouter.swift
//  Chats
//
//  Created by Escuela de Tecnologias Aplicadas on 13/2/23.
//

import Foundation
import UIKit

class ListOfContactsRouter {

    // Routers:
    var listOfContactsView: ListOfContactsView?
    var interactor: ListContactsInteractable?
    var presenter: ListOfContactsPresenter?

    func showListOfContacts() {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            return
        }
        listOfContactsView = sceneDelegate.listOfContactsView
        interactor = ListOfContactsInteractorUserDefaults() // <--- Tests
        presenter = ListOfContactsPresenter(listOfContactsInteractor: interactor!, listOfContactsRouter: self)
        presenter!.uiDelegate = sceneDelegate.listOfContactsView
        listOfContactsView!.presenter = presenter
    }

    func showChat(chatId: Int?){
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            return
        }
        guard let fromViewController = listOfContactsView else { return }
        sceneDelegate.chatRouter?.showListMessages(fromViewController: fromViewController, chatId: chatId)
    }

    func createNewChat(userId: Int) {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            return
        }
        guard let fromViewController = listOfContactsView else { return }
        sceneDelegate.chatRouter?.openNewChat(fromViewController: fromViewController, userId: userId)
    }
}
