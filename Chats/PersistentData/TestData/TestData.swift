//
//  TestData.swift
//  Chats
//
//  Created by gabatx on 15/2/23.
//

import Foundation

struct TestData {

    var users: [User] = [
        User(
            id: 0,
            tokenID: "1d313f6d8c9e84b282fad1fbca83f063de9a1dc1e613fede292da57e1be660ff",
            username: "gabatx",
            name: "Javier",
            surname: "Cuadros",
            password: "123456",
            email: "gabatx.registros.1",
            registrationDate: Date(),
            lastLoginDate: Date()
        ),

        User(
            id: 1,
            tokenID: "99ce2775314cc39b2cce06ad8575193fa12a1433ef767962aab3d45ca085601b",
            username: "Nicksus",
            name: "Pedro",
            surname: "Rodríguez",
            password: "123456",
            email: "gabatx.registros.2",
            registrationDate: Date(),
            lastLoginDate: Date()
        ),

        User(
            id: 2,
            tokenID: "",
            username: "Clarens",
            name: "Andrían",
            surname: "López",
            password: "123456",
            email: "gabatx.registros.3",
            registrationDate: Date(),
            lastLoginDate: Date()
        )
    ]

    var chats: [Chat] = [
        Chat(
            id: 0,
            conversationName: "Pedro Martínez",
            participantIds: [0, 1],
            startDate: Date()
        ),
        Chat(
            id: 1,
            conversationName: "Andrían López",
            participantIds: [0, 2],
            startDate: Date()
        )
    ]

    var messages: [Message] = [
        // Conversación 1:

        Message(id: 0,
                conversationId: 0,
                senderUserId: 0,
                messageContent: "Usuario 1 Primer mensaje: Lorem ipsum dolor sit amet consectetur. Massa ut interdum dui augue.",
                messageTimestamp: Date(),
                readStatus: false),

        Message(id: 1,
                conversationId: 0,
                senderUserId: 1,
                messageContent: "Usuario 2: Lorem ipsum dolor sit amet consectetur. Massa ut interdum dui augue. Lacinia sed tortor nunc lacus nunc dapibus. Lorem ipsum dolor sit amet consectetur. Massa ut interdum dui augue. Lacinia sed tortor nunc lacus nunc dapibus. Lorem ipsum dolor sit amet consectetur. Massa ut interdum dui augue. Lacinia sed tortor nunc lacus nunc dapibus. Lorem ipsum dolor sit amet consectetur. Massa ut interdum dui augue. Lacinia sed tortor nunc lacus nunc dapibus.",
                messageTimestamp: Date(),
                readStatus: false),

        Message(id: 2,
                conversationId: 0,
                senderUserId: 0,
                messageContent: "Usuario 1: Lorem ipsum dolor sit amet consectetur. Massa ut interdum dui augue. Lacinia sed tortor nunc lacus nunc dapibus. Lorem ipsum dolor sit amet consectetur. Massa ut interdum dui augue.",
                messageTimestamp: Date(),
                readStatus: false),

        Message(id: 3,
                conversationId: 0,
                senderUserId: 0,
                messageContent: "Usuario 1: Lorem ipsum dolor",
                messageTimestamp: Date(),
                readStatus: false),

        Message(id: 4,
                conversationId: 0,
                senderUserId: 1,
                messageContent: "Usuario 2: Lorem ipsum dolor sit amet consectetur. Massa ut interdum dui augue. Lacinia sed tortor nunc lacus nunc dapibus. Lorem ipsum dolor sit amet consectetur. Massa ut interdum dui augue.",
                messageTimestamp: Date(),
                readStatus: false),

        Message(id: 5,
                conversationId: 0,
                senderUserId: 0,
                messageContent: "Usuario 1: Lorem ipsum dolor sit amet consectetur. Massa ut interdum dui augue. Lacinia sed tortor nunc lacus nunc dapibus.",
                messageTimestamp: Date(),
                readStatus: false),

        // Conversación 2:

        Message(id: 6,
                conversationId: 1,
                senderUserId: 0,
                messageContent: "Usuario 1: Hola",
                messageTimestamp: Date(),
                readStatus: false),

        Message(id: 7,
                conversationId: 1,
                senderUserId: 2,
                messageContent: "Usuario 2: Adios",
                messageTimestamp: Date(),
                readStatus: false)
    ]

    var token: String = "1d313f6d8c9e84b282fad1fbca83f063de9a1dc1e613fede292da57e1be660ff"
    var userFrontId: Int {
        return users.firstIndex(where: { $0.tokenID == token }) ?? 0
    }
}
