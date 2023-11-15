//
//  Network.swift
//  OverwatchAPI
//
//  Created by Sebin Kwon on 11/15/23.
//

import SwiftUI

class Network: ObservableObject {
    @Published var player: Player?
    
    func getPlayer(playerId: String) {

        guard let url = URL(string: playerId.isHangul ? "https://overfast-api.tekrop.fr/players/\(playerId.encodeUrl()!)/summary" : "https://overfast-api.tekrop.fr/players/\(playerId)/summary") else { fatalError("Missing URL") }
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error {
                print("Request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("No HTTPURLResponse")
                return
            }
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedPlayer = try JSONDecoder().decode(Player.self, from: data)
                        self.player = decodedPlayer
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
            
        }.resume()
    }
}
