//
//  VacationInvegasApp.swift
//  VacationInvegas
//
//  Created by Swapnil Chatterjee on 25/06/24.
//

import SwiftUI

@main
struct VacationInvegasApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for:Place.self)
    }
}
