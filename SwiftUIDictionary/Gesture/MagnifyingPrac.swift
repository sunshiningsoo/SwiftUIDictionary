//
//  MagnifyingPrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/08/27.
//

import SwiftUI

struct MagnifyingPrac: View {
    // Magnifying 모션을 시뮬레이터에서 감지하려면 option을 클릭하고 드래그를 하면 된다.
    @State var currentScale: CGFloat = 0
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(height: 300)
                .scaleEffect(1 + currentScale) // 스케일은 1이 지정해준 크기
                .gesture(
                    MagnificationGesture()
                        .onChanged({ value in
                            // value는 기존 스케일 1에서 커지면 1보다 큰 수로
                            // 작아지면 1보다 작은 수로 변화함
                            currentScale = value - 1
                        })
                        .onEnded({ value in
                            withAnimation(.spring()) {
                                currentScale = 0
                            }
                        })
                )
        }
    }
}

struct MagnifyingPrac_Previews: PreviewProvider {
    static var previews: some View {
        MagnifyingPrac()
    }
}
