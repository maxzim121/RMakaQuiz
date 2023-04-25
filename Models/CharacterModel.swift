//
//  JSONModel.swift
//  RMakaQuiz
//
//  Created by Maksim Zimens on 25.04.2023.
//

import Foundation

struct CharacterModel: Codable {
    var gender: String
    var id: Int
    var image: String
    var name: String
    var species: String
    var status: String
}
