//
//  ZStackAndOverlay.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/11/20.
//

import SwiftUI

struct ZStackAndOverlay: View {
    var body: some View {
        VStack {
            ZStack {
                Image(systemName: "pencil")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                Image(systemName: "bicycle")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.black)
            }
            .clipped()
            Image(systemName: "pencil")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
                .overlay {
                    Image(systemName: "bicycle")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .foregroundColor(.black)
                }
                .clipped()
            
        }
    }
}

struct ZStackAndOverlay_Previews: PreviewProvider {
    static var previews: some View {
        ZStackAndOverlay()
    }
}
