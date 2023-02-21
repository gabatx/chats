//
//  ChatPresenter.swift
//  Chats
//
//  Created by gabatx on 14/2/23.
//

import Foundation
import UIKit

protocol ChatUI: AnyObject {
    func updateFirstLoad(messages: [MessageCellViewModel])
    func insertMessageIntoTableView(message: MessageCellViewModel)
    func tableViewScrollBottom()
    var chatTableViewDataSource: ChatTableViewDataSource? { get set }
    func valueIfChatIsOpen(chatId: Int)
}

class ChatPresenter {

    weak var uiDeletage: ChatUI?

    let chatInteractor: ChatIntaractable
    var chatRouter: ChatRouter?
    private var messageCellMapper: MessageCellMapper
    private var messageMapper: MessageMapper
    private var dataMapper: DataMapper
    var viewModelsMessageCell: [MessageCellViewModel] = []
    var models: [Message] = []
    var chatId: Int?
    var userBackId:Int!

    init(chatInteractor: ChatIntaractable,
         mapper: MessageCellMapper = MessageCellMapper(),
         messageMapper: MessageMapper = MessageMapper(),
         dataMapper: DataMapper = DataMapper()) {
        self.chatInteractor = chatInteractor
        self.messageCellMapper = mapper
        self.messageMapper = messageMapper
        self.dataMapper = dataMapper
    }

    func onViewAppear(chatId: Int?){
        // Guardamos el id del chat
        self.chatId = chatId
        // Obtenemos el chat por id
        let chat = chatInteractor.getChatById(id: chatId)

        if let chat = chat {
            models = chatInteractor.getMessagesChat(id: chatId!)
            // Realizo una consulta para identificar que mensajes son los del userFront
            viewModelsMessageCell = models.map{ entity in
                return messageCellMapper.map(message: entity, isMessageUserFront: chatInteractor.checkUserFrontMessageWithToken(message: entity), conversationName: chat.conversationName)
            }
        }
        uiDeletage?.updateFirstLoad(messages: viewModelsMessageCell)
    }

    func openNewChat(userId: Int) {
        userBackId = userId
        uiDeletage?.updateFirstLoad(messages: viewModelsMessageCell)
    }

    func insertMessage(contentMessage: String){
        let id = chatInteractor.lastIdMessages() + 1
        let chat = chatInteractor.getChatById(id: chatId ?? 0)
        let userFrontId = chatInteractor.getUserIdWithToken()

        let message = MessageCellViewModel(
            id: id,
            conversationId: chat?.id ?? 0,
            conversationName: chat!.conversationName,
            senderUserId: userFrontId,
            messageContent: contentMessage,
            messageTimestamp: Date(),
            readStatus: true, // Todo: Implementar el readStatus
            userFront: true
        )
        uiDeletage?.insertMessageIntoTableView(message: message)
        uiDeletage?.tableViewScrollBottom()
        let messageMapper = messageMapper.map(messageCellViewModel: message)
        chatInteractor.saveMessageInBD(message: messageMapper)
    }


    func sendMessageResponseNotificaction(chatId: Int, message: String) {
        // -- Mapeamos a objetos enviables en un Json --

        // Preparo los datos del usuario que envía el mensaje
        let userFrontId = chatInteractor.getUserIdWithToken()
        let userFront = chatInteractor.getUserById(id: userFrontId)
        let userFrontData = dataMapper.mapUserToUserData(user: userFront)

        let chat = chatInteractor.getChatById(id: chatId)
        let chatData = dataMapper.mapChatToChatData(chat: chat)

        // Preparo los datos del usuario que recibe el mensaje
        let userBackId = chat?.participantIds.first(where: { $0 != userFrontId }) ?? 0
        let userBack = chatInteractor.getUserById(id: userBackId)
        let userBackData = dataMapper.mapUserToUserData(user: userBack)

        // Preparo los datos del mensaje
        let idMessage = chatInteractor.lastIdMessages() + 1
        let messageData = dataMapper.mapMessageToMessageData(idMessage: idMessage,
                                                             chatId: chatId,
                                                             userFrontId: userFrontId,
                                                             contentMessage: message)

        guard let url = URL(string: "https://funcody.com/lib/test-noti/push.php") else { return }

        let parameters = SendDataJson(message: messageData, userFront: userFrontData, userBack: userBackData, chat: chatData)
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(parameters)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
                    if let data = data {
                        print(String(data: data, encoding: .utf8)!)
                    }
                }.resume()
    }

    func sendNotificaction(contentMessage: String){
        // -- Mapeamos a objetos enviables en un Json --

        var chatData: ChatData!
        var userBackData: UserData!

        // Preparo los datos del usuario que envía el mensaje
        let userFrontId = chatInteractor.getUserIdWithToken()
        let userFront = chatInteractor.getUserById(id: userFrontId)
        let userFrontData = dataMapper.mapUserToUserData(user: userFront)

        // Si existe la conversación la preparamos
        if let chat = chatInteractor.getChatById(id: chatId) {
            chatData = dataMapper.mapChatToChatData(chat: chat)
            // Preparo los datos del usuario que recibe el mensaje
            let userBackId = chat.participantIds.first(where: { $0 != userFrontId }) ?? 0
            let userBack = chatInteractor.getUserById(id: userBackId)
            userBackData = dataMapper.mapUserToUserData(user: userBack)
        } else {
            // Si no existe la conversación la creamos
            let listOfChatsInteractor = ListOfChatsInteractorUserDefaults()
            let newChatId = listOfChatsInteractor.getListChats().count + 1
            let chat = Chat(id: newChatId, conversationName: "", participantIds: [userFrontId, userBackId], startDate: Date())
            chatData = dataMapper.mapChatToChatData(chat: chat)
            // Preparo los datos del usuario que recibe el mensaje
            let userBack = chatInteractor.getUserById(id: userBackId)
            userBackData = dataMapper.mapUserToUserData(user: userBack)
        }

        // Preparo los datos del mensaje
        let idMessage = chatInteractor.lastIdMessages() + 1
        let messageData = dataMapper.mapMessageToMessageData(idMessage: idMessage,
                                                             chatId: chatId ?? 0,
                                                             userFrontId: userFrontId,
                                                             contentMessage: contentMessage)

        guard let url = URL(string: "https://funcody.com/lib/test-noti/push.php") else { return }

        let parameters = SendDataJson(message: messageData, userFront: userFrontData, userBack: userBackData, chat: chatData)
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(parameters)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
            }
        }.resume()
    }

    func insertMessageByNotification(contentMessage: String, chatId: Int, chatIdPush: Int? = nil, usuarioId: Int){
        let id = chatInteractor.lastIdMessages() + 1
        let chat = chatInteractor.getChatById(id: chatId )
        let userSender = chatInteractor.getUserById(id: usuarioId)
        let message = createMessage(id: id, chat: chat, userSender: userSender, contentMessage: contentMessage)
        let messageMapper = messageMapper.map(messageCellViewModel: message)
        chatInteractor.saveMessageInBD(message: messageMapper)

        // Si el mensaje corresponde al id del usuario se inserta en la tabla
        if let chatIdPush = chatIdPush, chatIdPush == chatId {
            uiDeletage?.insertMessageIntoTableView(message: message)
            // Si estoy en la conversación actualizo el badge
            uiDeletage?.valueIfChatIsOpen(chatId: chatId)
        }

        // Actualizamos la lista de chats de ListOfChats
        chatRouter?.updateTableView()
    }

    private func resetBadge() {
        UserDefault.badges = 0
        // Notificar que el badge ha cambiado
        DispatchQueue.main.async {
            UIApplication.shared.applicationIconBadgeNumber = UserDefault.badges
        }
    }

    private func createMessage(id: Int, chat: Chat?, userSender: User?, contentMessage: String) -> MessageCellViewModel {
        let message = MessageCellViewModel(
            id: id,
            conversationId: chat?.id ?? 0,
            conversationName: chat!.conversationName,
            senderUserId: userSender!.id,
            messageContent: contentMessage,
            messageTimestamp: Date(),
            readStatus: true, // Todo: Implementar el readStatus
            userFront: false
        )
        return message
    }

    func deleteMessage(idMessage: Int){
        chatInteractor.deleteMessage(id: idMessage)
    }
}
