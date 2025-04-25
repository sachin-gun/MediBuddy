//
//  CreateMedicationView.swift
//  medi buddy test
//
//  Created by Sachin Gunawardena on 2025-04-23.
//

import SwiftUI

struct CreateMedicationView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Label("Guest", systemImage: "person.crop.circle")
                    .font(.headline)
                Spacer()
                Button(action: {}) {
                    Image(systemName: "plus")
                        .font(.title2)
                }
            }
            .padding()
            .background(Color("brandColor"))
            .foregroundColor(.white)

            VStack(alignment: .leading, spacing: 16) {
                Text("Create Medication")
                    .font(.title3.bold())

                VStack(spacing: 0) {
                    MedicationEditableRow(title: "Name", value: "METFORMIN")
                    Divider()
                    MedicationEditableRow(title: "Condition", value: "Diabetes")
                }

                VStack(spacing: 0) {
                    MedicationEditableRow(title: "Frequency", value: "Every Day", showChevron: true)
                    Divider()
                    MedicationEditableRow(title: "Period", value: "Life time", showChevron: true)
                    Divider()
                    MedicationEditableRow(title: "Meal Instructions", value: "After meals", showChevron: true)
                    Divider()
                    MedicationEditableRow(title: "How many times a day", value: "Twice", showChevron: true)
                }

                VStack(spacing: 0) {
                    MedicationEditableRow(title: "Dose 1", value: "8:00AM\n1 Pill", showChevron: true)
                    Divider()
                    MedicationEditableRow(title: "Dose 2", value: "8:00AM\n1 Pill", showChevron: true)
                }

                Button(action: {
                    // Create medication action
                }) {
                    Text("Create Medication")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("brandColor"))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .padding(.top)
            }
            .padding()

            Spacer()

            Divider()
            HStack {
                TabBarItem(icon: "house", label: "Home")
                TabBarItem(icon: "doc.plaintext", label: "Prescription")
                TabBarItem(icon: "person.2.fill", label: "Doctors")
                TabBarItem(icon: "list.bullet", label: "More")
            }
            .padding()
            .background(Color.white)
        }
        .background(Color("commonBackground"))
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    CreateMedicationView()
}
