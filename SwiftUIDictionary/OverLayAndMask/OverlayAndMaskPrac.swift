//
//  OverlayAndMaskPrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/08/28.
//

import SwiftUI

// REF: https://www.youtube.com/watch?v=pxx1ueCbnls

struct OverlayAndMaskPrac: View {
    
    @State var rating: Int = 3
    
    var body: some View {
        
        ZStack {
            HStack(spacing: 20) {
                ForEach(1..<6) { index in
                    Image(systemName: "star.fill")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                        .onTapGesture {
                            withAnimation(.spring()){
                                rating = index
                            }
                        }
                }
            }
            .overlay(
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color.yellow)
                            .frame(width: CGFloat(rating) / 5 * geo.size.width)
                    }
                }
                .allowsHitTesting(false)
                // 오버레이된 rectangle을 터치되지 않게 만들어주어, 별이미지를 클릭하게 만들어 그 index만큼 색상이 차게 만들어 준다.
            ).mask {
                // overlay 한 rectangle에 대한 mask를 걸어준다.
                // mask 한 UI의 모양대로 나오게됨
                HStack(spacing: 20) {
                    ForEach(1..<6) { index in
                        Image(systemName: "star.fill")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    rating = index
                                }
                            }
                    }
                }
            }
        }
    }
}

struct OverlayAndMaskPrac_Previews: PreviewProvider {
    static var previews: some View {
        OverlayAndMaskPrac()
    }
}
