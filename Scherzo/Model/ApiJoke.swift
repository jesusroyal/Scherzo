//
//  JokeModel.swift
//  Scherzo
//
//  Created by Mike Shevelinsky on 06.01.2021.
//

import Foundation

struct ApiJoke: Codable {
    let id: Int
    let type: String
    let setup: String
    let punchline: String
}
