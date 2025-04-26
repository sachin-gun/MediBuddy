//import SwiftUI
//
//struct DashboardView: View {
//    @StateObject var viewModel = ReminderViewModel()
//    @State private var showPreview = false
//    @State private var showScanner = false
//
//    var body: some View {
//        NavigationStack {
//            VStack {
//
//                Button("Scan Prescription") {
//                    showScanner = true
//                }
//                .sheet(isPresented: $showScanner) {
//                    ScanView(showPreview: $showPreview)
//                        .environmentObject(viewModel)
//                }
//                .navigationDestination(isPresented: $showPreview) {
//                    ScannedTextPreviewView()
//                        .environmentObject(viewModel)
//                }
//
//
//                List(viewModel.prescriptions) { prescription in
//                    ForEach(prescription.medications) { med in
//                        Text("\(med.name) - \(med.dosage)")
//                    }
//                }
//
//                // Invisible ScanView that triggers when tapped
//                ScanView(showPreview: $showPreview)
//                    .environmentObject(viewModel)
//                    .frame(height: 0)
//            }
//            .navigationTitle("Medicine Reminder")
//            .navigationDestination(isPresented: $showPreview) {
//                ScannedTextPreviewView()
//                    .environmentObject(viewModel)
//            }
//        }
//    }
//}
import SwiftUI

struct ScanPrescriptionView: View {
    @State private var showImagePicker = false
    @State private var inputImage: UIImage?
    @State private var scannedText = ""
    @State private var scannedMedications: [ParsedMedication] = []

    @State private var navigateToSummary = false

    let ocrService = TextRecognitionService()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Scan Your Prescription")
                    .font(.title2.bold())

                if let image = inputImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 250)
                }

                Button("Upload Image") {
                    showImagePicker = true
                }
                .padding()
                .background(Color.teal)
                .foregroundColor(.white)
                .cornerRadius(8)

                Button("Scan Text") {
                    if let cgImage = inputImage?.cgImage {
                        ocrService.recognizeText(in: cgImage) { text, meds in
                            scannedText = text
                            scannedMedications = meds
                            navigateToSummary = true
                        }
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)

                Spacer()

                NavigationLink(
                    destination: PrescriptionDetailViewOCR(
                        prescriptionName: "Diabetes Prescription",
                        imageName: "prescription.jpg",
                        medications: scannedMedications
                    ),
                    isActive: $navigateToSummary
                ) {
                    EmptyView()
                }
            }
            .padding()
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(selectedImage: $inputImage)
            }
        }
    }
}
