//
//  ContentView.swift
//  StepTrekker Watch App
//
//  Created by Bratislav Ljubisic Home  on 11/24/24.
//

import SwiftUI



struct ContentView: View {
    @AppStorage("nickName") private var nickName: String = ""
    @State private var editing = false
    
    
    
    var body: some View {
        VStack {
            Text(Date.now, style: .date)
            Spacer()
            if (nickName.isEmpty || editing) {
                TextField("Nickname", text: $nickName)
                    .onSubmit {
                        UserDefaults.standard.set(nickName, forKey: "nickName")
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
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
