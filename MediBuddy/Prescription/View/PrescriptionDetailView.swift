//
//  PrescriptionDetailView.swift
//  medi buddy test
//
//  Created by Sachin Gunawardena on 2025-04-22.
//

import SwiftUI

struct PrescriptionDetailView: View {
    var prescription: PrescriptionModel
    @State private var fileName: String = "prescription.jpg"
    @State private var selectedMedication: MedicationModel? = nil // Track clicked med
    @State private var medications: [MedicationModel] = [
        MedicationModel(name: "METFORMIN", reminder: "Today, 8:00 AM", remainingDays: 20),
        MedicationModel(name: "Allegra", reminder: "Today, 8:00 AM", remainingDays: 20)
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Top Bar
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

                // Title + Actions
                HStack {
                    Text(prescription.title)
                        .font(.title3.bold())
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "trash")
                    }
                    Button(action: {}) {
                        Image(systemName: "pencil")
                    }
                }
                .padding()

                // Upload View
                HStack {
                    Text(fileName)
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "eye")
                    Image(systemName: "doc.on.doc")
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)

                // Enter Medication
                Button(action: {}) {
                    Text("Enter Medication")
                        .font(.subheadline.bold())
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("brandColor"))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.horizontal)
                .padding(.top, 4)

                // Medication Cards
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(medications) { med in
                            MedicationCard1(med: med)
                                .onTapGesture {
                                    selectedMedication = med
                                }
                        }
                    }
                    .padding()
                }

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

                // NavigationLink to MedicationDetailView
                NavigationLink(
                    destination: selectedMedication.map { MedicationDetailView(medication: $0) },
                    isActive: Binding(
                        get: { selectedMedication != nil },
                        set: { if !$0 { selectedMedication = nil } }
                    )
                ) {
                    EmptyView()
                }

            }
            .background(Color("commonBackground"))
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

// Updated MedicationCard1 with no change
struct MedicationCard1: View {
    let med: MedicationModel

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "pills")
                .resizable()
                .frame(width: 32, height: 32)
                .padding(.top, 4)
            VStack(alignment: .leading, spacing: 4) {
                Text(med.name)
                    .bold()
                Text("Next Reminder: \(med.reminder)")
                    .font(.caption)
                Text("\(med.remainingDays) days left for medication")
                    .font(.caption)
            }
            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}


#Preview {
    PrescriptionDetailView(prescription: PrescriptionModel(title: "Diabetes Prescription", doctor: "Dr Supun", date: "07/03/25", isActive: true))
}
