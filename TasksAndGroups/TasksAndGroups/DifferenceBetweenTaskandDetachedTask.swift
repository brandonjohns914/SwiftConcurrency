//
//  DifferenceBetweenTaskandDetachedTask.swift
//  TasksAndGroups
//
//  Created by Brandon Johns on 12/28/23.
//

import SwiftUI

actor Users {
    func login() {
        Task.detached {
            
            if await self.authenticate(user: "EllieBellie", password: "Dawg914"){
                print("Success")
            } else {
                print("Error")
            }
        }
    }
    
    func authenticate(user: String, password: String) -> Bool {
        //logic
        
        return true
    }
}

func login()  async {
    let user = Users()
    await user.login()
}

struct DifferenceBetweenTaskandDetachedTask: View {
    @State private var name = "Anonymous"
    var body: some View {
        VStack {
            Text("Hello, \(name)")
            Button("Authenticate"){
                Task.detached {
                    name = "Ellie"
                }
            }
        }
    }
}




class ViewModel: ObservableObject { }

struct ContentViewsssss: View {
    @StateObject private var model = ViewModel()

    var body: some View {
        Button("Authenticate", action: doWork)
    }

    func doWork() {
        Task {
            for i in 1...10_000 {
                print("In Task 1: \(i)")
            }
        }

        Task {
            for i in 1...10_000 {
                print("In Task 2: \(i)")
            }
        }
    }
}
