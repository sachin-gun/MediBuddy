import SwiftUI

struct DoctorListView: View {
    @State private var searchText = ""
    @State private var navigateToCreate = false
    @State private var selectedDoctor: DoctorListModel?
    @State private var navigateToDetail = false

    let doctors: [DoctorListModel] = [
        .init(firstName: "Supun", lastName: "Perera", email: "supun@gmail.com", phone: "0771998983", department: "Asiri Central", specialization: "Cardiologist", isAvailable: true, isPinned: false, isWhatsapp: true, isEmail: true, isCall: true),
        .init(firstName: "Kamal", lastName: "", email: "kamal@gmail.com", phone: "0771234567", department: "Lanka Hospital", specialization: "General physician", isAvailable: true, isPinned: false, isWhatsapp: true, isEmail: true, isCall: true),
        .init(firstName: "Vipul", lastName: "Jayawardena", email: "vipul@gmail.com", phone: "0779876543", department: "Durdans", specialization: "Physiotherapist", isAvailable: true, isPinned: false, isWhatsapp: true, isEmail: true, isCall: true)
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Top Bar
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
                    Text("Doctors Contact")
                        .font(.title3.bold())

                    Button(action: {
                        navigateToCreate = true
                    }) {
                        Text("Create new doctor")
                            .font(.subheadline.bold())
                            .foregroundColor(Color("brandColor"))
                    }

                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Search Doctor", text: $searchText)
                            .submitLabel(.search)
                        Spacer()
                        Image(systemName: "mic")
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(filteredDoctors) { doctor in
                                Button(action: {
                                    selectedDoctor = doctor
                                    navigateToDetail = true
                                }) {
                                    HStack {
                                        Image(systemName: "person.circle.fill")
                                            .font(.title2)
                                            .foregroundColor(Color("brandColor"))
                                        VStack(alignment: .leading) {
                                            Text("Dr \(doctor.firstName) \(doctor.lastName)")
                                                .bold()
                                            Text(doctor.specialization)
                                                .font(.caption)
                                                .foregroundColor(.gray)
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

                // Navigation to CreateDoctorView
                .navigationDestination(isPresented: $navigateToCreate) {
                    CreateDoctorView()
                }

            }
            .background(Color("commonBackground"))
            .edgesIgnoringSafeArea(.bottom)
            .navigationDestination(isPresented: $navigateToDetail) {
                if let selectedDoctor = selectedDoctor {
                    DoctorDetailSheetView(selectedDoctor: .constant(selectedDoctor))
                }
            }
        }
    }

    var filteredDoctors: [DoctorListModel] {
        if searchText.isEmpty {
            return doctors
        } else {
            return doctors.filter {
                $0.firstName.localizedCaseInsensitiveContains(searchText) ||
                $0.lastName.localizedCaseInsensitiveContains(searchText) ||
                $0.specialization.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}

#Preview {
    DoctorListView()
}
