//
//  ListOfChatsTableViewDataSource.swift
//  Chats
//
//  Created by gabatx on 20/2/23.
//

import Foundation
import UIKit

class ListOfChatsTableViewDataSource: NSObject, UITableViewDataSource  {

    private let tableView: UITableView

    private(set) var chats: [ChatCellViewModel] = [] {
        didSet {
            // DispatchQueue.main.async {  } Pensar para la conexión a la api
            self.tableView.reloadData()
        }
    }

    init(tableView: UITableView,
         chats: [ChatCellViewModel] = []) {
        self.tableView = tableView
        self.chats = chats
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.chats.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! ChatCell
        let chat = chats[indexPath.row]
        cell.configure(chat: chat)
        return cell
    }

    func removeLast() {
        self.chats.removeLast()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    } 

    func setMessages(chats: [ChatCellViewModel]){
        self.chats = chats
    }

    func insertMessage(chat: ChatCellViewModel){
        self.chats.append(chat)
    }

    func getMessages() -> [ChatCellViewModel] {
        self.chats
    }

}
