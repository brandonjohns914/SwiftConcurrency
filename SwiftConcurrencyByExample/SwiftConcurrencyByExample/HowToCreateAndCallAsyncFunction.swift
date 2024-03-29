//
//  HowToCreateAndCallAsyncFunction.swift
//  SwiftConcurrencyByExample
//
//  Created by Brandon Johns on 12/27/23.
//

import Foundation
import SwiftUI

func fetchWeatherHistory() async -> [Double] {
    (1...100_000).map {_ in Double.random(in: -10...30) }
    
}

func calculateAverageTempature(for records: [Double]) async -> Double {
    let total = records.reduce(0, +)
    let average = total / Double(records.count)
    return average
}

func upload(result: Double) async -> String {
    "OK"
}

func processWeather() async {
    let records = await fetchWeatherHistory()
    let average = await calculateAverageTempature(for: records)
    let response = await upload(result: average)
    
    print("Server response: \(response)")
}

//await processWeather() 
