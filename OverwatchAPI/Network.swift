//
//  Network.swift
//  OverwatchAPI
//
//  Created by Sebin Kwon on 11/15/23.
//

import SwiftUI

class Network: ObservableObject {
    static let shared = Network()
    private init() {}

    
    func getPlayer(playerId: String, completion: @escaping (Player) -> Void) {
        
        guard let url = URL(string: playerId.isHangul ? "https://overfast-api.tekrop.fr/players/\(playerId.encodeUrl()!)/summary" : "https://overfast-api.tekrop.fr/players/\(playerId)/summary") else { fatalError("Missing URL") }
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("No HTTPURLResponse or status code is not 200")
                return
            }
            
            guard let data = data else {
                print("No data")
                return
            }
            
            do {
                let decodedPlayer = try JSONDecoder().decode(Player.self, from: data)
                completion(decodedPlayer)
            } catch let error {
                print("Error decoding: ", error)
            }
        }.resume()
    }
    
    func getPlayerStats(playerId: String, completion: @escaping (Stats) -> Void) {
        
        guard let url = URL(string: playerId.isHangul ? "https://overfast-api.tekrop.fr/players/\(playerId.encodeUrl()!)/stats/summary" : "https://overfast-api.tekrop.fr/players/\(playerId)/stats/summary") else { fatalError("Missing URL") }
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("No HTTPURLResponse or status code is not 200")
                return
            }
            
            guard let data = data else {
                print("No data")
                return
            }
            
            do {
                let decodedStats = try JSONDecoder().decode(Stats.self, from: data)
                completion(decodedStats)
            } catch let error {
                print("Error decoding: ", error)
            }
        }.resume()
    }
}
