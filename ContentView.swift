//
//  ContentView.swift
//  Moonshot
//
//  Created by Edgar Vilchis on 06/12/19.
//  Copyright © 2019 Edgar Vilchis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    //Before giving our definition of the generic <T>:
    //let astronauts = Bundle.main.decode("astronauts.json")
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                //NavigationLink(destination: Text("Detail view")) {
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        //.aspectRatio(contentMode: .fit)
                        .scaledToFit()
                        .frame(width: 44, height: 44)

                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        //Text(mission.launchDate ?? "N/A")
                        /*
                         The only small complexity in there is that our
                         launch date is an optional string, so we need to
                         use nil coalescing (??) to make sure there’s a value
                         for the text view to display.
                         */
                        Text(mission.formattedLaunchDate)
                        //formattedLaunchDate method found on Mission.swift file
                        /*
                         Text(mission.launchDate ?? "N/A")
                         That attempts to use an optional Date inside a text view,
                         or replace it with “N/A” if the date is empty.
                         This is another place where a computed property works better:
                         we can ask the mission itself to provide a formatted
                         launch date that converts the optional date into a neatly
                         formatted string or sends back “N/A” for missing dates.
                         (See Mission.swift file where formattedLaunchDate method is placed)
                         */
                        
                    }
                }
            }.padding(.all)
            .navigationBarTitle("🌑Shot")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//**************************************************************************************************************
//Rezising images to fit the screen using GeometryReader

/*
 VStack{
     GeometryReader{ geo in //Make sure our image fills the full width of its container view
     //handed by GeometryProxy object
     //Image("image").frame(width: 300, height: 300).clipped()
    //Image("image").resizable().aspectRatio(contentMode: .fill).frame(width: 300, height: 300) //We can use .fill too on contentMode
         Image("image").resizable().aspectRatio(contentMode: .fill).frame(width: geo.size.width)
     }
 }
 */

//**************************************************************************************************************
//How ScrollView lets us work with scrolling data

/*
 
 ScrollView(.vertical) {
     VStack(spacing: 10) {
         ForEach(0..<100) {
             //Text("Item \($0)").font(.title)
             CustomText("Item \($0)").font(.title)
         }
     }.frame(maxWidth: .infinity)//.infinity so we can scroll throughout all the screen
 }
 
 
 //catch: ScrollView views are created inmediately

 struct CustomText: View {
     var text: String

     var body: some View {
         Text(text)
     }

     init(_ text: String) {
         print("Creating a new CustomText")
         self.text = text
     }
 }
 */

//**************************************************************************************************************
//Pushing new views onto the stack using NavigationLink


/*
 NavigationView {
     List(0..<100){ row in
             NavigationLink(destination: Text("Detail \(row)")){ //So can change our view
                Text("Row \(row)")
             }
            .navigationBarTitle("SwiftUI")
        }
 }
 */

/*
 This is the standard iOS way of telling users another screen is going to
 slide in from the right when the row is tapped, and SwiftUI is smart enough
 to add it automatically here. If those rows weren’t navigation links – if you
 comment out the NavigationLink line and its closing brace – you’ll see the
 indicators disappear.
 */

//**************************************************************************************************************
//Working with hierarchical Codable data

/*
 Button("Decode JSON") {
     let input = """
     {
         "name": "Edgar",
         "address": {
             "street": "555, Edgar St",
             "city": "Here"
         }
     }
     """

     let data = Data(input.utf8)
     let decoder = JSONDecoder()
     if let user = try? decoder.decode(User.self, from: data) {
         print(user.address.street)
     }
 }
 
 //Structs used (outside of ContentView):
 struct User: Codable {
     var name: String
     var address: Address
 }

 struct Address: Codable {
     var street: String
     var city: String
 }
 */
