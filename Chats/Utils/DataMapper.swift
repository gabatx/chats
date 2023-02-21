//
//  UserDataMapper.swift
//  Chats
//
//  Created by gabatx on 19/2/23.
//

import Foundation

struct DataMapper {

    func mapUserToUserData(user: User?) -> UserData {
        UserData(id: user?.id ?? 0,
                tokenID: user?.tokenID ?? "",
                username: user?.username ?? "",
                name: user?.name ?? "",
                surname: user?.surname ?? "",
                password: user?.password ?? "",
                email: user?.email ?? "",
                registrationDate: Int(user?.registrationDate.timeIntervalSince1970 ?? 0),
                lastLoginDate: Int(user?.lastLoginDate.timeIntervalSince1970 ?? 0)
        )
    }

    func mapUserDataToUser(user: [String: Any]) -> User {
        User(
                id: user["id"] as! Int,
                tokenID: user["tokenID"] as! String,
                username: user["username"] as! String,
                name: user["name"] as! String,
                surname: user["surname"] as! String,
                password: user["password"] as! String,
                email: user["email"] as! String,
                registrationDate: Date(timeIntervalSince1970: TimeInterval(user["registrationDate"] as! Int)),
                lastLoginDate: Date(timeIntervalSince1970: TimeInterval(user["lastLoginDate"] as! Int))
        )
    }

    func mapChatToChatData(chat: Chat?) -> ChatData {
        ChatData(id: chat?.id ?? 0,
                conversationName: chat?.conversationName ?? "",
                participantIds: chat?.participantIds ?? [],
                startDate: Int(chat?.startDate.timeIntervalSince1970 ?? 0)
        )
    }

    func mapChatDataToChat(chat: [String: Any]) -> Chat {
        Chat(
                id: chat["id"] as! Int,
                conversationName: chat["conversationName"] as! String,
                participantIds: chat["participantIds"] as! [Int],
                startDate: Date(timeIntervalSince1970: TimeInterval(chat["startDate"] as! Int))
        )
    }

    func mapMessageToMessageData(idMessage: Int, chatId: Int, userFrontId: Int, contentMessage: String) -> MessageData {
        MessageData(
                id: idMessage,
                conversationId: chatId,
                senderUserId: userFrontId,
                messageContent: contentMessage,
                messageTimestamp: Int(Date().timeIntervalSince1970),
                readStatus: false
        )
    }

    func mapMessageDataToMessage(message: [String: Any]) -> Message {
        Message(
                id: message["id"] as! Int,
                conversationId: message["conversationId"] as! Int,
                senderUserId: message["senderUserId"] as! Int,
                messageContent: message["messageContent"] as! String,
                messageTimestamp: Date(timeIntervalSince1970: TimeInterval(message["messageTimestamp"] as! Int)),
                readStatus: message["readStatus"] as! Bool
        )
    }


}
