//
//  Message.swift
//  TasksAndGroups
//
//  Created by Brandon Johns on 12/29/23.
//

import SwiftUI

struct Message: Decodable, Identifiable {
    let id: Int
    let from: String
    let text: String
}


