//
//  DocotrListModel.swift
//  medi buddy test
//
//  Created by Sachin Gunawardena on 2025-04-20.
//

import SwiftUI

struct DoctorListModel: Identifiable {
    var id = UUID()
      var firstName: String
      var lastName: String
      var email: String
      var phone: String
      var department: String
      var specialization: String
      var isAvailable: Bool
      var isPinned: Bool
      var isWhatsapp: Bool
      var isEmail: Bool
      var isCall: Bool
}
