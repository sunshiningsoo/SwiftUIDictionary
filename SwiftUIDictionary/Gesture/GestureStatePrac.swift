//
//  GestureStatePrac.swift
//  SwiftUIDictionary
//
//  Created by 박성수 on 2022/06/12.
//

import SwiftUI

struct GestureStatePrac: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SimpleLongPressGestureView: View {
    @GestureState var isDetectingLongPress = false

    var longPress: some Gesture {
        LongPressGesture(minimumDuration: 3)
            .updating($isDetectingLongPress) { currentState, gestureState, transaction in
                gestureState = currentState
            }
    }

    var body: some View {
        Circle()
            .fill(self.isDetectingLongPress ? Color.red : Color.green)
            .frame(width: 100, height: 100, alignment: .center)
            .gesture(longPress)
    }
}

struct GestureStatePrac_Previews: PreviewProvider {
    static var previews: some View {
//        GestureStatePrac()
        SimpleLongPressGestureView()
    }
}
