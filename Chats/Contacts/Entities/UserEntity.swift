//
//  UserEntity.swift
//  Chats
//
//  Created by gabatx on 13/2/23.
//

import Foundation

struct User: Codable {
    var id: Int
    var tokenID: String
    var username: String
    var name: String
    var surname: String
    var password: String
    var email: String
    var registrationDate: Date
    var lastLoginDate: Date
}



