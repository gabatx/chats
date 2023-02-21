//
//  ListOfChatsRouter.swift
//  Chats
//
//  Created by gabatx on 14/2/23.
//

import Foundation
import UIKit

class ListOfChatsRouter {

    // Routers: 

    var listOfChatsView: ListOfChatsView?
    var interactor: ListChatsInteractable?
    var presenter: ListOfChatsPresenter?

    func showListOfChats() {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            return
        }

        listOfChatsView = sceneDelegate.listOfChatsView
        interactor = ListOfChatsInteractorUserDefaults()
        presenter = ListOfChatsPresenter(listOfChatsInteractor: interactor!, listOfChatsRouter: self)
        // Ensamblamos
        presenter?.uiDelegate = sceneDelegate.listOfChatsView
        listOfChatsView!.presenter = presenter
    }

    func showChat(chatId: Int){

        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            return
        }

        guard let fromViewController = listOfChatsView else { return }
        sceneDelegate.chatRouter?.showListMessages(fromViewController: fromViewController, chatId: chatId)
    }

    func sendReply(chatId: Int, message: String) {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            return
        }

        sceneDelegate.chatRouter?.presenter?.insertMessage(contentMessage: message)
        sceneDelegate.chatRouter?.presenter?.onViewAppear(chatId: chatId)
        // Enviamos mensaje
        sceneDelegate.chatRouter?.sendMessageResponseNotificaction(chatId: chatId, message: message)

        sceneDelegate.tabBarController.selectedIndex = 1
        sceneDelegate.window?.rootViewController = sceneDelegate.tabBarController
        sceneDelegate.chatsNavController.popToRootViewController(animated: false)
        sceneDelegate.listOfChatsRouter.showChat(chatId: chatId)
    }
}
