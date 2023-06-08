//
//  OverlayExtension.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 08.06.23.
//

import Foundation
import SwiftUI

struct Overlay<T: View>: ViewModifier {
    let overlayView: T
    @Binding var show: Bool
    
    func body(content: Content) -> some View {
        ZStack{
            content
            if show {
                overlayView
            }
        }
    }
}

extension View {
    func overlay<T: View>(overlayView: T, show: Binding<Bool>) -> some View {
        self.modifier(Overlay(overlayView: overlayView, show: show))
    }
}
