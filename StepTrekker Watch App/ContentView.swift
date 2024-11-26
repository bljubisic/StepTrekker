//
//  ContentView.swift
//  StepTrekker Watch App
//
//  Created by Bratislav Ljubisic Home  on 11/24/24.
//

import SwiftUI



struct ContentView: View {
    @State var nickName: String
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            TextField("Nickname", text: $nickName)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView(nickName: "something")
}
