//
//  ChatView.swift
//  Chats
//
//  Created by gabatx on 14/2/23.
//

import UIKit


class ChatView: UIViewController {

    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var navBottomBackground: UIView!
    @IBOutlet weak var messageTextField: UITextField!

    var keyboardGestion: ManageKeyboard!
    var presenter: ChatPresenter?
    var chatTableViewDelegate: ChatTableViewDelegate?
    var chatTableViewDataSource: ChatTableViewDataSource?
    var messages: [MessageCellViewModel] = []

    // MARK: - Ciclo de vida
    override func loadView() {
        super.loadView()
        setupChatTableViewDataSource()
        chatTableViewDataSource?.setMessages(messages: messages)
        resetBadge()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        messageTextField.delegate = self
        setup()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        keyboardGestion.deletedObserverKeyboard()
        // Cerrar la instancia de la vista
        presenter?.chatRouter?.chatView = nil
    }

    // MARK: - Funciones
    func setup(){
        // Instancio ManageKeyboard
        keyboardGestion = ManageKeyboard(view: view, navBottomBackground: navBottomBackground)
        keyboardGestion.hidesKeyboardWhenClickingOutside(view: view)
        // Aniadimos observadores
        keyboardGestion.addObserverKeyboard()
        // Oculta la barra del tabBar
        self.tabBarController?.tabBar.isHidden = true
        // Muestra el tableView por la parte inferior
        if (chatTableViewDataSource?.getMessages().count)! > 0 {
            tableViewScrollBottom()
        }
    }

    func tableViewScrollBottom() {
        // Si no hay mensajes no hace nada
        if (chatTableViewDataSource?.getMessages().count) == nil { return }
        // Esperamos a que la tabla de mensajes se haya cargado completamente
        messageTableView.scrollToRow(at: IndexPath(row: (chatTableViewDataSource?.getMessages().count)! - 1, section: 0), at: .bottom, animated: true)
    }

    private func resetBadge() {
        UserDefault.badges = 0
        // Notificar que el badge ha cambiado
        DispatchQueue.main.async {
            UIApplication.shared.applicationIconBadgeNumber = UserDefault.badges
        }
    }

    // MARK: - IBAction
    @IBAction func sendMessageButton(_ sender: UIButton) {
        if messageTextField.text?.isEmpty == true { return }

        presenter?.insertMessage(contentMessage: messageTextField.text!)
        presenter?.sendNotificaction(contentMessage: messageTextField.text!)
        messageTextField.text = ""
    }
}

extension ChatView: ChatUI {
    func valueIfChatIsOpen(chatId: Int) {
        // si está abierto el nav controller
        if presenter?.chatRouter?.chatView != nil {
            // Si el chatId es el mismo que el que se está mostrando
            if chatId == presenter?.chatRouter?.chatIdPush {
                // Se resetea el badge
                resetBadge()
            }
        }
    }

    func insertMessageIntoTableView(message: MessageCellViewModel) {
        chatTableViewDataSource?.insertMessage(message: message)
        tableViewScrollBottom()
    }

    func updateFirstLoad(messages: [MessageCellViewModel]) {
        self.messages = messages
    }

    func setupChatTableViewDataSource() {
        chatTableViewDataSource = ChatTableViewDataSource(tableView: messageTableView, presenter: self.presenter!)
        chatTableViewDelegate = ChatTableViewDelegate()
        messageTableView.dataSource = chatTableViewDataSource
        messageTableView.delegate = chatTableViewDelegate
        messageTableView.rowHeight = UITableView.automaticDimension // Para que se ajuste al contenido
        messageTableView.estimatedRowHeight = 600 // Es necesario darle un valor estimado
        messageTableView.tableFooterView = UIView() // Elimina las lineas de separación de las celdas vacías
        messageTableView.separatorStyle = .none // Elimina las lineas de separación de las celdas
    }
}

extension ChatView: UITextFieldDelegate{
   // Al pulsar intro se envía el mensaje
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if messageTextField.text?.isEmpty == true { return false }
        presenter?.insertMessage(contentMessage: messageTextField.text!)
        messageTextField.text = ""
        return true
    }
    // Al llegar al final del textField hace un salto de linea
}
