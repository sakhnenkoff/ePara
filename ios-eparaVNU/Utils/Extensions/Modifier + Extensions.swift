//
//  Modifier + Extensions.swift
//  ios-eparaVNU
//
//  Created by Matthew Sakhnenko on 21.05.2022.
//

//import SwiftUI
//
//@available(iOS 15, *)
//struct CustomTaskModifier: ViewModifier {
//    var taskClosure: () -> ()
//
//    func body(content: Content) -> some View {
//        content
//            .task {
//                await taskClosure()
//            }
//    }
//}
//
//extension View {
//    @ViewBuilder
//    func customTask(with closure: @escaping (() -> Void)) -> some View {
//        if #available(iOS 15, *) {
//            self
//                .modifier(CustomTaskModifier(taskClosure: closure))
//        }
//        else {
//            print("Custom task is unavailable in this iOS version")
//        }
//    }
//}
