//
//  TestView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 29/05/24.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea(.all)
            
            Text("Uber")
                .font(.cascaded(ofSize: .h48, weight: .bold))
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    TestView()
}
