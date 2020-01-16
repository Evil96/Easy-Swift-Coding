//
//  ContentView.swift
//  Cupcake Corner
//
//  Created by Edgar Vilchis on 15/01/20.
//  Copyright © 2020 Edgar Vilchis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var username = ""
    @State private var email = ""
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }

            Section {
                Button("Create account") {
                    print("Creating account…")
                }
            }//.disabled(username.isEmpty || email.isEmpty)
            .disabled(disableForm)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//***************************************************************************
//***************************************************************************
//Project 10

//Adding Codable conformance for @Published properties
/*
class User: ObservableObject, Codable{
    @Published var name = "Edgar"
    
    enum CodingKeys: CodingKey{
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}
 */

//***************************************************************************
//Sending and receiving Codable Data with URLSession and SwiftUI

/*
struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}
 */


//    @State private var results = [Result]()

/*       List(results, id: \.trackId) { item in
           VStack(alignment: .leading) {
               Text(item.trackName)
                   .font(.headline)
               Text(item.collectionName)
           }
       }.onAppear(perform: loadData)
   }
   
   func loadData() {
       guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
           print("Invalid URL")
           return
       }
       let request = URLRequest(url: url)
       
       URLSession.shared.dataTask(with: request) { data, response, error in
           // step 4
           if let data = data {
               if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                   // we have good data – go back to the main thread
                   DispatchQueue.main.async {
                       // update our UI
                       self.results = decodedResponse.results
                   }

                   // everything is good, so we can exit
                   return
               }
           }

           // if we're still here it means there was a problem
           print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
       }.resume()

*/
