//
//  MedicationModel.swift
//  medi buddy test
//
//  Created by Sachin Gunawardena on 2025-04-22.
//

import SwiftUI

struct MedicationModel: Identifiable {
    var id = UUID()
    var name: String
    var reminder: String
    var remainingDays: Int
}
