//
//  EmergencyContactListModel.swift
//  medi buddy test
//
//  Created by Sachin Gunawardena on 2025-04-20.
//

import SwiftUI

struct EmergencyContactModel: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var relationship: String
    var email: String
    var phone: String
    var isWhatsapp: Bool
    var isEmail: Bool
    var isCall: Bool
}
