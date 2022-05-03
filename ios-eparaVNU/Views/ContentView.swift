//
//  ContentView.swift
//  ios-eparaVNU
//
//  Created by Matthew Sakhnenko on 09.04.2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = HomeViewViewModel()
    
    var body: some View {
        Button() {
            async {
               try? await loadData()
             }
        } label: {
            Label("Fetch Data", systemImage: "scribble")
        }

    }
    
    func loadData() async {
        await viewModel.fetch()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
