//
//  MissionView.swift
//  Moonshot
//
//  Created by Edgar Vilchis on 12/12/19.
//  Copyright © 2019 Edgar Vilchis. All rights reserved.
//

import SwiftUI

/*
 In terms of layout, this thing needs to have a scrolling VStack with
 a resizable image for the mission badge, then a text view, then a spacer
 so that everything gets pushed to the top of the screen. We’ll use GeometryReader
 to set the maximum width of the mission image
 */
struct MissionView: View {
    //Nested struct
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let astronauts: [CrewMember]
    
    var body: some View {
        GeometryReader { geometry in
                   ScrollView(.vertical) {
                       VStack {
                           Image(self.mission.image)
                               .resizable()
                               .scaledToFit()
                               .frame(maxWidth: geometry.size.width * 0.7)
                               .padding(.top)

                           Text(self.mission.description)
                               .padding()
                        
                        ForEach(self.astronauts, id: \.role) { crewMember in
                            //Adding the next NavigationLink was one of the last steps to build this app
                            //Presenting the AstronautView.Swift file with a new navigationLink
                            NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(Color.primary, lineWidth: 1))

                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }

                                Spacer()
                            }.padding(.horizontal)
                            }.buttonStyle(PlainButtonStyle())
                            /*
                             The first bug is pretty glaring: in the mission view, all our astronaut
                             pictures are shown as solid blue capsules rather than their pictures.
                             You might also notice that each person’s name is written in the same shade
                             of blue, which might give you a clue what’s going on – now that this is a
                             navigation link, SwiftUI is making the whole thing look active by coloring
                             our views blue.

                             To fix this we need to ask SwiftUI to render the contents of the navigation
                             link as a plain button, which means it won’t apply coloring to the image or
                             text.
                             */
                        }

                           Spacer(minLength: 25)
                       }
                   }//.padding(.all)
               }
               .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission

        var matches = [CrewMember]()

        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }

        self.astronauts = matches
    }
    
}

//that thing needs a Mission object passed in so it has something to render.
struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}
