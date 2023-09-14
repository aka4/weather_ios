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
    @ObservedObject var viewModel: TextView.ViewModel
    
    var body: some View {
        VStack(spacing: 3) {
            NavigationStack{
                List{
                    ForEach(citiesData) { city in
                        Text(city.name ?? "Unknown")
                            .onTapGesture {
                                viewModel.searchText = city.name ?? ""
                            }
                    }
                    .onDelete(perform: removeCity)
                    .listRowBackground(Color.clear)
                }
            }
            Button("Add") {
                let cityNames = ["Hamburg", "Berlin", "New York", "Tokyo", "Istanbul"]
                let chosenCityName = cityNames.randomElement()!
                let cityTest = City(context: moc)
                cityTest.id = UUID()
                cityTest.name = "\(chosenCityName)"
                cityTest.creationDate = Date()
                try? moc.save()
            }
            Button("Remove oldest") {
                removeOldestCity()
            }
        }
        .onChange(of: viewModel.lastSuccessfulSearch) { _ in
            if citiesData.count >= 5 {
                while(citiesData.count >= 5) {
                    removeOldestCity()
                }
            }
            addCity(cityName: viewModel.lastSuccessfulSearch)
        }
        .presentationCompactAdaptation(.none)
    }

}

extension PopoverListView {
    
    func addCity(cityName: String) {
        for evCity in citiesData {
            if evCity.name == cityName {
                moc.delete(evCity)
                do {
                    try moc.save()
                } catch {
                    print("couldnt delete duplicate")
                    return
                }
            }
        }
        let newCity = City(context: moc)
        newCity.id = UUID()
        newCity.creationDate = Date()
        newCity.name = "\(cityName)"
        do {
            try moc.save()
        } catch {
            print("Couldnt save city")
            return
        }
    }
    
    func removeCity(at offsets: IndexSet) {
        for index in offsets {
            let cityDel = citiesData[index]
            moc.delete(cityDel)
        }
        do {
            try moc.save()
        } catch {
            return
        }
    }
    
    func removeOldestCity() {
        for item in citiesData {
            if citiesData.last == item {
                moc.delete(item)
            }
            do {
                try moc.save()
            } catch {
                return
            }
        }
    }
    
}

struct PopoverListView_Previews: PreviewProvider {
    static var previews: some View {
        PopoverListView(viewModel: TextView.ViewModel())
    }
}
