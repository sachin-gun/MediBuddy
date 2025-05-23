//
//  TextRecognitionService.swift
//  MedicineReminder
//
//  Created by Sachin Gunawardena on 2025-04-14.
//

import Vision
import Foundation
import CoreImage
import CoreImage.CIFilterBuiltins

class TextRecognitionService {
    func recognizeText(in image: CGImage, completion: @escaping (String, [ParsedMedication]) -> Void) {
        let request = VNRecognizeTextRequest { (request, error) in
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                completion("", [])
                return
            }

            let rawText = observations
                .compactMap { $0.topCandidates(1).first?.string }
                .joined(separator: "\n")

            print("🔍 OCR Output:\n\(rawText)")
            let meds = self.parseMedications(from: rawText)
            completion(rawText, meds)
        }

        request.recognitionLevel = .accurate

        let processedImage = preprocessImage(image) ?? image
        let handler = VNImageRequestHandler(cgImage: processedImage, options: [:])
        try? handler.perform([request])
    }

    private func parseMedications(from text: String) -> [ParsedMedication] {
        let lines = text.components(separatedBy: .newlines).filter { $0.first?.isNumber == true }

        var medications: [ParsedMedication] = []

        for line in lines {
            let components = line.components(separatedBy: "-")
            guard components.count == 2 else { continue }

            let leftPart = components[0].trimmingCharacters(in: .whitespaces)
            let duration = components[1].trimmingCharacters(in: .whitespaces)

            let trimmed = leftPart.drop(while: { $0 != "." }).dropFirst().trimmingCharacters(in: .whitespaces)


            let dosagePattern = #"(\d+\s?(?:mg|units|Caps))"#
            if let dosageRange = trimmed.range(of: dosagePattern, options: .regularExpression) {
                let name = String(trimmed[..<dosageRange.lowerBound]).trimmingCharacters(in: .whitespaces)
                let dosage = String(trimmed[dosageRange])
                let instructions = String(trimmed[dosageRange.upperBound...]).trimmingCharacters(in: .whitespaces)

                medications.append(ParsedMedication(name: name, dosage: dosage, instructions: instructions, duration: duration))
            } else {
                medications.append(ParsedMedication(name: trimmed, dosage: "N/A", instructions: "N/A", duration: duration))
            }
        }

        return medications
    }
    
    private func preprocessImage(_ cgImage: CGImage) -> CGImage? {
        let ciImage = CIImage(cgImage: cgImage)
        let context = CIContext()

        let grayscale = CIFilter.colorControls()
        grayscale.inputImage = ciImage
        grayscale.saturation = 0
        grayscale.brightness = 0.0
        grayscale.contrast = 1.2

        let exposure = CIFilter.exposureAdjust()
        exposure.inputImage = grayscale.outputImage
        exposure.ev = 0.7

        if let outputImage = exposure.outputImage,
           let cgOutput = context.createCGImage(outputImage, from: outputImage.extent) {
            return cgOutput
        }

        return nil
    }
}
