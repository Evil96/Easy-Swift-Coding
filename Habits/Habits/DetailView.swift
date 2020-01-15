//
//  DetailView.swift
//  Habits
//
//  Created by Edgar Vilchis on 14/01/20.
//  Copyright © 2020 Edgar Vilchis. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    @ObservedObject var habits: HabitClass
    let habit: Habit
    let habitIndex: Int
    
    let animationSpeed = 1.5
    
    @State private var isAnimating = false
    @State private var rotationAmount: Double = 0
    
    init(habits: HabitClass, habit: Habit) {
        self.habits = habits
        self.habit = habit
        self.habitIndex = habits.items.firstIndex(of: habit) ?? 0
    }
        
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack {
                    //CardBackgroundView(width: geo.size.width - 40, height: geo.size.height / 3)
                    //    .padding(.top, 40)
                    
                    Text(self.habits.items[self.habitIndex].name)
                        .font(.system(size: 20.0))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                
                ZStack {
                  //  CardBackgroundView(width: geo.size.width - 40, height: geo.size.height / 3, bgColor: .orange, curveColor: .blue)
                    
                    VStack {
                        Text("Total")
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .padding(.top, 40)
                        
                        Text("\(self.habits.items[self.habitIndex].amount)")
                            .font(.system(size: 100.0, weight: .black))
                            .padding(.bottom, 40)
                    }
                    .foregroundColor(.white)
                }
                
                HStack {
                    Spacer()
                    
                    ZStack {
                        Button(self.isAnimating ? "" : "+1") {
                            self.habits.increaseAmount(of: self.habitIndex)
                            self.rotationAmount += 360
                            self.isAnimating = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                self.isAnimating = false
                                self.rotationAmount += 360
                            }
                        }
                        .frame(width: 60, height: 60)
                        .background(self.isAnimating ? Color.green : Color.blue)
                        .animation(Animation.interactiveSpring().speed(self.animationSpeed))
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .padding(20)
                        
                        Image(systemName: "checkmark")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .opacity(self.isAnimating ? 1 : 0)
                            .animation(Animation.interactiveSpring().speed(self.animationSpeed))
                    }
                    .rotationEffect(.degrees(self.rotationAmount))
                    .animation(Animation.interactiveSpring().speed(self.animationSpeed))
                }
                .padding(.bottom, 40)
            }
        }
        .navigationBarTitle("Details")
    }
}


