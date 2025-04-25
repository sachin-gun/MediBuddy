//
//  EmergencyContactListView.swift
//  MediBuddy
//
//  Created by Sachin Gunawardena on 2025-04-25.
//

import SwiftUI

struct EmergencyContactListView: View {
    @State private var navigateToCreate = false
    @State private var searchText = ""
    @State private var selectedContact: EmergencyContactModel?

    let contacts: [EmergencyContactModel] = [
        .init(name: "Kamal Perera", relationship: "Father", email: "kamal@gmail.com", phone: "+94775828900", isWhatsapp: true, isEmail: true, isCall: true),
        .init(name: "Ruwani Perera", relationship: "Mother", email: "ruwani@gmail.com", phone: "+94773456789", isWhatsapp: true, isEmail: false, isCall: true),
        .init(name: "Damian Perera", relationship: "Brother", email: "damian@gmail.com", phone: "+94770112233", isWhatsapp: false, isEmail: true, isCall: true)
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    Label("Guest", systemImage: "person.crop.circle")
                        .font(.headline)
                    Spacer()
                    Button(action: {
                        navigateToCreate = true
                    }) {
                        Image(systemName: "plus")
                            .font(.title2)
                    }
                }
                .padding()
                .background(Color("brandColor"))
                .foregroundColor(.white)

                VStack(alignment: .leading, spacing: 16) {
                    Text("Emergency contact")
                        .font(.title3.bold())

                    Button(action: {
                        navigateToCreate = true
                    }) {
                        Text("Create new contact")
                            .font(.subheadline.bold())
                            .foregroundColor(Color("brandColor"))
                    }

                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Search Contact", text: $searchText)
                        Spacer()
                        Image(systemName: "mic")
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(contacts.filter {
                                searchText.isEmpty || $0.name.lowercased().contains(searchText.lowercased())
                            }) { contact in
                                Button(action: {
                                    selectedContact = contact
                                }) {
                                    HStack {
                                        Image(systemName: "person.circle.fill")
                                            .font(.title2)
                                            .foregroundColor(Color("brandColor"))
                                        VStack(alignment: .leading) {
                                            Text(contact.name).bold()
                                            Text(contact.relationship).font(.caption).foregroundColor(.gray)
                                        }
                                        Spacer()
                                    }
                                    .padding()
                                }
                                Divider()
                            }
                        }
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
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

                NavigationLink(
                    destination: selectedContact.map { EmergencyContactDetailView(contact: $0) },
                    isActive: Binding(
                        get: { selectedContact != nil },
                        set: { if !$0 { selectedContact = nil } }
                    )
                ) {
                    EmptyView()
                }


                NavigationLink(destination: CreateEmergencyContactView(), isActive: $navigateToCreate) {
                    EmptyView()
                }
            }
            .background(Color("commonBackground"))
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

#Preview {
    EmergencyContactListView()
}
