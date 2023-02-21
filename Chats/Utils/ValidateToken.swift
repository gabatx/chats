//
//  ValidateToken.swift
//  Chats
//
//  Created by gabatx on 18/2/23.
//

import Foundation

class ValidateToken {

    func validateToken(idToken: String) {
            // Comprobamos si el token del usuario principal es correcto
            // Seleccionamos el usuario principal de la base de datos con el userFrontId
            let userFront = UserDefault.users.first(where: { $0.id == UserDefault.userFrontId })!
            if idToken == userFront.tokenID {
                print("Token correcto") 
            } else {
                // Cambiamos el token del usuario principal en la base de datos.
                // Para ello buscamos el usuario principal en la base de datos y le cambiamos el token.
                let indexUsers = UserDefault.users.firstIndex(where: { $0.id == UserDefault.userFrontId.hashValue })!
                UserDefault.users[indexUsers].tokenID = idToken
                print("Cambiado el token del usuario principal")
            }
        }

}
