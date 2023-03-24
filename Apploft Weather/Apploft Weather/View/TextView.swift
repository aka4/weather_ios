//
//  TextView.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 23.03.23.
//

import SwiftUI

struct TextView: View {
    let viewModel = ViewModel()
    var body: some View {
        VStack{
            HStack(alignment: .top){
                VStack(alignment: .leading){
                    Text(viewModel.day)
                    Text(viewModel.weatherdesc)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(viewModel.city)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            
            Text(viewModel.tempText)
                .frame(maxHeight: .infinity, alignment: .center)
            
            HStack{
                VStack(alignment: .leading){
                    Text(viewModel.humidText)
                    Text(viewModel.windSpText)
                    Text(viewModel.windDText)
                }
                .frame(maxWidth:.infinity, alignment: .trailing)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            
        }
        //.frame(maxHeight: .infinity)
        .padding(.all)
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView()
    }
}
