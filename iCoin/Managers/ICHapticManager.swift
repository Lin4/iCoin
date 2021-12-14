//
//  HapticManager.swift
//  iCoin
//
//  Created by Lingeswaran Kandasamy on 12/14/21.
//

import Foundation
import SwiftUI



class ICHapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
