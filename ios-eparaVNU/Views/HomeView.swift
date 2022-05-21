//
//  HomeView.swift
//  ios-eparaVNU
//
//  Created by Matthew Sakhnenko on 17.05.2022.
//

import SwiftUI
import Introspect

enum MatchedGeometryKeys: String {
    case dateView
    case splash
    
    var string: String {
        return self.rawValue.uppercased()
    }
}

struct HomeView: View {
    @State private var animatedState: [Bool] = Array(repeating: false, count: 3)
    @State private var currentDate: Date
    @State private var currentMonthOffset: Int = 0
    
    @Namespace var animation
    @ObservedObject var viewModel: HomeViewModel
    
    init(date: Date, viewModel: HomeViewModel) {
        _currentDate = State(wrappedValue: date)
        _viewModel = ObservedObject(initialValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // If we hide the view while its transitioning it will give some opacity change in the view
                if !animatedState[1] {
                    RoundedRectangle(cornerRadius: animatedState[0] ? 30 : 0, style: .continuous)
                        .fill(.accentRed)
                        .matchedGeometryEffect(id: MatchedGeometryKeys.dateView.string, in: animation)
                        .ignoresSafeArea()
                    
                // MARK: Splash Logo -- Todo
                    
//                    Image(systemName: "calendar")
//                        .scaleEffect(animatedState[0] ? 0.25 : 1)
//                        .matchedGeometryEffect(id: MatchedGeometryKeys.splash.string, in: animation)
                        
                }
                
                if animatedState[0] {
                    
                    // MARK: HomeView
                    
                    VStack(spacing: 0) {
                        if #available(iOS 15.0, *) {
                            CustomDatePicker(currentDate: $currentDate.onChange({
                                viewModel.didChangeSelectedDate(date: currentDate, monthOffset: currentMonthOffset)
                            }), currentMonth: $currentMonthOffset)
//                                .overlay(alignment: .topLeading) {
//                                    Image(systemName: "calendar")
//                                        .foregroundColor(.white)
//                                        .scaleEffect(1)
//                                        .matchedGeometryEffect(id: MatchedGeometryKeys.splash.string, in: animation)
//                                        .offset(x: -10, y: -25)
//                                }
                                .background(
                                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                                        .fill(.accentRed)
                                        .matchedGeometryEffect(id: MatchedGeometryKeys.dateView.string, in: animation)
                                )
                        } else {
                            CustomDatePicker(currentDate: $currentDate, currentMonth: $currentMonthOffset)
                                .background(
                                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                                        .fill(.accentRed)
                                        .matchedGeometryEffect(id: MatchedGeometryKeys.dateView.string, in: animation)
                                )
                        }
                        
                        Spacer(minLength: 24)
                        
                        // MARK: ClassesListView
    
                        List {
                            ForEach(viewModel.currenltyDisplayedLessons) { lesson in
                                ClassCellView(lesson: lesson)
                            }
                        }
                        .listStyle(.insetGrouped)
                        .cornerRadius(30)
                        .introspectTableView {
                            $0.showsVerticalScrollIndicator = false
                        }
                        
                    }
                    .padding([.horizontal, .top])
                    .frame(maxHeight: .infinity, alignment: .top)
                }
            }
            .navigationTitle("єПара")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("To be done...")
                    } label: {
                        Image(systemName: "gear")
                            .foregroundColor(.black)
                    }
                }
            })
            .onAppear {
                startAnimations()
                print(viewModel.currentSelectedDate)
            }
            .task {
                await viewModel.fetchSchedule(with: "8573", stardDate: "21.05.2022", endDate: "28.05.2022")
            }
        }
    }
    
    // MARK: Animating View
    
    private func startAnimations() {
        // MARK: Displaying Splash Icon for Some Time
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.7, blendDuration: 0.7)) {
                animatedState[0] = true
            }
        }
        
        // Removing View after the view is animated
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            animatedState[1] = true
        }
        
    }
    
}
