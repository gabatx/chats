//
//  ChatTableViewDataSource.swift
//  Chats
//
//  Created by gabatx on 16/2/23.
//

import Foundation
import UIKit


class ChatTableViewDataSource: NSObject, UITableViewDataSource {

    private let tableView: UITableView
    private let presenter: ChatPresenter?

    private(set) var messages: [MessageCellViewModel] = [] {
        didSet {
            // DispatchQueue.main.async {  } Pensar para la conexión a la api
            self.tableView.reloadData()
        }
    }

    init(tableView: UITableView,
         messages: [MessageCellViewModel] = [],
         presenter: ChatPresenter) {
        self.tableView = tableView
        self.messages = messages
        self.presenter = presenter
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let message = messages[indexPath.row]
        var cell: MessageCell!

        if message.userFront {
            cell = tableView.dequeueReusableCell(withIdentifier: "messageCellRight", for: indexPath) as? MessageCell
            cell?.configureMessageRight(message: message)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "messageCellLeft", for: indexPath) as? MessageCell
            cell?.configureMessageLeft(message: message)
        }

        // Añadimos el gesto de "long press" a la celda
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_:)))
        cell.addGestureRecognizer(longPressGesture)

        return cell!
    }

    func setMessages(messages: [MessageCellViewModel]){
        self.messages = messages
    }

    func insertMessage(message: MessageCellViewModel){
        self.messages.append(message)
    }

    func getMessages() -> [MessageCellViewModel] {
        self.messages
    }

    @objc func handleLongPressGesture(_ gesture: UILongPressGestureRecognizer) {

        if gesture.state == .began {
            // Obtengo la celda que se ha pulsado
            guard
                let cell = gesture.view as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell) else { return }

            confirmDeleteMessage(index: indexPath.row)
        }
    }

    func confirmDeleteMessage(index: Int) {
        let alertController = UIAlertController(title: "Eliminar mensaje", message: "¿Seguro que desea eliminar el mensaje?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Eliminar", style: .destructive) { action in
            // Obtengo el id del mensaje
            let idMessage = self.messages[index].id
            // Elimino el mensaje del array y al hacerlo se refresca la pantalla
            self.messages.remove(at: index)
            self.presenter?.deleteMessage(idMessage: idMessage)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)

        // Presento el alert
        UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}
