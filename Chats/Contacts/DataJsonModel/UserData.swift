//
//  UserData.swift
//  Chats
//
//  Created by gabatx on 19/2/23.
//

import Foundation

struct UserData: Codable {
    var id: Int
    var tokenID: String
    var username: String
    var name: String
    var surname: String
    var password: String
    var email: String
    var registrationDate: Int
    var lastLoginDate: Int
}
