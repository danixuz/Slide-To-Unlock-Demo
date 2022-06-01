//
//  HomeScreen.swift
//  MorbiusPhone
//
//  Created by Daniel Spalek on 31/05/2022.
//

import Foundation
import SwiftUI

struct AppIcon: Identifiable{
    let id = UUID().uuidString
    let name: String
    let category: String
    let icon: String
    let color: Color
}

let apps: [AppIcon] = [
    AppIcon(name: "Movies", category: "Entertainment", icon: "film", color: .purple),
    AppIcon(name: "Shopping", category: "Shopping", icon: "cart", color: .blue),
    AppIcon(name: "Messages", category: "Social", icon: "bubble.left.and.bubble.right.fill", color: .green),
    AppIcon(name: "Todo", category: "Social", icon: "checkmark.diamond.fill", color: .cyan),
    AppIcon(name: "Tinder", category: "Social", icon: "heart.fill", color: .pink),
    AppIcon(name: "YouTube", category: "Social", icon: "play.rectangle.fill", color: .red),
    AppIcon(name: "Zoom", category: "Social", icon: "video.fill", color: .blue),
    AppIcon(name: "Plex", category: "Social", icon: "chevron.forward", color: .yellow),
    AppIcon(name: "PS App", category: "Gaming", icon: "logo.playstation", color: .blue),
]
