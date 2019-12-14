//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Edgar Vilchis on 08/12/19.
//  Copyright © 2019 Edgar Vilchis. All rights reserved.
//

import Foundation

/*
 Earlier you saw the message
 “Instance method 'decode(_:from:)' requires that 'T' conform to 'Decodable’”,
 and you might have wondered what Decodable was – after all, we’ve been using
 Codable everywhere. Well, behind the scenes, Codable is just an alias for two
 separate protocols: Encodable and Decodable. You can use Codable if you want,
 or you can use Encodable and Decodable if you prefer being
 specific – it’s down to you.
 */

extension Bundle {
    //func decode(_ file: String) -> [Astronauts] {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        
        /*
         Swift’s JSONDecoder type has a property called dateDecodingStrategy,
         which determines how it should decode dates. We can provide that with
         a DateFormatter instance that describes how our dates are formatted.
         In this instance, our dates are written as year-month-day, but things
         are rarely so simple in the world of dates: is the first month written
         as “1”, “01”, “Jan”, or “January”? Are the years “1968” or “68”?

         We already used the dateStyle and timeStyle properties of DateFormatter
         for using one of the built-in styles, but here we’re going to use its
         dateFormat property to specify a precise format: “y-MM-dd”. That’s Swift’s
         way of saying “a year, then a dash, then a zero-padded month, then a dash,
         then a zero-padded day”, with “zero-padded” meaning that January is written
         as “01” rather than “1”.

         Warning: Date formats are case sensitive! mm means “zero-padded minute”
         and MM means “zero-padded month.”
         */
        
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        //That tells the decoder to parse dates in the exact format we expect.

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}

//*****************************************************************************

/*
 Generics allow us to write code that is capable of working with a
 variety of different types. In this project, we wrote the Bundle extension
 to work with arrays of astronauts, but really we want to be able to handle
 arrays of astronauts, arrays of missions, or potentially lots of other things.

 To make a method generic, we give it a placeholder for certain types.
 This is written in angle brackets (< and >) after the method name
 but before its parameters
 */

//*****************************************************************************

/*
 We can use anything for that placeholder – we could have written “Type”,
 “TypeOfThing”, or even “Fish”; it doesn’t matter. “T” is a bit of a convention
 in coding, as a short-hand placeholder for “type”.

 Inside the method, we can now use “T” everywhere we would use [Astronaut] – it is
 literally a placeholder for the type we want to work with.
 */

//*****************************************************************************

/*
 Be very careful: There is a big difference between T and [T]. Remember, T is a
 placeholder for whatever type we ask for, so if we say “decode an array of astronauts,”
 then T becomes [Astronaut]. If we attempt to return [T] from decode() then we would
 actually be returning [[Astronaut]] – an array of arrays of astronauts!
 */

//*****************************************************************************

/*
 So, what we’ve said is that decode() will be used with some sort of type,
 such as [Astronaut], and it should attempt to decode the file it has
 loaded to be that type.

 If you try compiling this code, you’ll see an error in Xcode: “Instance
 method 'decode(_:from:)' requires that 'T' conform to 'Decodable’”. What
 it means is that T could be anything: it could be an array of astronauts,
 or it could be an array of something else entirely. The problem is that Swift
 can’t be sure the type we’re working with conforms to the Codable protocol,
 so rather than take a risk it’s refusing to build our code.

 Fortunately we can fix this with a constraint: we can tell Swift that T can
 be whatever we want, as long as that thing conforms to Codable. That way Swift
 knows it’s safe to use, and will make sure we don’t try to use the method with
 a type that doesn’t conform to Codable.
 */

//*****************************************************************************

/*
 If you try compiling again, you’ll see that things still aren’t working,
 but now it’s for a different reason: “Generic parameter 'T' could not be inferred”,
 over in the astronauts property of ContentView. This line worked fine before,
 but there has been an important change now: before decode() would always return
 an array of astronauts, but now it returns anything we want as long as it conforms
 to Codable.

 We know it will still return an array of astronauts because the actual underlying
 data hasn’t changed, but Swift doesn’t know that. Our problem is that decode()
 can return any type that conforms to Codable, but Swift needs more information – it wants
 to know exactly what type it will be.
 */
