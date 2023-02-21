//
//  MessageCell.swift
//  Chats
//
//  Created by gabatx on 15/2/23.
//

import UIKit

class MessageCell: UITableViewCell {

    // MARK: - Usuario derecha
    @IBOutlet weak var messageBackgroundRight: UIView!
    @IBOutlet weak var contentMessageRight: UILabel!
    @IBOutlet weak var imageUserBackgroundRight: UIView!
    @IBOutlet weak var dateMessageRight: UILabel!
    @IBOutlet weak var nameUserRight: UILabel!
    // MARK: - Usuario izquierda
    @IBOutlet weak var messageBackgroundLeft: UIView!
    @IBOutlet weak var contentMessageLeft: UILabel!
    @IBOutlet weak var imageUserBackgroundLeft: UIView!
    @IBOutlet weak var dateMessageLeft: UILabel!
    @IBOutlet weak var nameUserLeft: UILabel!

    func configureMessageRight(message: MessageCellViewModel){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        messageBackgroundRight.layer.cornerRadius = 13.0
        contentMessageRight.text = message.messageContent
        imageUserBackgroundRight.layer.cornerRadius = 10.0
        dateMessageRight.text = dateFormatter.string(from: message.messageTimestamp)
        nameUserRight.text = "Yo"
    }

    func configureMessageLeft(message: MessageCellViewModel){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        messageBackgroundLeft.layer.cornerRadius = 13.0
        contentMessageLeft.text = message.messageContent
        imageUserBackgroundLeft.layer.cornerRadius = 10.0
        dateMessageLeft.text = dateFormatter.string(from: message.messageTimestamp)
        nameUserLeft.text = message.conversationName
    }
}
