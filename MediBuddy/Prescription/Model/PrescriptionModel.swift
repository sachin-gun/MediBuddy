//
//  PrescriptionModel.swift
//  medi buddy test
//
//  Created by Sachin Gunawardena on 2025-04-22.
//

import SwiftUI

struct PrescriptionModel: Identifiable {
    var id = UUID()
    var title: String
    var doctor: String
    var date: String
    var isActive: Bool
    var reminderDates: [Date] = []
    var startDate: Date = Date()                      
    var endDate: Date = Calendar.current.date(byAdding: .day, value: 14, to: Date())!
}


