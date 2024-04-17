//
//  ContentView.swift
//  ApiMobile
//
//  Created by STICH, AIDEN S. and SUN, JOHNNY on 4/15/24.
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
    //These are all the var for out content view
    @State private var name: String = "Tim"
    @State var username = ""
    @State var id = ""
    @State var avatar = ""
    @State var searchText = ""
    
    //What the user is going to see
    var body: some View {
        VStack {
            //Some instructions for the user
            Text("Look up your Minecraft account")
            //This is our text field that will be used by the user to look up their minecraft account
            TextField("Enter your name", text: $searchText).textFieldStyle(.roundedBorder)

            //This is our submit button that will call our api func
            Button(action: {
                fetchPlayerData()
                print("button is clicked") // This is a console print to make sure that it is clicked
            }, label: {
                Text("Button")
            })
            
            if(username != ""){
                //These are text that will display the data if the username has something in it
                Text("Account Username: " + username)
                Text("Link of profile pic: " + avatar)
            }else{
                Text("not working") // This will display if there is nothing in the username var
            }
            
        }
        .padding()
    }
    
    //This is our api function
    func fetchPlayerData() {
        if let url = URL(string: "https://playerdb.co/api/player/minecraft/" + searchText) { // This uses the api link and the searchText textfield to look up the api
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let jsonData = data {
                    do {
                        let decoder = JSONDecoder()
                        let playerResponse = try decoder.decode(PlayerResponse.self, from: jsonData)
                        // Now you have access to playerResponse and its properties
                        
                        //Then we print them to the console to make sure we got the data
                        print(playerResponse.data.player.username)
                        print(playerResponse.data.player.avatar)
                        
                        
                        // We then assgin the values to the states above
                        username = playerResponse.data.player.username
                        avatar = playerResponse.data.player.avatar
                        
                        
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }.resume()
        }
    }

    
    
}

//This will display our content in the preview
#Preview {
    ContentView()
}
