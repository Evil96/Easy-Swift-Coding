//
//  Mission.swift
//  Moonshot
//
//  Created by Edgar Vilchis on 08/12/19.
//  Copyright © 2019 Edgar Vilchis. All rights reserved.
//

import Foundation

/*
 our CrewRole struct was made specifically to
 hold data about missions, and as a result we
 can actually put the CrewRole struct inside
 the Mission struct
 */

//This is called a nested struct
struct Mission: Codable, Identifiable {
    
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    //let launchDate: String?
    /*
     Now that our decoding code understands
     how our dates are formatted (See Bundle-Decodable.swift), we can change
     that property to be an optional Date
     */
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    /*
     we’re going to add some computed properties to the Mission struct
     to send that same data back. The result will be the same – “apollo1”
     and “Apollo 1” – but now the code is in one place: our Mission struct (here).
     This means any other views can use the same data without having to repeat
     our string interpolation code, which in turn means if we change the way
     these things are formatted – i.e., we change the image names to “apollo-1”
     or something – then we can just change the property in Mission and have
     all our code update.
     */
    var displayName: String {
        "Apollo \(id)"
    }

    var image: String {
        "apollo\(id)"
    }
    
    
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
}


