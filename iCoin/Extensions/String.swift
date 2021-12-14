//
//  String.swift
//  iCoin
//
//  Created by Lingeswaran Kandasamy on 12/14/21.
//

import Foundation

extension String {
    
    
    var removeHTMLTags: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
