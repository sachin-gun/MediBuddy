//
//  CreateDoctorView.swift
//  medi buddy test
//
//  Created by Sachin Gunawardena on 2025-04-20.
//

import SwiftUI

struct CreateDoctorView: View {
    @State private var name: String = ""
    @State private var specialization: String = ""
    @State private var hospital: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""

    var body: some View {
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

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Create Doctor")
                        .font(.title3.bold())

                    RoundedInputField(placeholder: "Dr Name", text: $name)
                    RoundedInputField(placeholder: "Specialisation", text: $specialization)
                    RoundedInputField(placeholder: "Visiting hospital", text: $hospital)
                    RoundedInputField(placeholder: "Email", text: $email)
                    RoundedInputField(placeholder: "Phone number", text: $phone)

                    Button(action: {
                        // Save new doctor logic
                    }) {
                        Text("Create Doctor")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("brandColor"))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
                .padding()
              }

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

struct RoundedInputField: View {
    let placeholder: String
    @Binding var text: String

    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .background(Color.gray.opacity(0.15))
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct TabBarItem1: View {
    let icon: String
    let label: String

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.title2)
            Text(label)
                .font(.caption)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    CreateDoctorView()
}
