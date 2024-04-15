//
//  ContentView.swift
//  ApiMobile
//
//  Created by STICH, AIDEN S. on 4/15/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
    
    
    
    func getApi(){
         if let apiURL = URL(string:"https://api.github.com/search/users?q=greg"){
             var request = URLRequest(url:apiURL)
             request.httpMethod = "GET"
             URLSession.shared.dataTask(with: request){
                 data, response,error in
                 if let apiData = data {
                     if let usersFromAPI = try? JSONDecoder().decode(Result.self, from: apiData){
                         data = usersFromAPI.items
                         print(data)
                     }
                 }
             }.resume()
         }
     }
    
}



#Preview {
    ContentView()
}
