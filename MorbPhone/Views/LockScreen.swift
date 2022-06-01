//
//  LockScreen.swift
//  MorbPhone
//
//  Created by Daniel Spalek on 31/05/2022.
//

import SwiftUI
import AVKit //audio/video kit.

class SoundManager{
    
    //singleton
    static let instance = SoundManager() //whenever we access class SoundManager, we can access THE instance of the sound manager instead of creating a new one every time
    
    var player: AVAudioPlayer?
    
    enum soundOption: String{
        case slideToUnlock
//        case unlock = "slideToUnlock"
        case augh
    }
    
    func playSound(sound: soundOption) {
        
//        guard let url = URL(string: "") else {return}
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else {return}
        do{
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        }catch let error{
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
}

struct LockScreen: View {
    @EnvironmentObject var viewModel: ViewModel
    @Namespace var animation
    @Environment(\.colorScheme) var scheme
    @State var offset: CGSize = .zero
    @State var swipeBackground: CGRect = .zero
    let widthOfUnlockSwipe: Double = 330
    let hour: String = Date.now.formatted(date: .omitted, time: .shortened)
    let date: String = Date.now.formatted(date: .complete, time: .omitted)
    
    @State var startPointX: Double = .zero
    @State var currentPointX: Double = .zero
    @State var endPointX: Double = .zero
    @State var didUnlock: Bool = false //so we don't trigger the unlock more than once we will need to disable to slider when the unlock is triggered for the first time.
    
    var body: some View {
        VStack{
            ScrollView(.vertical, showsIndicators: false){
                // MARK: Top section
                VStack{
                    // MARK: time and date. lock icon.
                    VStack(spacing: 8){
                        Image(systemName: "lock.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 20, height: 20)
                            .padding(.vertical, 12)
                        Text(hour)
                            .font(.system(size: 60))
                            .fontWeight(.light)
                        Text(date)
                    }
                    // MARK: Notifications
                    VStack{
                        NotificationSection(app: apps[2], title: "3 Text Messages")
                        NotificationSection(app: apps[1], title: "Notification")
                    }
                    .padding(.vertical, 10)
                        
                }
                .padding(.top ,50)
            }
            Spacer()
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
                .frame(width: widthOfUnlockSwipe, height: 60)
                .overlay{
                    HStack{
                        Image(systemName: "arrowtriangle.forward.square.fill")
                            .resizable()
                            .cornerRadius(15)
                            .frame(width: 60, height: 50)
                            .offset(x: offset.width)
                            .padding(.leading, 5)
                            .gesture(
                                DragGesture()
                                    .onChanged({ value in
                                        // MARK: Update point values
                                        startPointX = value.startLocation.x
                                        currentPointX = value.location.x
                                        endPointX = value.startLocation.x + widthOfUnlockSwipe - 60
                                        
                                        // MARK: only move when between start and end of bar.
                                        if currentPointX > startPointX && currentPointX <= endPointX - 5{
                                            offset = value.translation
                                        }
                                        
                                        //MARK: If I did unlock the device
                                        //also decrease the width of the button itself.
                                        //1. - use range instead of a single point.
                                        if endPointX - 20 <= currentPointX && currentPointX <= endPointX{
                                            didUnlock = true //disable slider
                                            offset = .zero //reset slider
                                            Task{
                                                await playSound()
                                            }
                                            withAnimation(.spring(response: 0.5, dampingFraction: 0.6)){
                                                viewModel.currentPage = .home
                                                didUnlock = false //enable slider back after we change the page, because if we lock the screen mid animation of unlock animation then we want the slider to be enabled again.
                                            }
                                            print("Unlocked.")
                                        }
                                    })
                                    .onEnded({ value in
                                        if viewModel.currentPage == .lock{
                                            offset = .zero
                                        }
                                    })
                            )
                            .disabled(didUnlock)
                            .symbolRenderingMode(.hierarchical)
                            .shadow(color: .black.opacity(0.3), radius: 20)
                        Spacer()
                    }
                    Text("slide to unlock")
                        .opacity( offset.width > 0 ? 0 : 0.5) //hide text if swiping
                }
                .padding(.bottom, 80)
                .shadow(color: .black, radius: 20)
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background{
            Image("MorbiusWallpaper")
                .resizable()
                .ignoresSafeArea()
                .blur(radius: 5)
                .scaleEffect(1.2) //to prevent white border from the blur
                .shadow(color: .black, radius: 7, y: 5)
                
        }
    }
    @ViewBuilder
    func NotificationSection(app: AppIcon, title: String) -> some View{
        HStack(spacing: 10){
            Image(systemName: app.icon)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 20, height: 20)
                .padding(9)
                .background{
                    app.color
                }
                .cornerRadius(9)
            VStack(alignment: .leading, spacing: 3){
                Text(app.name)
                    .font(.system(size: 16))
                    .bold()
                Text(title)
                    .font(.system(size: 15))
            }
            .foregroundColor((scheme == .light) ? .black : .white)
            Spacer()
        }
        .padding()
        .padding(.horizontal, -5)
        .frame(maxWidth: .infinity, maxHeight: 80)
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .padding(.horizontal)
    }
    
    func playSound()async -> Void{
        SoundManager.instance.playSound(sound: .slideToUnlock)
    }
}

struct LockScreen_Previews: PreviewProvider {
    static var previews: some View {
        LockScreen().environmentObject(ViewModel())
        LockScreen().environmentObject(ViewModel()).preferredColorScheme(.dark)
    }
}


/*
 1. if we make the end only a single point it may not detect if we swipe too fast because the values will  change too fast. we want to use a range instead.
 2. The problem was with that it waited for the sound to play before unlocking. - solved by async function to play the sound.
 */
