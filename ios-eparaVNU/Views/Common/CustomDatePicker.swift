//
//  CustomDatePicker.swift
//  ElegantTasks
//
//  Created by Matthew Sakhnenko on 17.05.2022.
//

import SwiftUI

struct CustomDatePicker: View {
    @Binding var currentDate: Date
    @Binding var currentMonth: Int
    @State var animatedStates: [Bool] = Array(repeating: false, count: 2)
    
    let days: [String] =
    ["Пн" , "Вт", "Ср", "Чт", "Пт", "Сб", "Нд"]
    
    let columns = Array(repeating: GridItem(.flexible()), count: 7)

    var body: some View {
        VStack(spacing: 35) {
            HStack(spacing: 20) {
                Button {
                    withAnimation {
                        currentMonth -= 1
                    }
                } label: {
                    Image.init(systemName: "chevron.left")
                        .font(.title2)
                }
                
                Text(extractStringDate()[0] + " " + extractStringDate()[1])
                    .font(.callout)
                    .fontWeight(.semibold)
                
                Button {
                    withAnimation {
                        currentMonth += 1
                    }
                } label: {
                    Image.init(systemName: "chevron.right")
                        .font(.title2)
                }
            }
            .foregroundColor(.white)
            .padding(.horizontal)
            
            HStack(spacing: 0) {
                ForEach(days, id: \.self) { day in
                    Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                }
            }
            .frame(height: 8)
            
            Rectangle()
                .fill(.white.opacity(0.4))
                .frame(width: animatedStates[0] ? nil: 0, height: 1)
            
            LazyVGrid(columns: columns, spacing: 18) {
                ForEach(extractDate()) { value in
                    PickerDayView(currentDate: $currentDate, value: value)
                        .onTapGesture {
                            self.currentDate = value.date
                        }
                }
            }
            
        }
        .padding()
        .onChange(of: currentMonth) { newValue in
            currentDate = getCurrentMonth()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                withAnimation(.easeOut(duration: 0.3)) {
                    animatedStates[0] = true
                }
            }
        }
    }
        
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        return currentMonth
    }
        
    // extracting Year and Month
    func extractStringDate() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        let date = formatter.string(from: currentDate)
        return date.components(separatedBy: " ")
    }
    
    func extractDate() -> [DateValue] {
        let calendar = Calendar.current
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap() { date -> DateValue in
            let day = calendar.component(.day, from: date)
            return .init(day: day, date: date)
        }
        
        // adding offset days to get exact week day
        
        let firstWeekDay = calendar.component(.weekday, from: currentMonth ?? Date())
        
        for _ in 0..<firstWeekDay - 1 {
            days.insert(.init(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
}

struct CustomDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        CustomDatePicker(currentDate: .constant(Date()), currentMonth: .constant(0))
    }
}
