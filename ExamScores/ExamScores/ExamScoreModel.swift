//
//  ExamScoreModel.swift
//  ExamScores
//
//  Created by David Fekke on 3/3/26.
//

import SwiftUI
import CoreML
import Combine

public class ExamScoreModel: ObservableObject {
    
    @Published var score: Double = 0.0
    private let model: regression_model
    
    init() {
        self.model = try! regression_model(configuration: .init())
    }
    
    func predict(study_hours: Double,
                 class_attendance: Double,
                 sleep_quality: Double,
                 study_method_coaching: Double,
                 facility_rating: Double,
                 sleep_hours: Double) {
        do {
            let output = try model.prediction(
                study_hours: study_hours,
                class_attendance: class_attendance,
                sleep_quality: sleep_quality,
                study_method_coaching: study_method_coaching,
                facility_rating: facility_rating,
                sleep_hours: sleep_hours
            )
            
            self.score = output.predicted_score
        }
        catch {
            print("Prediction failed", error)
        
        }
    }
}
