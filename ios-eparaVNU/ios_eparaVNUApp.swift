//
//  ios_eparaVNUApp.swift
//  ios-eparaVNU
//
//  Created by Matthew Sakhnenko on 09.04.2022.
//

import SwiftUI

let isDebug = false

@main
struct ios_eparaVNUApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: HomeViewModel())
        }
    }
    
    init() {
        configureSupportViews()
    }
    
    private func configureSupportViews() {
        // List
//        UITableView.appearance().backgroundColor = .clear
    }
    
}
