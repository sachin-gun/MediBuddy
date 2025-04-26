import SwiftUI

struct PrescriptionDetailViewOCR: View {
    var prescriptionName: String
    var imageName: String
    var medications: [ParsedMedication]
    @State private var navigateToCreateMedication = false

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

   
            HStack {
                Text(prescriptionName)
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

            HStack {
                Text(imageName)
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "eye")
                Image(systemName: "doc.on.doc")
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal)


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
            .padding(.horizontal)
            .padding(.top, 4)


            ScrollView {
                VStack(spacing: 12) {
                    ForEach(medications) { med in
                        HStack(spacing: 12) {
                            Image(systemName: "pills.fill")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .padding(.top, 8)

                            VStack(alignment: .leading, spacing: 4) {
                                Text(med.name.uppercased())
                                    .font(.headline)
                                Text("Next Reminder: Today, 8:00 AM")
                                    .font(.subheadline)
                                Text("\(med.daysRemaining) days left for medication")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
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

            NavigationLink(destination: CreateMedicationView(), isActive: $navigateToCreateMedication) {
                EmptyView()
            }
        }
        .background(Color("commonBackground"))
        .edgesIgnoringSafeArea(.bottom)
    }
}


struct TabBarItem8: View {
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

