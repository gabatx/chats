//
//  ChatCell.swift
//  Chats
//
//  Created by gabatx on 14/2/23.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var chatName: UILabel!
    @IBOutlet weak var chatLastMessage: UILabel!
    @IBOutlet weak var chatInitials: UILabel!
    @IBOutlet weak var chatInitialsBackground: RoundView!
    @IBOutlet weak var chatNotifications: UILabel!
    @IBOutlet weak var chatDateLastMessage: UILabel!

    func configure(chat: ChatCellViewModel){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"

        chatName.text = chat.conversationName
        chatDateLastMessage.text = dateFormatter.string(from: chat.startDate) // Cambiarlo por el último mensaje de los dos usuarios
        chatLastMessage.text = chat.chatLastMessage
        chatInitials.text = chat.initials
        chatInitialsBackground.backgroundColor = generatorRandomColor()
        chatNotifications.text = "3" // Cambiar por la notificación real
    }

    func generatorRandomColor() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}
