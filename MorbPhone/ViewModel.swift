//
//  ViewModel.swift
//  MorbPhone
//
//  Created by Daniel Spalek on 31/05/2022.
//

import SwiftUI
import Foundation

enum Page{
    case movies
    case shopping
    case messages
    case home
    case lock
}
class ViewModel: ObservableObject{
    @Published var currentPage: Page = .lock
}
