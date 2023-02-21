//
//  SettingsInteractor.swift
//  Chats
//
//  Created by gabatx on 17/2/23.
//

import Foundation

protocol SettingInteractable {
    func insertTestData()
    func resetData()
}

class SettingsInteractor: SettingInteractable{

    func insertTestData(){
        let testData = TestData()

        UserDefault.users = testData.users
        UserDefault.chats = testData.chats
        UserDefault.messages = testData.messages
        UserDefault.token = testData.token
        //UserDefault.userFrontId = UUID(uuidString: "0")!
    }

    func resetData(){
        // Eliminar los valores que hemos introducido
        let memoriaUserDefault = UserDefaults.standard
        // print(memoriaUserDefault.dictionaryRepresentation()) // Que imprima el valor que se va a borrar
        memoriaUserDefault.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        memoriaUserDefault.synchronize()
    }
}
