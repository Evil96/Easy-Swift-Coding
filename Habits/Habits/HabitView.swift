//
//  HabitView.swift
//  Habits
//
//  Created by Edgar Vilchis on 14/01/20.
//  Copyright © 2020 Edgar Vilchis. All rights reserved.
//

import SwiftUI

struct HabitView: View {
    
    @State private var habitName = ""
    @State private var selectedType = "Weekly"
    @State private var showingAlert = false
    
    static let habitTypes: [String] = ["Daily", "Weekly", "Monthly"]
    
    @ObservedObject var habits: HabitClass
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Enter name", text: self.$habitName)
                }
                
                Section(header: Text("Frequency")) {
                    Picker("Habit Type", selection: $selectedType) {
                        ForEach(Self.habitTypes, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }

            }
            .navigationBarTitle("Create habit")
            .navigationBarItems(trailing: Button("Add") {
                if self.habitName.isEmpty {
                    self.showingAlert.toggle()
                } else {
                    self.habits.items.append(Habit(name: self.habitName, type: self.selectedType, amount: 0))
                    self.presentationMode.wrappedValue.dismiss()
                }
            })
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("No name"), message: Text("Please add a name in order to create a new habit."))
        }
    }
}
