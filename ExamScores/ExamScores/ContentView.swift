//
//  ContentView.swift
//  ExamScores
//
//  Created by David Fekke on 3/3/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = ExamScoreModel()
    @State private var studyHours: Double = 0
    // Add class_attendance', 'sleep_quality', 'study_method_coaching', 'facility_rating', 'sleep_hours'
    @State private var classAttendance: Double = 0
    @State private var sleepQuality: Double = 0
    @State private var studyMethodCoaching: Bool = false
    @State private var facilityRating: Double = 0
    @State private var sleepHours: Double = 0
    
    private func performPrediction() {
        vm.predict(
            study_hours: studyHours,
            class_attendance: classAttendance,
            sleep_quality: sleepQuality,
            study_method_coaching: studyMethodCoaching ? 1.0 : 0.0,
            facility_rating: facilityRating,
            sleep_hours: sleepHours
        )
    }
    
    var body: some View {
        VStack {
            Text("Predict Exam Score")
                .font(.title)
            
            HStack {
                Text("Study Hours: \(studyHours, format: .number.precision(.fractionLength(0)))")
                Slider(value: self.$studyHours, in: 4...10, step: 1)
                    .onChange(of: studyHours) { oldValue, newValue in
                        performPrediction()
                    }
                
            }
            HStack {
                Text("Class Attendance: \(classAttendance, format: .number.precision(.fractionLength(0)))")
                Slider(value: self.$classAttendance, in: 40...100, step: 1)
                    .onChange(of: classAttendance) { oldValue, newValue in
                        performPrediction()
                    }
                
            }
            HStack {
                Text("Sleep Quality: \(sleepQuality, format: .number.precision(.fractionLength(0)))")
                Slider(value: self.$sleepQuality, in: 0...2, step: 1)
                    .onChange(of: sleepQuality) { oldValue, newValue in
                        performPrediction()
                    }
                
            }
            HStack {
                Toggle("Study Method Coaching", isOn: self.$studyMethodCoaching)
                    .onChange(of: studyMethodCoaching) { oldValue, newValue in
                        performPrediction()
                    }
                
            }
            HStack {
                Text("Facility Rating: \(facilityRating, format: .number.precision(.fractionLength(0)))")
                Slider(value: self.$facilityRating, in: 0...2, step: 1)
                    .onChange(of: facilityRating) { oldValue, newValue in
                        performPrediction()
                    }
                
            }
            HStack {
                Text("Sleep Hours: \(sleepHours, format: .number.precision(.fractionLength(0)))")
                Slider(value: self.$sleepHours, in: 0...10, step: 1)
                    .onChange(of: sleepHours) { oldValue, newValue in
                        performPrediction()
                    }
            }
            
            Button("Predict") {
                performPrediction()
            }
            
            if vm.score >= 0 {
                Text("Predicted exam score: \(vm.score, format: .number.precision(.fractionLength(2)))")
                    .font(.headline)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
