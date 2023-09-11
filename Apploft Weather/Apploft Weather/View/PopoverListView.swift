//
//  PopoverListView.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 31.08.23.
//

import SwiftUI

struct PopoverListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.creationDate, order: .reverse)]) var citiesData: FetchedResults<City>
    
    var body: some View {
        VStack(spacing: 3) {
            NavigationStack{
                List{
                    ForEach(citiesData) { city in
                        Text(city.name ?? "Unknown")
                    }
                }
            }
            Button("Add") {
                let cityNames = ["Hamburg", "Berlin", "New York", "Tokyo", "Istanbul"]
                let chosenCityName = cityNames.randomElement()!
                let citay = City(context: moc)
                citay.id = UUID()
                citay.name = "\(chosenCityName)"
                citay.creationDate = Date()
                try? moc.save()
            }
        }
        .presentationCompactAdaptation(.none)
    }

}

struct PopoverListView_Previews: PreviewProvider {
    static var previews: some View {
        PopoverListView()
    }
}
