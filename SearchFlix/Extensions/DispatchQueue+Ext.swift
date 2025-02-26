//
//  DispatchQueue+Ext.swift
//  SearchFlix
//
//  Created by Mine Rala on 26.02.2025.
//

import Foundation

extension DispatchQueue {
    static func performOnMainThread(_ action: @escaping () -> Void) {
        if Thread.isMainThread {
            action()
        } else {
            DispatchQueue.main.async {
                action()
            }
        }
    }
}

