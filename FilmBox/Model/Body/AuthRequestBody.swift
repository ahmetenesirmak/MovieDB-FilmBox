//
//  AuthRequestBody.swift
//  FilmBox
//
//  Created by Ahmet Enes Irmak on 8.01.2022.
//

import Foundation

struct AuthRequestBody: Codable {
    let username, password, request_token : String?
}
