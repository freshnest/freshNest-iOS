//
//  GlassBackground.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 26/06/24.
//

import SwiftUI

struct GlassBackGround: View {
    let color: Color
    var body: some View {
        ZStack{
            RadialGradient(colors: [.clear, color],
                           center: .center,
                           startRadius: 1,
                           endRadius: 100)
                .opacity(0.6)
            Rectangle().foregroundColor(color)
        }
        .opacity(0.2)
        .blur(radius: 2)
        .cornerRadius(10)
        .ignoresSafeArea(.all)
    }
}

