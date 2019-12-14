//
//  AstronautView.swift
//  Moonshot
//
//  Created by Edgar Vilchis on 12/12/19.
//  Copyright © 2019 Edgar Vilchis. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    
    let astronaut: Astronaut
    
    var body: some View {
        
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)

                    Text(self.astronaut.description)
                        .padding()
                    .layoutPriority(1)
                    /*
                     
                     The bug is this: if you select certain astronauts, such as Edward H. White
                     II from Apollo 1, you might see their description text gets clipped at the
                     bottom. So, rather than seeing all the text, you instead see just some, followed
                     by an ellipsis where the rest should be. And if you look closely at the top of the
                     image, you’ll notice it’s no longer sitting directly against the navigation bar
                     at the top.

                     What we’re seeing is SwiftUI’s layout algorithm having a hard time coming to the right
                     conclusion about our content. In my view this is a SwiftUI bug, and it’s possible that
                     by the time you try this yourself it won’t even exist. But it exists right here, so I’m
                     going to show you how we can fix it by using the layoutPriority() modifier.

                     Layout priority lets us control how readily a view shrinks when space is limited, or
                     expands when space is plentiful. All views have a layout priority of 0 by default, which
                     means they each get equal chance to grow or shrink. We’re going to give our astronaut
                     description a layout priority of 1, which is higher than the image’s 0, which means it
                     will automatically take up all available space.
                     
                     */
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
        
    }
}

//After adding the astronaut property, we still need to update the preview so that it creates its view with some data
//It is the same as for MissionView.swift file
struct AstronautView_Previews: PreviewProvider {
    
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
