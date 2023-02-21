//
//  ChatRouter.swift
//  Chats
//
//  Created by gabatx on 14/2/23.
//

import Foundation
import UIKit

class ChatRouter {

    var chatView: ChatView?
    var interactor: ChatIntaractable?
    var presenter: ChatPresenter?
    var chatIdPush: Int?

    func assembleRouter() {
        chatView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "chatIdStory") as? ChatView
        interactor = ChatInteractorUserDefaults()
        presenter = ChatPresenter(chatInteractor: interactor!)
        presenter?.uiDeletage = chatView
        chatView?.presenter = presenter
        presenter?.chatRouter = self
    }

    // Borrar del sceneDelegate y enviar desde el didOnTap del table view
    func showListMessages(fromViewController: UIViewController, chatId: Int?) {
        assembleRouter()
        chatIdPush = chatId
        // Le envía a esta función idChat. Esta función se encargará de buscar el chat por id y devolver los mensajes de los participantes
        presenter?.onViewAppear(chatId: chatId)
        fromViewController.navigationController!.pushViewController(chatView!, animated: true)
    }

    func insertMessageNotification(chatId: Int, contentMessage: String, usuarioId: Int) {
        presenter?.insertMessageByNotification(contentMessage: contentMessage, chatId: chatId, chatIdPush: self.chatIdPush, usuarioId: usuarioId)
        presenter?.uiDeletage?.tableViewScrollBottom()
        presenter?.onViewAppear(chatId: chatId)
    }

    func openNewChat(fromViewController: ListOfContactsView, userId: Int) {
        let chatRouter = ChatRouter()
        chatRouter.showListMessages(fromViewController: fromViewController, chatId: nil)
        chatRouter.presenter?.openNewChat(userId: userId)
    }

    func sendMessageResponseNotificaction(chatId: Int, message: String) {
        presenter?.sendMessageResponseNotificaction(chatId: chatId, message: message)
    }

    func updateTableView() {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            return
        }
        sceneDelegate.listOfChatsRouter?.presenter?.onViewAppear()
    }

}
