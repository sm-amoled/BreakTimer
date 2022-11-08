//
//  IntFormatter.swift
//  BreakTimer Watch App
//
//  Created by Park Sungmin on 2022/11/07.
//

import Foundation

extension Double {
    func convertToTimeFormat() -> String {
        let minute = Int(self) / 60
        let second = Int(self) % 60
        
        return String(format: "%02d:%02d", minute, second)
    }
}
