import SwiftUI



struct EmergencyContactDetailView: View {
    let contact: EmergencyContactModel
    @State private var isEditing = false

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

            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(contact.name)
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
                    InfoCardView(title: "Name", value: contact.name)
                    InfoCardView(title: "Relationship", value: contact.relationship)
                }

                VStack(spacing: 12) {
                    InfoCardView(title: "Email", value: contact.email)
                    InfoCardView(title: "Phone", value: contact.phone)

                    HStack {
                        Text("Contacts")
                            .foregroundColor(.black)
                        Spacer()
                        HStack(spacing: 24) {
                            if contact.isCall {
                                Button(action: {}) {
                                    Image(systemName: "phone.fill")
                                        .foregroundColor(.red)
                                }
                            }
                            if contact.isWhatsapp {
                                Button(action: {}) {
                                    Image(systemName: "message.fill")
                                        .foregroundColor(.green)
                                }
                            }
                            if contact.isEmail {
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
            EditEmergencyContactView(contact: contact, isPresented: $isEditing)
                .presentationDetents([.fraction(0.6)])
                .presentationDragIndicator(.visible)
        }
    }
}


struct InfoCardView1: View {
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

struct EditEmergencyContactView: View {
    var contact: EmergencyContactModel
    @Binding var isPresented: Bool

    @State private var name: String = ""
    @State private var relationship: String = ""
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
                    Text("Dr \(contact.name)")
                        .font(.title3.bold())

                    EditableCardView(label: "Name", text: $name)
                    EditableCardView(label: "Relationship", text: $relationship)
                    EditableCardView(label: "Email", text: $email)
                    EditableCardView(label: "Phone", text: $phone)
                }
                .padding()
                .onAppear {
                    name = contact.name
                    relationship = contact.relationship
                    email = contact.email
                    phone = contact.phone
                }
            }
            .background(Color.gray.opacity(0.1))
        }
    }
}

struct EditableCardView1: View {
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

struct TabBarItem4: View {
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
    EmergencyContactDetailView(contact: EmergencyContactModel(
        name: "Kamal Perera",
        relationship: "Father",
        email: "kamal@gmail.com",
        phone: "+94 775 828 900",
        isWhatsapp: true,
        isEmail: true,
        isCall: true
    ))
}
