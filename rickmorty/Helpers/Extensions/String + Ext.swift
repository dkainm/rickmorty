//
//  String + Ext.swift
//  rickmorty
//
//  Created by Alex Rudoi on 16/2/23.
//

import Foundation

extension String {
    
    func markIfEmpty() -> String {
        if self.isEmpty {
            return "-"
        }
        return self
    }
    
}
