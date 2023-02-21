//
//  SettingsPresenter.swift
//  Chats
//
//  Created by gabatx on 17/2/23.
//

import Foundation

protocol SettingsUI: AnyObject{
    func insertValuesDefaultForm()
}

class SettingsPresenter {

    weak var uiDelegate: SettingsUI?
    var settingsRouter: SettingsRouter
    var settingsInteractor: SettingInteractable

    init(settingsInteractor: SettingInteractable,
         settingsRouter: SettingsRouter) {
        self.settingsInteractor = settingsInteractor
        self.settingsRouter = settingsRouter
    }

    func resetData(){
        settingsInteractor.resetData()
        settingsRouter.restarApp()
    }

    func insertTestData(){
        settingsInteractor.insertTestData()
        settingsRouter.restarApp()
    }
}
