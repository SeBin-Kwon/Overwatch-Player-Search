//
//  MainViewModel.swift
//  OverwatchAPI
//
//  Created by Sebin Kwon on 11/16/23.
//

import SwiftUI

class MainViewModel: ObservableObject {
    @Published var player: Player?
    @Published var isPublic = true
    @Published var stats: Stats?
    
    private var network: Network
    init(network: Network = Network.shared) {
            self.network = network
        }
    func fetchPlayer(playerId: String) {
        let replaceStr = playerId.replacingOccurrences(of: "#", with: "-")
           self.network.getPlayer(playerId: replaceStr) { decodedPlayer in
               DispatchQueue.main.async {
                   self.player = decodedPlayer
                   self.isPublic = decodedPlayer.privacy == "public"
               }
           }
       }
    
    func fetchPlayerStats(playerId: String) {
        let replaceStr = playerId.replacingOccurrences(of: "#", with: "-")
        self.network.getPlayerStats(playerId: replaceStr) { decodedStats in
            DispatchQueue.main.async {
                self.stats = decodedStats
            }
        }
    }
}
