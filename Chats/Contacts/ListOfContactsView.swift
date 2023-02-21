//
//  ListOfContactsView.swift
//  Chats
//
//  Created by gabatx on 13/2/23.
//

import UIKit

class ListOfContactsView: UIViewController, ListContactsUI {

    @IBOutlet weak var listOfContactsTableView: UITableView!

    var presenter: ListOfContactsPresenter?
    var contacts: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        listOfContactsTableView.delegate = self
        listOfContactsTableView.dataSource = self

        presenter?.onViewAppear()
    }

    override func viewWillAppear(_ animated: Bool) {
        // Muestra la barra tabBar
        self.tabBarController?.tabBar.isHidden = false
    }

    func update(contacts: [User]) {
        self.contacts = contacts

    }
}

extension ListOfContactsView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.contacts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactCell
        let contact = contacts[indexPath.row]

        cell.configure(contact: contact)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.onTapCell(atIndex: indexPath.row)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
