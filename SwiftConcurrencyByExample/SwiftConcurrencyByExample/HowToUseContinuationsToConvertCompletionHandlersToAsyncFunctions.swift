//
//  HowToUseContinuationsToConvertCompletionHandlersToAsyncFunctions.swift
//  SwiftConcurrencyByExample
//
//  Created by Brandon Johns on 12/27/23.
//

import SwiftUI

func fetchMessages(completion: @escaping([Message]) -> Void ){
    let url = URL(string: "https://hws.dev/user-messages.json")!

     URLSession.shared.dataTask(with: url) { data, response, error in
         if let data = data {
             if let messages = try? JSONDecoder().decode([Message].self, from: data) {
                 completion(messages)
                 return
             }
         } else {
             
             completion([])
         }
     }.resume()
    
    
   
}
func fetchMessages() async -> [Message] {
    await withCheckedContinuation { continuation in
        fetchMessages { messages in
            continuation.resume(returning: messages)
        }
    }
    
 
}

struct HowToUseContinuationsToConvertCompletionHandlersToAsyncFunctions: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    HowToUseContinuationsToConvertCompletionHandlersToAsyncFunctions()
}
