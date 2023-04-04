//
//  TextView.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 23.03.23.
//

import SwiftUI

struct TextView: View {
    @ObservedObject var viewModel = ViewModel()
    var body: some View {
        VStack{
            HStack(alignment: .top){
                VStack(alignment: .leading){
                    Text(viewModel.dayText)
                    Text(viewModel.weatherdesc)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(viewModel.cityT)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            Text(viewModel.temp)
                .frame(maxHeight: .infinity, alignment: .center)
            
            HStack{
                VStack(alignment: .leading){
                    Text(viewModel.humidity)
                    Text(viewModel.windSpeed)
                    Text(viewModel.windDirection)
                }
                .frame(maxWidth:.infinity, alignment: .trailing)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            
        }
        .padding()
        .foregroundColor(Color(weather: .sun))
        .onAppear {
            Task {
                await viewModel.executeSearch(city: "Hamburg")
            }
        }
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView()
    }
}
