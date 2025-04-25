import SwiftUI

struct DoctorDetailSheetView: View {
    @Binding var selectedDoctor: DoctorListModel?
    @State private var isEditing = false

    var body: some View {
        if let doctor = selectedDoctor {
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

                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Dr \(doctor.firstName) \(doctor.lastName)")
                            .font(.title3.bold())
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "trash")
                        }
                        Button(action: {
                            isEditing = true
                        }) {
                            Image(systemName: "pencil")
                        }
                    }

                    VStack(spacing: 12) {
                        InfoCardView(title: "Name", value: "Dr \(doctor.firstName) \(doctor.lastName)")
                        InfoCardView(title: "Specialisation", value: doctor.specialization)
                        InfoCardView(title: "Visiting Hospitals", value: doctor.department)
                    }

                    VStack(spacing: 12) {
                        InfoCardView(title: "Email", value: doctor.email)
                        InfoCardView(title: "Phone", value: doctor.phone)

                        HStack {
                            Text("Contacts")
                                .foregroundColor(.black)
                            Spacer()
                            HStack(spacing: 24) {
                                if doctor.isCall {
                                    Button(action: {}) {
                                        Image(systemName: "phone.fill")
                                            .foregroundColor(.red)
                                    }
                                }
                                if doctor.isWhatsapp {
                                    Button(action: {}) {
                                        Image(systemName: "message.fill")
                                            .foregroundColor(.green)
                                    }
                                }
                                if doctor.isEmail {
                                    Button(action: {}) {
                                        Image(systemName: "envelope.fill")
                                            .foregroundColor(.blue)
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
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
            }
            .background(Color("commonBackground"))
            .edgesIgnoringSafeArea(.bottom)
            .sheet(isPresented: $isEditing) {
                EditDoctorView(doctor: doctor, isPresented: $isEditing)
                    .presentationDetents([.fraction(0.6)])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}


struct EditDoctorView: View {
    var doctor: DoctorListModel
    @Binding var isPresented: Bool

    @State private var name: String = ""
    @State private var specialization: String = ""
    @State private var hospital: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button("Cancel") {
                    isPresented = false
                }
                Spacer()
                Button("Update") {
                    isPresented = false
                }
            }
            .padding()
            .background(Color(.darkGray))
            .foregroundColor(.white)

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Dr \(doctor.firstName) \(doctor.lastName)")
                        .font(.title3.bold())

                    EditableCardView(label: "Name", text: $name)
                    EditableCardView(label: "Specialisation", text: $specialization)
                    EditableCardView(label: "Visiting Hospitals", text: $hospital)
                    EditableCardView(label: "Email", text: $email)
                    EditableCardView(label: "Phone", text: $phone)
                }
                .padding()
                .onAppear {
                    name = "Dr \(doctor.firstName) \(doctor.lastName)"
                    specialization = doctor.specialization
                    hospital = doctor.department
                    email = doctor.email
                    phone = doctor.phone
                }
            }
            .background(Color.gray.opacity(0.1))
        }
    }
}

struct InfoCardView: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
            Spacer()
            Text(value)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct EditableCardView: View {
    let label: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.black)
            TextField("", text: $text)
                .textFieldStyle(.plain)
                .padding(.vertical, 8)
                .padding(.horizontal)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}


#Preview {
    DoctorDetailSheetView(selectedDoctor: .constant(DoctorListModel(
        firstName: "Supun",
        lastName: "Perera",
        email: "supun_Perera@gmail.com",
        phone: "+94 771 998 983",
        department: "Asiri Central",
        specialization: "Cardiologist",
        isAvailable: true,
        isPinned: false,
        isWhatsapp: true,
        isEmail: true,
        isCall: true
    )))
}
