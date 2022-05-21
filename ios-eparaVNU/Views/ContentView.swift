//
//  ContentView.swift
//  ios-eparaVNU
//
//  Created by Matthew Sakhnenko on 09.04.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        HomeView(date: viewModel.currentSelectedDate, viewModel: viewModel)
    }
    
    // MARK: Actions
    
    func loadDepartaments() async {
        await viewModel.fetchDepartaments()
    }
    
    func loadGroup() async {
        await viewModel.fetchSchedule(with: "8573", stardDate: "7.05.2022", endDate: "12.05.2022")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: HomeViewModel())
    }
}
