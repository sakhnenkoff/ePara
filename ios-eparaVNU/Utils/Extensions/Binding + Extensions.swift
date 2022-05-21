//
//  Binding + Extensions.swift
//  ios-eparaVNU
//
//  Created by Matthew Sakhnenko on 20.05.2022.
//

import SwiftUI

extension Binding {
    func onChange(_ completion: @escaping () -> Void) -> Binding<Value> {
        return Binding {
            self.wrappedValue
        } set: { newValue in
            self.wrappedValue = newValue
            completion()
        }

    }
}


