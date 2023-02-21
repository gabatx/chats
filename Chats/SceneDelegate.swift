//
//  SceneDelegate.swift
//  Chats
//
//  Created by Escuela de Tecnologias Aplicadas on 13/2/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var listOfContactsView: ListOfContactsView!
    var listOfChatsView: ListOfChatsView!
    var settingsView: SettingsView!
    var tabBarController: UITabBarController!
    var chatsNavController: UINavigationController!
    var contactsNavController: UINavigationController!
    var listOfContactsRouter:  ListOfContactsRouter!
    var listOfChatsRouter:  ListOfChatsRouter!
    var settingsRouter:  SettingsRouter!
    var chatRouter: ChatRouter!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }

        setupStart()

        // Creamos la instancia de la ventana desde aquí
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.windowScene = scene as? UIWindowScene
        self.window = window

        self.window?.rootViewController = self.tabBarController
        self.window?.makeKeyAndVisible()
    }

    func setupStart(){
        // Todo: Hacer una clase esambladora para todo esto.

        // Instanciamos las vistas
        listOfContactsView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "listOfContactsIdStory") as? ListOfContactsView
        listOfChatsView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "listOfChatsIdStory") as? ListOfChatsView
        settingsView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "settingsIdStory") as? SettingsView

        // Instanciamos los navegadores
        tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarControllerStoryBoardId") as? UITabBarController
        chatsNavController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "chatsNavControllerStoryBoardId") as? UINavigationController
        contactsNavController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "contactsNavControllerStoryBoardId") as? UINavigationController

        // Aplicamos las rutas de las vistas del nav
        listOfContactsRouter = ListOfContactsRouter()
        listOfChatsRouter = ListOfChatsRouter()
        settingsRouter = SettingsRouter()
        chatRouter = ChatRouter()
        listOfContactsRouter.showListOfContacts()
        listOfChatsRouter.showListOfChats()
        settingsRouter.setupSettings()
        chatRouter.assembleRouter()

        // Asignar el tab Bar Controller y el navigation Controller
        chatsNavController.viewControllers = [listOfChatsView]
        contactsNavController.viewControllers = [listOfContactsView]
        tabBarController.viewControllers = [settingsView, chatsNavController, contactsNavController]
        tabBarController.selectedIndex = 1 // Le decimos por la página que debe abrir
    }

    func restarView(){
        tabBarController.selectedIndex = 1 // Le decimos por la página que debe abrir
        self.window?.rootViewController = self.tabBarController
        self.window?.makeKeyAndVisible()
    }
}
