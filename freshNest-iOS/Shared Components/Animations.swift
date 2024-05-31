//
//  Animations.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 09/05/24.
//

import SwiftUI

struct FadeInOutView: View {
    let words: [String]
    @Binding var opacity: Double
    let baseTime: Double
    
    init(text: String, startTime: Double, opacity: Binding<Double>) {
        words = text.components(separatedBy: .whitespacesAndNewlines)
        baseTime = startTime
        self._opacity = opacity
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<words.count) { index in
                Text(self.words[index])
                    .font(.cascaded(ofSize: .h32, weight: .bold))
                    .foregroundColor(.black)
                    .opacity(opacity)
                    .animation(
                        Animation.easeInOut.delay(Double(index) * 0.05),
                        value: opacity
                    )
                if index != self.words.count - 1 {
                    Text(" ")
                }
            }
        }
        .padding(4)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + baseTime){
                self.opacity = 1
            }
        }
        .onTapGesture {
            self.opacity = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                self.opacity = 1
            }
        }
    }
}

