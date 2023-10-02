//
//  ToastView.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 06.06.23.
//

import SwiftUI

struct ToastView: View {
    @ObservedObject var viewModel: TextView.ViewModel
    @ObservedObject var locationManager: LocationHandler
    @Binding var show: Bool
    @State private var offset = CGSize.zero
    var body: some View {
        HStack{
            Image("errorIcon")
                .resizable()
                .scaledToFit()
            Text(viewModel.errorText)
                .foregroundColor(.gray)
                .font(.headline)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 24)
        .frame(maxHeight: 50)
        .background {
            Color("objectColor")
                .clipShape(Capsule())
                .shadow(color: Color("reverseObjectColor").opacity(0.5), radius: 5, x: 0, y: 3)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .onAppear {
            Task {
                try await Task.sleep(nanoseconds: 3_000_000_000)
                DispatchQueue.main.async {
                    withAnimation {
                        show = false
                        viewModel.errorShow = false
                        locationManager.errorFound = false
                    }
                }

            }
        }
        .offset(x: 0, y: -abs(offset.height))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    if abs(offset.height) > 20 {
                        withAnimation {
                            show = false
                            viewModel.errorShow = false
                            locationManager.errorFound = false
                        }
                    } else {
                        offset = .zero
                    }
                }
        )
        .padding(.horizontal, 20)
    }
}


struct ToastView_Previews: PreviewProvider {
   
    static var previews: some View {
        ToastView(viewModel: TextView.ViewModel(), locationManager: LocationHandler(), show: .constant(true))
    }
}
