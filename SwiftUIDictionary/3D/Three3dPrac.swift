//
//  Three3dPrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/04/24.
//

import SwiftUI

struct Three3dPrac: View {
    @State private var degrees = 0.0
    @State private var rotateX = true
    @State private var rotateY = true
    @State private var rotateZ = true
    
    var body: some View {
        VStack(spacing: 30) {
            Toggle("Rotate X-axis", isOn: $rotateX)
            Toggle("Rotate Y-axis", isOn: $rotateY)
            Toggle("Rotate Z-axis", isOn: $rotateZ)
            Button("Hello World") {
                withAnimation(.easeIn(duration: 1)) {
                    self.degrees += 360
                }
            }
            .padding(20)
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(20)
            .rotation3DEffect(.degrees(degrees), axis: (x: rotateX ? 1 : 0, y: rotateY ? 1 : 0, z: rotateZ ? 1 : 0))
        }
        .padding()
    }
}

struct ThreedPrac_Previews: PreviewProvider {
    static var previews: some View {
        Three3dPrac()
    }
}
