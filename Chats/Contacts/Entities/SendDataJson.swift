//
//  SendDataJson.swift
//  Chats
//
//  Created by gabatx on 19/2/23.
//

import Foundation

struct SendDataJson: Encodable {
    let message: MessageData
    let userFront: UserData
    let userBack: UserData
    let chat: ChatData
}
