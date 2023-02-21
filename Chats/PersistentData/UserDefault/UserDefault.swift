//
//  UserData.swift
//  Chats
//
//  Created by gabatx on 15/2/23.
//

/*
Se puede crear un tipo de dato para el usuario principal que le de un identificador único UUID.
De esta forma se puede identificar al usuario principal y no tener que hacer una consulta a la base de datos para
obtener el id del usuario principal.

Ejemplo:
let userFrontId = UUID()

Para darle un valor a la variable userFrontId se puede hacer:
let userFrontId = UUID(uuidString: "852c23fb11b802d9a56a3a6ada2b290d44a3fd720ae45babfeadfb0c2492fed5")!

Para obtener el id del usuario principal se puede hacer:
let userFrontId = userFrontId.uuidString

Para modificar el id del usuario principal se puede hacer:
userFrontId = UUID(uuidString: "0")!
*/

import Foundation

// Aquí definimos todas las variables que definimos en UserDefault
struct UserDefault {
    // Definimos las variables que queremos guardar en UserDefault. En este caso, el nombre de usuario y la contraseña
    @Storage(key: "users", defaultValue: [])
    static var users: [User]

    @Storage(key: "chats", defaultValue: [])
    static var chats: [Chat]

    @Storage(key: "messages", defaultValue: [])
    static var messages: [Message]

    @Storage(key: "token", defaultValue: "") // Por defecto, no queremos que se recuerde la contraseña
    static var token: String

    @Storage(key: "userFrontId", defaultValue: 0)
    static var userFrontId: Int

    @Storage(key: "badges", defaultValue: 0)
    static var badges: Int
    
}

// Aquí definimos el protocolo que vamos a usar para guardar los datos en UserDefault
@propertyWrapper
struct Storage<T: Codable>{
    private let key: String
    private let defaultValue: T

    init(key: String, defaultValue: T){
        self.key = key
        self.defaultValue = defaultValue
    }
    // wrappedValue es el valor que se va a guardar en UserDefault
    var wrappedValue: T {
        get {
            guard
                let data = UserDefaults.standard.data(forKey: key),
                let value = try? JSONDecoder().decode(T.self, from: data) else {
                return defaultValue
            }
            return value
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else { return }
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
