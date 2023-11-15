//
//  Player.swift
//  OverwatchAPI
//
//  Created by Sebin Kwon on 11/15/23.
//

import Foundation

// MARK: - Player
struct Player: Codable {
    let username: String
    let avatar, namecard: String
    let title: String?
    let endorsement: Endorsement
    let competitive: Competitive?
    let privacy: String
}

// MARK: - Competitive
struct Competitive: Codable {
    let pc, console: Console?
}

// MARK: - Console
struct Console: Codable {
    let season: Int
    let tank, damage, support: Damage?
}

// MARK: - Damage
struct Damage: Codable {
    let division: String
    let tier: Int
    let roleIcon: String
    let rankIcon: String

    enum CodingKeys: String, CodingKey {
        case division, tier
        case roleIcon = "role_icon"
        case rankIcon = "rank_icon"
    }
}

// MARK: - Endorsement
struct Endorsement: Codable {
    let level: Int
    let frame: String
}


struct Players: Codable {
    var results: [Player]
}
