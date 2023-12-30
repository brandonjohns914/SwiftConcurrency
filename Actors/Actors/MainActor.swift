//
//  MainActor.swift
//  Actors
//
//  Created by Brandon Johns on 12/29/23.
//

import Foundation

@MainActor
class AccountViewModel: ObservableObject {
    @Published var username = "Anonymous"
    @Published var isAuthenticated = false
}
