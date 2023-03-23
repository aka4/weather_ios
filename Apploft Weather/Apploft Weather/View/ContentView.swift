//
//  ContentView.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 20.03.23.
//

import SwiftUI

struct ContentView: View {
    let viewModel = ViewModel()
    
    var body: some View {
        
        Text(viewModel.text)
            
            
    }
}

extension Color {
    enum WeatherColors: String{
        case thunder = "thunderColor"
        case clouds = "cloudyColor"
        case sun = "sunnyColor"
    }
    
    static func getWeatherColor(name: WeatherColors) -> Color {
        return Color(name.rawValue)
    }
}


extension ContentView {
    struct ViewModel {
        let text: AttributedString
        
        init() {
            text = AttributedString("Hey World", attributes: .init()
                .foregroundColor(Color.getWeatherColor(name: .thunder))
                .font(.system(size: 30))
            )
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
