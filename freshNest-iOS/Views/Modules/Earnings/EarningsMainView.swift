//
//  EarningsMainView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 08/05/24.
//

import SwiftUI

struct EarningsMainView: View {
    @State private var isFirstCard = false
    @State private var showCardDetailsEntryBottomSheet = false
    @State private var showEarningListView = false
    @State private var animate = false

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                VStack(spacing: 24) {
                    ZStack {
                        Spacer()
                        Text("Earnings")
                            .font(.system(size: 28, weight: .bold))
                            .accessibility(addTraits: .isHeader)
                            .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                        Spacer()
                    }
                    CardView(cardNumber: "1234123412341234", accountHolderName: "John Doe", expiry: "12/31", isStatic: true)
                        .modifier(HoloEffect(animate: $animate))
                        .onAppear {
                            self.animate = true
                        }
                    
                    
                    Button(action: {
                        showCardDetailsEntryBottomSheet.toggle()
                    }){
                        RoundedRectangle(cornerRadius: 16)
                            .frame(width: 315, height: 200)
                            .foregroundColor(Color(hex: "#12121D").opacity(0.05))
                            .shadow(color: Color.gray.opacity(0.2), radius: 8, x: 0, y: 2)
                            .overlay {
                                VStack {
                                    Image(systemName: "plus")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                    Text(isFirstCard ? "Add New Card" : "Add Different Card")
                                        .font(.system(size: 14, weight: .regular))
                                }
                                .foregroundColor(.black)
                            }
                    }
                    
                    Spacer()
                    
                    RoundedButton(title: "View Earnings", action: {
                        showEarningListView.toggle()
                    }, color: Color(hex: AppUserInterface.Colors.appButtonBlack), textColor: .white)
                    
                }
            }
            .padding(16)
        }
        .sheet(isPresented: $showCardDetailsEntryBottomSheet, content: {
            CardDetailsEntryBottomSheet()
                .presentationDetents([.large])
        })
        .fullScreenCover(isPresented: $showEarningListView, content: {
            EarningListView()
        })
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    EarningsMainView()
//    CardView(cardNumber: "1234123412341234", accountHolderName: "John Doe", expiry: "12/31", isStatic: true)
//    CardDetailsEntryBottomSheet()
}
