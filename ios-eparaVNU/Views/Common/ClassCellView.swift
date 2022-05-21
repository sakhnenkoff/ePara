//
//  ClassCellView.swift
//  ios-eparaVNU
//
//  Created by Matthew Sakhnenko on 19.05.2022.
//

import SwiftUI

struct ClassCellView: View {
    // animation state
    @State private var showView: Bool = false

    var lesson: Lesson

    var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text(lesson.lessonTime)
                    .font(.caption)
                    .foregroundColor(.accentRed)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(lesson.lessonDescription)
                    .font(.system(size: 14))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            }
            .padding(.all, 8)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
}

struct ClassCellView_Previews: PreviewProvider {
    static var previews: some View {
        ClassCellView(lesson: .lessons.first!)
    }
}
