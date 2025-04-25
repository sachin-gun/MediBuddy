import SwiftUI


struct PrescriptionView: View {
    @State private var prescriptions: [PrescriptionModel] = [
        PrescriptionModel(
            title: "Fever Prescription",
            doctor: "Dr Supun",
            date: "07/03/25",
            isActive: false,
            reminderDates: [
                Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: Date())!
            ]
        ),
        PrescriptionModel(
            title: "Diabetes Prescription",
            doctor: "Dr Supun",
            date: "07/03/25",
            isActive: true,
            reminderDates: [
                Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: Date())!,
                Calendar.current.date(bySettingHour: 10, minute: 45, second: 0, of: Date())!
            ]
        )
    ]

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Label("Guest", systemImage: "person.crop.circle")
                    .font(.headline)
                Spacer()
                Button(action: {
                    // Add new prescription
                }) {
                    Image(systemName: "plus")
                        .font(.title2)
                }
            }
            .padding()
            .background(Color("brandColor"))
            .foregroundColor(.white)

            VStack(alignment: .leading, spacing: 16) {
                Text("Prescriptions")
                    .font(.title3.bold())

                ForEach($prescriptions) { $prescription in
                    PrescriptionCardView(prescription: $prescription)
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
    }
}

struct PrescriptionCardView: View {
    @Binding var prescription: PrescriptionModel

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(prescription.title)
                    .bold()
                Spacer()
                Text(prescription.date)
                    .font(.caption)
            }

            Text(prescription.doctor)
                .font(.subheadline)

            HStack {
                Spacer()
                Toggle(isOn: $prescription.isActive) {
                    Text("Active")
                        .font(.caption)
                        .foregroundColor(prescription.isActive ? .green : .gray)
                }
                .onChange(of: prescription.isActive) {
                    if prescription.isActive {
                        // Remove any pending old ones before scheduling new
                        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

                        for date in prescription.reminderDates {
                            var nextDate = prescription.startDate
                            while nextDate <= prescription.endDate {
                                var components = Calendar.current.dateComponents([.hour, .minute], from: date)
                                components.year = Calendar.current.component(.year, from: nextDate)
                                components.month = Calendar.current.component(.month, from: nextDate)
                                components.day = Calendar.current.component(.day, from: nextDate)

                                if let scheduledDate = Calendar.current.date(from: components) {
                                    NotificationManager.shared.scheduleNotification(
                                        title: prescription.title,
                                        body: "Reminder from Dr. \(prescription.doctor)",
                                        at: scheduledDate,
                                        repeats: false
                                    )
                                }

                                nextDate = Calendar.current.date(byAdding: .day, value: 1, to: nextDate)!
                            }
                        }
                    } else {
                        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    }
                }

                .labelsHidden()
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct TabBarItem6: View {
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
    PrescriptionView()
}
