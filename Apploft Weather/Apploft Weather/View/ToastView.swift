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
            Color.white
                .clipShape(Capsule())
                .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 6)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .offset(x: 0, y: -abs(offset.height))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    if abs(offset.height) > 20 {
                        withAnimation {
                            self.show = false
                            viewModel.errorShow = false
                            locationManager.errorFound = false
                        }
                    } else {
                        offset = .zero
                    }
                }
        )
        .padding(.horizontal, 20)
        /*.onAppear {
            DispatchQueue.main.async {
                sleep(2)
                withAnimation {
                    self.show.toggle()
                    viewModel.errorShow = self.show
                }
            }
        }*/
    }
}


struct ToastView_Previews: PreviewProvider {
   
    static var previews: some View {
        ToastView(viewModel: TextView.ViewModel(), locationManager: LocationHandler(), show: .constant(true))
    }
}
