//
//  ConstitutionViewModel.swift
//  Samvidhan
//
//  Created by Mekala Vamsi Krishna on 5/10/26.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class ConstitutionViewModel: ObservableObject {
    @Published var preamble: Preamble?
    @Published var parts: [Part] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    func loadConstitutionData() {
        isLoading = true
        errorMessage = nil
        
        // First try to load from local JSON file
        if let url = Bundle.main.url(forResource: "constitution", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                
                // Print raw JSON for debugging
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("JSON loaded successfully. Length: \(jsonString.count) characters")
                }
                
                let decoder = JSONDecoder()
                let response = try decoder.decode(ConstitutionResponse.self, from: data)
                
                self.preamble = response.constitution.preamble
                self.parts = response.constitution.parts
                self.isLoading = false
                
                print("Data parsed successfully. Parts count: \(self.parts.count)")
                print("Preamble title: \(self.preamble?.title ?? "nil")")
                
            } catch let decodingError as DecodingError {
                // Detailed decoding error handling
                var errorDetail = ""
                switch decodingError {
                case .typeMismatch(let type, let context):
                    errorDetail = "Type mismatch: \(type) - \(context.debugDescription)"
                case .valueNotFound(let type, let context):
                    errorDetail = "Value not found: \(type) - \(context.debugDescription)"
                case .keyNotFound(let key, let context):
                    errorDetail = "Key '\(key.stringValue)' not found: \(context.debugDescription)"
                case .dataCorrupted(let context):
                    errorDetail = "Data corrupted: \(context.debugDescription)"
                @unknown default:
                    errorDetail = "Unknown decoding error"
                }
                
                DispatchQueue.main.async {
                    self.errorMessage = "Decoding error: \(errorDetail)"
                    self.isLoading = false
                }
                print("❌ Decoding error: \(errorDetail)")
                
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Error loading data: \(error.localizedDescription)"
                    self.isLoading = false
                }
                print("❌ General error: \(error)")
            }
        } else {
            DispatchQueue.main.async {
                self.errorMessage = "constitution.json file not found in bundle"
                self.isLoading = false
            }
            print("❌ JSON file not found in bundle")
            
            // List all files in bundle for debugging
            if let bundlePath = Bundle.main.resourcePath {
                do {
                    let files = try FileManager.default.contentsOfDirectory(atPath: bundlePath)
                    print("📁 Files in bundle: \(files.filter { $0.hasSuffix(".json") })")
                } catch {
                    print("Could not list bundle contents")
                }
            }
        }
    }
    
    func getArticlesForPart(_ partId: Int) -> [Article] {
        return parts.first(where: { $0.partId == partId })?.articles ?? []
    }
    
    func getPartById(_ partId: Int) -> Part? {
        return parts.first(where: { $0.partId == partId })
    }
}
