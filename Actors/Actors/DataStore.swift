//
//  DataStore.swift
//  Actors
//
//  Created by Brandon Johns on 12/29/23.
//

import Foundation
import SwiftUI

actor DataStore {
    var username = "Anonymous"
    var friends = [String]()
    var highScores = [Int]()
    var favorites = Set<Int>()
    
    init() {
        // load
    }
    
    func save() {
        //save data
    }
    
    
}


    
    func debugLog(dataStore: isolated DataStore) {
        print("Username: \(dataStore.username)")
        print("Friends: \(dataStore.friends)")
        print("High scores: \(dataStore.highScores)")
        print("Favorites: \(dataStore.favorites)")
    }


