//
//  PickerCardView.swift
//  ios-eparaVNU
//
//  Created by Matthew Sakhnenko on 19.05.2022.
//

import SwiftUI

struct PickerDayView: View {
    @Binding var currentDate: Date
    var value: DateValue

    var body: some View {
        VStack {
            if value.day != -1 {
                Text("\(value.day)")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(Date.isSameDate(date1: value.date, date2: currentDate) ? .black : .white)
                    .frame(maxWidth: .infinity)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .fill(.white)
                .padding(.vertical, -5)
                .padding(.horizontal, 5)
                .opacity(Date.isSameDate(date1: currentDate, date2: value.date) ? 1 : 0)
        )
    }
    
}
