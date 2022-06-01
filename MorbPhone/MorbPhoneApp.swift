//
//  MorbPhoneApp.swift
//  MorbPhone
//
//  Created by Daniel Spalek on 31/05/2022.
//

import SwiftUI

@main
struct MorbPhoneApp: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(ViewModel())
        }
    }
}
