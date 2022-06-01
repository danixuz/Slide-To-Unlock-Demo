//
//  HomeScreen.swift
//  MorbPhone
//
//  Created by Daniel Spalek on 31/05/2022.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.colorScheme) var scheme
    @Namespace var animation
    
    let columns = [
        GridItem(.fixed(83)),
        GridItem(.fixed(83)),
        GridItem(.fixed(83)),
        GridItem(.fixed(83))
    ]
    var body: some View {
        ScrollView(.horizontal){
            VStack(alignment: .center){
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(apps){ app in
                        VStack{
                            Image(systemName: app.icon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 35, height: 35)
                                .padding(12.5)
                                .background{
                                    LinearGradient(colors: [
                                        .clear,
                                        app.color,
                                    ], startPoint: .top, endPoint: .bottom)
                                }
                                .background(app.color)
                                .cornerRadius(15)
                            Text(app.name)
                                .font(.caption)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    // MARK: Lock screen app
                    VStack{
                        Button {
                            withAnimation(.spring()){
                                viewModel.currentPage = .lock
                            }
                        } label: {
                            VStack{
                                Image(systemName: "lock.fill")
                                    .resizable()
                                    .scaleEffect(0.75)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 35, height: 35)
                                    .padding(12.5)
                                    .foregroundColor(.black)
                                    .background{
                                        LinearGradient(colors: [
                                            .clear,
                                            .gray.opacity(0.4)
                                        ], startPoint: .topLeading, endPoint: .trailing)
                                    }
                                    .background(.white)
                                    .cornerRadius(15)
                            }
                        }
                        Text("Lock Screen")
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity)
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.horizontal)
                Spacer()
            }
            .frame(maxHeight: .infinity)
        }
        .padding(.top, 72)
        .shadow(color: .black.opacity(0.2), radius: 10)
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background{
//            Image("BackgroundImage")
//                .resizable()
//                .ignoresSafeArea()
//            Image("MorbiusWallpaper")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .ignoresSafeArea()
////                .blur(radius: 10)
//                .scaleEffect(1.2) //to prevent white border from the blur
//                .matchedGeometryEffect(id: "BACKGROUND", in: animation)
                
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
