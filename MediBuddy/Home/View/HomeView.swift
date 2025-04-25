import SwiftUI

struct HomeView: View {
    @EnvironmentObject var globalDto: GlobalDto
    @State private var selectedDate = Date()
    @State private var navigateToDetail = false
    @State private var showCreatePrescription = false

    let calendarDates = generateCalendarDates()

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Top Bar
                HStack {
                    Label("Guest", systemImage: "person.crop.circle")
                        .font(.headline)
                    Spacer()
                    Button(action: {
                        showCreatePrescription = true
                    }) {
                        Image(systemName: "plus")
                            .font(.title2)
                    }
                }
                .padding()
                .background(Color("brandColor"))
                .foregroundColor(.white)

                // Calendar Scroll
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(calendarDates, id: \.self) { date in
                            VStack {
                                Text(date.shortDay)
                                Text(date.dayString)
                                    .font(.caption)
                                    .foregroundColor(date.isToday ? .white : .primary)
                            }
                            .padding(8)
                            .background(
                                Circle().fill(date.isToday ? Color.teal : Color.clear)
                            )
                            .onTapGesture {
                                selectedDate = date.date
                            }
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                }

                // Medication Schedule
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        MedicationGroup(time: "8:00 AM", navigateToDetail: $navigateToDetail)
                        MedicationGroup(time: "8:00 PM", navigateToDetail: $navigateToDetail)
                    }
                    .padding()
                }

                // Tab Bar
                Divider()
                HStack {
                    TabBarItem(icon: "house", label: "Home")
                    TabBarItem(icon: "doc.plaintext", label: "Prescription")
                    TabBarItem(icon: "person.2.fill", label: "Doctors")
                    TabBarItem(icon: "list.bullet", label: "More")
                }
                .padding()
                .background(Color.white)

                // NavigationLinks
                NavigationLink(
                    destination: PrescriptionDetailView(
                        prescription: PrescriptionModel(title: "Sample Rx", doctor: "Dr. Test", date: "Today", isActive: true, reminderDates: [])
                    ),
                    isActive: $navigateToDetail
                ) {
                    EmptyView()
                }

                NavigationLink(
                    destination: CreatePrescriptionView(),
                    isActive: $showCreatePrescription
                ) {
                    EmptyView()
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .background(Color("commonBackground"))
        }
    }
}

// MARK: - Subviews

struct MedicationGroup: View {
    let time: String
    @Binding var navigateToDetail: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(time)
                .font(.title3)
                .bold()
            MedicationCard {
                navigateToDetail = true
            }
        }
    }
}

struct MedicationCard: View {
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                Image(systemName: "pills")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                VStack(alignment: .leading) {
                    Text("METFORMIN").bold()
                    Text("TAKE 1 PILL (S)").font(.subheadline)
                }
                Spacer()
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

struct TabBarItem: View {
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

extension Date {
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }

    var shortDay: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: self)
    }

    var dayString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: self)
    }
}

func generateCalendarDates() -> [CalendarDate] {
    let calendar = Calendar.current
    let today = Date()
    return (-3...3).compactMap { offset in
        guard let date = calendar.date(byAdding: .day, value: offset, to: today) else { return nil }
        return CalendarDate(date: date)
    }
}

struct CalendarDate: Hashable {
    let date: Date

    var shortDay: String { date.shortDay }
    var dayString: String { date.dayString }
    var isToday: Bool { date.isToday }
}

#Preview {
    HomeView().environmentObject(GlobalDto.shared)
}
