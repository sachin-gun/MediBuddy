import SwiftUI

struct CreatePrescriptionView: View {
    @State private var prescriptionName: String = ""
    @State private var navigateToCreateMedication = false

    var body: some View {
        NavigationStack {
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
                    Text("Create Prescriptions")
                        .font(.title3.bold())

                    TextField("Enter prescription name", text: $prescriptionName)
                        .padding()
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))

                    HStack(spacing: 16) {
                        Button(action: {
                            // Upload logic
                        }) {
                            Text("Upload Prescription")
                                .font(.subheadline.bold())
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color("brandColor"))
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }

                        Button(action: {
                            navigateToCreateMedication = true
                        }) {
                            Text("Enter Medication")
                                .font(.subheadline.bold())
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color("brandColor"))
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
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
                    destination: CreateMedicationView(),
                    isActive: $navigateToCreateMedication
                ) {
                    EmptyView()
                }
            }
            .background(Color("commonBackground"))
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

#Preview {
    CreatePrescriptionView()
}
