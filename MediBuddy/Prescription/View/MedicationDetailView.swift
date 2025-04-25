import SwiftUI

struct MedicationDetailView: View {
    var medication: MedicationModel
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

            HStack {
                VStack(alignment: .leading) {
                    Text(medication.name)
                        .font(.title3.bold())
                    Text("Diabetes")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
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
            .padding()

            VStack(spacing: 0) {
                InfoRow(title: "Frequency", value: "Every Day")
                Divider()
                InfoRow(title: "Period", value: "Life time")
                Divider()
                InfoRow(title: "Meal Instructions", value: "After meals")
                Divider()
                VStack(alignment: .leading, spacing: 8) {
                    Text("How many times a day")
                        .font(.subheadline.bold())
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Every day")
                        Text("8:00 AM (1 pill)")
                        Text("8:00 PM (1 pill)")
                    }
                    .font(.caption)
                    .foregroundColor(.gray)
                }
                .padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .frame(maxWidth: 300)
                .padding(.top, 12)
            }
            .padding()
            .background(Color.clear)

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
            EditMedicationSheet(isPresented: $isEditing)
                .presentationDetents([.fraction(0.8)])
                .presentationDragIndicator(.visible)
        }
    }
}

struct InfoRow: View {
    var title: String
    var value: String

    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline.bold())
            Spacer()
            Text(value)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
    }
}

struct EditMedicationSheet: View {
    @Binding var isPresented: Bool

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button("Cancel") {
                    isPresented = false
                }
                Spacer()
                Text("Edit Med")
                    .font(.subheadline.bold())
                    .foregroundColor(Color("brandColor"))
                Spacer()
                Button("Update") {
                    isPresented = false
                }
            }
            .padding()
            .background(Color(.darkGray))
            .foregroundColor(.white)

            ScrollView {
                VStack(spacing: 16) {
                    MedicationEditableRow(title: "Name", value: "METFORMIN")
                    MedicationEditableRow(title: "Condition", value: "Diabetes")
                }
                .padding(.top)

                VStack(spacing: 0) {
                    MedicationEditableRow(title: "Frequency", value: "Every Day", showChevron: true)
                    Divider()
                    MedicationEditableRow(title: "Period", value: "Life time", showChevron: true)
                    Divider()
                    MedicationEditableRow(title: "Meal Instructions", value: "After meals", showChevron: true)
                    Divider()
                    MedicationEditableRow(title: "How many times a day", value: "Twice", showChevron: true)
                }
                .padding(.top)

                VStack(spacing: 0) {
                    MedicationEditableRow(title: "Dose 1", value: "8:00AM\n1 Pill", showChevron: true)
                    Divider()
                    MedicationEditableRow(title: "Dose 2", value: "8:00PM\n1 Pill", showChevron: true)
                }
                .padding(.top)
            }
            .padding()
        }
        .background(Color("commonBackground"))
    }
}

struct MedicationEditableRow: View {
    var title: String
    var value: String
    var showChevron: Bool = false

    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline.bold())
            Spacer()
            VStack(alignment: .trailing) {
                ForEach(value.split(separator: "\n"), id: \.self) { line in
                    Text(line)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            if showChevron {
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    MedicationDetailView(medication: MedicationModel(name: "METFORMIN", reminder: "Today, 8:00 AM", remainingDays: 20))
}
