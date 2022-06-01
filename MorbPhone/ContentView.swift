//
//  ContentView.swift
//  MorbPhone
//
//  Created by Daniel Spalek on 31/05/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel
    var body: some View {
        ZStack{
            Image("BackgroundImage")
                .resizable()
                .ignoresSafeArea()
                .blur(radius: 5)
                .scaleEffect(1.2) //to prevent white border from the blur
                .shadow(color: .black.opacity(0.6), radius: 10, y: 5)
                .transition(.scale)
            if viewModel.currentPage == .lock{
                LockScreen().environmentObject(viewModel)
                    .transition(.move(edge: .top))
            }else{
                HomeScreen().environmentObject(viewModel)
                    .transition(.scale(scale: 2.5)) //make it zoom from outwards
            }
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ViewModel())
    }
}
