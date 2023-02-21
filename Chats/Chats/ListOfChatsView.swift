//
//  ListOfChatsView.swift
//  Chats
//
//  Created by Escuela de Tecnologias Aplicadas on 13/2/23.
//

import UIKit

class ListOfChatsView: UIViewController, ListChatsUI {

    @IBOutlet weak var listOfChatsTableView: UITableView!

    var presenter: ListOfChatsPresenter?
    var chats: [ChatCellViewModel] = []
    var listOfChatsTableViewDataSource: ListOfChatsTableViewDataSource?
    var listOfChatsTableViewDelegate: ListOfChatsTableViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        listOfChatsTableViewDataSource = ListOfChatsTableViewDataSource(tableView: listOfChatsTableView)
        listOfChatsTableView.dataSource = listOfChatsTableViewDataSource
        listOfChatsTableViewDelegate = ListOfChatsTableViewDelegate()
        listOfChatsTableView.delegate = listOfChatsTableViewDelegate

        // Cargará los contactos
        presenter?.onViewAppear()

        listOfChatsTableViewDelegate?.didTapOnCell = { [weak self] index in
            self?.presenter?.onTapCell(atIndex: index)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        // Muestra la barra tabBar
        self.tabBarController?.tabBar.isHidden = false
    }

    func update(chats: [ChatCellViewModel]) {
        listOfChatsTableViewDataSource?.setMessages(chats: chats)
    }
}


