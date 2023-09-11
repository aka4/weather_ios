//
//  DataController.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 05.09.23.
//

import CoreData
import Foundation


class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "CityList")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
}
