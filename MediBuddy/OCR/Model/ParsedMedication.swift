//
//  ParsedMedication.swift
//  MedicineReminder
//
//  Created by Sachin Gunawardena on 2025-04-25.
//
import SwiftUI

struct ParsedMedication: Identifiable {
    let id = UUID()
    let name: String
    let dosage: String
    let instructions: String
    let duration: String
    var daysRemaining: Int {
        // Extract number of months from duration and convert to days
        if let months = Int(duration.components(separatedBy: " ").first ?? "") {
            return months * 30
        }
        return 0
    }
}
