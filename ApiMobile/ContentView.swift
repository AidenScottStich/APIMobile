//
//  ContentView.swift
//  ApiMobile
//
//  Created by STICH, AIDEN S. on 4/15/24.
//

import SwiftUI
import Foundation
//indivisual User from the json
struct User: Codable {
    public var username: String
    public var id: String
    public var avatar:String
    
}
struct PlayerResponse: Codable {
    let code: String
    let message: String
    let data: PlayerData
    let success: Bool
}

struct PlayerData: Codable {
    let player: Player
}

struct Player: Codable {
    let username: String
    let id: String
    let raw_id: String
    let avatar: String
    let skin_texture: String
    let name_history: [String]
}



// the items array from the JSON
struct Result: Codable {
    var items:User
}

struct ContentView: View {
    @State var username = ""
    @State var id = ""
    @State var avatar = ""
    @State var searchText = ""
    var body: some View {
        VStack {
            Text("test")
            Button(action: {
                fetchPlayerData()
                print("button is clicked")
            }, label: {
                Text("Button")
            })
            
            if(username != ""){
                Text(username)
            }else{
                Text("not working")
            }
            
        }
        .padding()
    }
    func fetchPlayerData() {
        if let url = URL(string: "https://playerdb.co/api/player/minecraft/jeff") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let jsonData = data {
                    do {
                        let decoder = JSONDecoder()
                        let playerResponse = try decoder.decode(PlayerResponse.self, from: jsonData)
                        // Now you have access to playerResponse and its properties
                        print(playerResponse.data.player.username)
                        // You can access other properties similarly
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }.resume()
        }
    }

    
    
}




#Preview {
    ContentView()
}
