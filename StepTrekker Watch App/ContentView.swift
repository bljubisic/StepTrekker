//
//  ContentView.swift
//  StepTrekker Watch App
//
//  Created by Bratislav Ljubisic Home  on 11/24/24.
//

import SwiftUI



struct ContentView: View {
    @State var nickName: String = UserDefaults.standard.string(forKey: "nickName") ?? ""
    @State private var editing = false
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
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
                }
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView(nickName: "something")
}
