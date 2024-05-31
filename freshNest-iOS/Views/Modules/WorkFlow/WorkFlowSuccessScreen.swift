//
//  WorkFlowSuccessScreen.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 16/05/24.
//

import SwiftUI

struct WorkFlowSuccessScreen: View {
    @State private var showHomeScreen = false
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Circle()
                    .frame(width: 70, height: 70)
                    .foregroundStyle( 
                        LinearGradient(
                        gradient: Gradient(colors: [Color(hex: AppUserInterface.Colors.gradientColor1), Color(hex: AppUserInterface.Colors.gradientColor1), Color(hex: AppUserInterface.Colors.gradientColor3)]),
                        startPoint: .top,
                        endPoint: .bottom
                    ))
                    .overlay {
                        ZStack(alignment: .center) {
                            Image(systemName: "checkmark")
                                .font(.largeTitle).bold()
                                .foregroundStyle(.white)
                        }
                    }
                Spacer()
            }
            Text("Great work! Your job is being reviewed for approval. \n\nWe will notify you when it's approved.")
                .font(.cascaded(ofSize: .h24, weight: .medium))
            
            Spacer()
            
            RoundedButton(title: "Done", action: {
                showHomeScreen.toggle()
            }, color: .black, textColor: .white)
        }
        .padding(16)
        .navigationBarBackButtonHidden()
        .fullScreenCover(isPresented: $showHomeScreen, content: {
            MainView()
        })
    }
}

#Preview {
    WorkFlowSuccessScreen()
}
