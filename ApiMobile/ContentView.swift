//
//  ContentView.swift
//  ApiMobile
//
//  Created by STICH, AIDEN S. on 4/15/24.
//

import SwiftUI

//indivisual User from the json
struct User: Codable {
    public var login: String
    public var url: String
    public var avatar_url:String
    public var html_url: String
}
// the items array from the JSON
struct Result: Codable {
    var items:[User]
}

struct ContentView: View {
    @State var users:[User] = []
    @State var searchText = ""
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            NavigationStack{
                if users.count == 0 && !searchText.isEmpty{
                    //display a progress spinning wheel if no data has been pulled yet
                    VStack{
                        ProgressView().padding()
                        Text("Fetching Users...")
                            .foregroundStyle(Color.purple)
                            .onAppear{
                                getApiData()
                            }
                    }
                } else {
                    // bind the list to the User array
                    List(users, id:\.login) {user in
                        // links to their github profile using Safari
                        Link(destination:URL(string:user.html_url)!){
                            
                            
                            // diplay the image
                            HStack(alignment:.top){
                                AsyncImage(url:URL(string: user.avatar_url)){ response in
                                    switch response {
                                    case .success(let image):
                                        image.resizable()
                                            .frame(width:50, height: 50)
                                    default:
                                        Image(systemName:"nosign")
                                    }
                                }
                            }
                            
                            // display the user info
                            VStack(alignment: .leading){
                                Text(user.login)
                                Text("\(user.url)")
                                    .font(.system(size:11))
                                    .foregroundColor(Color.gray)
                            }
                        }
                    }
                }
            }.searchable(text: $searchText).onSubmit(of: .search){
                getApiData()
            }
        }
        .padding()
    }
    
    func getApiData(){
        if let apiURL = URL(string:"https://api.github.com/search/users?q="+searchText){
            var request = URLRequest(url:apiURL)
            request.httpMethod = "GET"
            URLSession.shared.dataTask(with: request){
                data, response,error in
                if let userData = data {
                    if let usersFromAPI = try? JSONDecoder().decode(Result.self, from: userData){
                        users = usersFromAPI.items
                        print(users)
                    }
                }
            }.resume()
        }
    }
}




#Preview {
    ContentView()
}
