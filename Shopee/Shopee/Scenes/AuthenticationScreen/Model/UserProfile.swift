//
//  UserProfile.swift
//  Shopee
//
//  Created by Berksu Kısmet on 28.10.2022.
//

import Foundation

struct UserProfile: Codable{
    let id: String
    var username: String?
    var email: String?
    var profilePicture: String? = ""
}
