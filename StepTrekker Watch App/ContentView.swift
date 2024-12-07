//
//  ContentView.swift
//  StepTrekker Watch App
//
//  Created by Bratislav Ljubisic Home  on 11/24/24.
//

import SwiftUI
import HealthKit


struct ContentView: View {
    @AppStorage("nickName") private var nickName: String = ""
    @State private var editing = false
    @State private var numOfSteps = "0"
    @State var isAuthorized = false
    
    private var healthStore = HKHealthStore()
    private var healthKitManager = HealthKitManager()
    
    
    var body: some View {
        VStack {
            Text(Date.now, style: .date)
            Spacer()
            if (nickName.isEmpty || editing) {
                TextField("Nickname", text: $nickName)
                    .onSubmit {
                        print("Submitted!!")
                        editing = false
                    }
            } else {
                HStack {
                    Text(nickName)
                    Spacer()
                    Button {
                        editing = true
                    } label: {
                        Image(systemName: "pencil")
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                    }
                    .frame(width: 50.0)
                }
            }
            Spacer()
            Text(verbatim: numOfSteps)
        }
        .padding()
        .onAppear {
            changeAuthorizationStatus()
            healthKitManager.readStepCount(forToday: Date(), healthStore: healthStore) { step in
                if step != 0.0 {
                    DispatchQueue.main.async {
                        self.numOfSteps = String(format: "%.0f", step)
                    }
                }
            }
        }
    }
    
    func healthRequest() {
        healthKitManager.setUpHealthRequest(healthStore: healthStore) {
            self.changeAuthorizationStatus()
            self.readStepsTakenToday()
        }
    }
    
    func changeAuthorizationStatus() {
        guard let stepQtyType = HKObjectType.quantityType(forIdentifier: .stepCount) else { return }
        let status = self.healthStore.authorizationStatus(for: stepQtyType)
        
        switch status {
        case .notDetermined:
            isAuthorized = false
        case .sharingDenied:
            isAuthorized = false
        case .sharingAuthorized:
            DispatchQueue.main.async {
                self.isAuthorized = true
            }
        @unknown default:
            isAuthorized = false
        }
    }
    
    func readStepsTakenToday() {
        healthKitManager.readStepCount(forToday: Date(), healthStore: healthStore) { step in
            if step != 0.0 {
                DispatchQueue.main.async {
                    self.numOfSteps = String(format: "%.0f", step)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
