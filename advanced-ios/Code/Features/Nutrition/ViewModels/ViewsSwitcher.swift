//
//  ViewsSwitcher.swift
//  advanced-ios
//
//  Created by Harsh Patel on 10/06/24.
//

import Foundation
import SwiftUI

class ViewsSwitcher: ObservableObject {
    enum ViewName: String {
        case daily, monthly
    }
    
    @Published var navPath: NavigationPath
    
    init() {
        self.navPath = NavigationPath()
    }
}
