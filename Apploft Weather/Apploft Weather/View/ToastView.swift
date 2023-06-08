//
//  ToastView.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 06.06.23.
//

import SwiftUI

struct ToastView: View {
    @ObservedObject var viewModel: TextView.ViewModel
    @Binding var show: Bool
    var body: some View {
        HStack{
            Image("errorIcon")
                .resizable()
                .scaledToFit()
            Text("There has been an error.")
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
        .padding(.horizontal, 20)
        .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
        .onAppear {
            DispatchQueue.main.async {
                sleep(3)
                withAnimation {
                    viewModel.errorShow = false
                    self.show = viewModel.errorShow
                }
            }
        }
    }
}


struct ToastView_Previews: PreviewProvider {
   
    static var previews: some View {
        ToastView(viewModel: TextView.ViewModel(), show: .constant(true))
    }
}
