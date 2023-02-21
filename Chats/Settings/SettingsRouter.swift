//
//  SettingsRouter.swift
//  Chats
//
//  Created by gabatx on 17/2/23.
//

import Foundation
import UIKit

class SettingsRouter {

    // Routers:
    var settingsView: SettingsView?

    func setupSettings(){

        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            return
        }

        self.settingsView = sceneDelegate.settingsView
        let interactor = SettingsInteractor() // <--- Tests
        let presenter = SettingsPresenter(settingsInteractor: interactor, settingsRouter: self)
        presenter.uiDelegate = settingsView
        settingsView!.presenter = presenter
    }

    func restarApp(){
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            return
        }
        sceneDelegate.setupStart()
        sceneDelegate.restarView()
    }
}
