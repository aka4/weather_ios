//
//  TestView.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 27.04.23.
//

import SwiftUI

struct TestView: View {
    @State private var field1Color = Color.gray
    @State private var field2Color = Color.gray
    @State private var buttonColor = Color.blue
    @State private var buttonText = "Start"
    
    @State private var fieldTappable = false
    @State private var buttonTap = true
    
    @State private var field1Tapped = false
    @State private var field2Tapped = false
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(field1Color)
                .onTapGesture {
                    if fieldTappable {
                        player1Tapped()
                    }
                }
            ZStack {
                Rectangle()
                    .frame(height: 50)
                    .foregroundColor(buttonColor)

                Text(buttonText)
                    .foregroundColor(.white)
            }
            .onTapGesture {
                Task {
                    await changeStateOnStart()
                }
            }
            
            Rectangle()
                .foregroundColor(field2Color)
                .onTapGesture {
                    if fieldTappable {
                        player2Tapped()
                    }
                }

        }
        .padding()
    }
}

extension TestView {
    func changeStateOnStart() async {
        if buttonTap {
            field1Color = .black
            field2Color = .black
            buttonColor = .yellow
            buttonTap = false
            buttonText = "Warten"
            await startTimer()
        }
    }
    
    func changeStateAfterTime() {
        field1Color = .blue
        field2Color = .blue
        buttonColor = .green
        buttonText = "Go!!!"
        fieldTappable = true
    }
    
    func startTimer() async {
        let randInt = UInt64.random(in: 1_000_000_000 ... 5_000_000_000)
        print(randInt)
        try? await Task.sleep(nanoseconds: randInt)
        changeStateAfterTime()
    }
    
    func player1Tapped() {
        fieldTappable = false
        buttonTap = true
        field1Color = .green
        field2Color = .red
        buttonColor = .blue
        buttonText = "Start"
    }
    
    func player2Tapped() {
        fieldTappable = false
        buttonTap = true
        field1Color = .red
        field2Color = .green
        buttonColor = .blue
        buttonText = "Start"
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
