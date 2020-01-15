//
//  ContentView.swift
//  Habits
//
//  Created by Edgar Vilchis on 14/01/20.
//  Copyright © 2020 Edgar Vilchis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var habits = HabitClass()
    @State private var showingSheet = false
    
    let rowHeight: CGFloat = 80
    let verticalPaddingSize: CGFloat = 10
   
    var body: some View {
        NavigationView {
            List(habits.items) { habit in
                GeometryReader { geo in
                    VStack {
                        NavigationLink(destination: DetailView(habits: self.habits, habit: habit)) {
                            EmptyView()
                        }
                        .layoutPriority(1)
                        
                        ZStack {
                        RowBackground(width: geo.size.width, height: self.rowHeight - (2 * self.verticalPaddingSize))
        
                            Text(habit.name)
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        .layoutPriority(1)
                    }
                    .frame(width: geo.size.width, height: self.rowHeight)
                    .clipped()
                    .padding(.vertical, self.verticalPaddingSize)
                    .padding(.horizontal)
                }
            }
            .environment(\.defaultMinListRowHeight, self.rowHeight)
            .navigationBarTitle("Habits")
            .navigationBarItems(trailing:
                Button("Add"){
                    self.showingSheet = true
                }
            )
            .sheet(isPresented: $showingSheet) {
                HabitView(habits: self.habits)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
