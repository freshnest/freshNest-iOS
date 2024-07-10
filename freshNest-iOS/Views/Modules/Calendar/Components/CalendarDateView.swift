//
//  CalendarDateView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 10/07/24.
//

import SwiftUI

struct CalendarDateView: View {
    var date: Date
    var isSelected: Bool
    var hasJob: Bool
    var action: () -> Void
    @State var translation: CGSize = .zero
    @State var offset = 0.0
    
    init(date: Date, isSelected: Bool, hasJob: Bool, action: @escaping () -> Void) {
        self.date = date
        self.isSelected = isSelected
        self.hasJob = hasJob
        self.action = action
        
        let key = DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .none)
    }
    
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 4) {
                if hasJob {
                    HStack(spacing: 2) {
                        Circle()
                            .foregroundStyle(.blue)
                            .frame(width: 4, height: 4)
                    }
                }
                Text(String(format: "%02d", Calendar.current.component(.day, from: date)))
                    .font(.cascaded(ofSize: .h24, weight: .bold))
                    .foregroundColor(.black.opacity(0.7))
                
                Text(date.weekdayLetter).textCase(.uppercase)
                    .font(.cascaded(ofSize: .h12, weight: .regular))
                    .foregroundColor(isSelected ? .black : .gray)
                
                if isSelected {
                    withAnimation(.easeInOut(duration: 0.3)){
                        RoundedRectangle(cornerRadius: 2)
                            .frame(width: 20, height: 2)
                    }
                }
                
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isSelected ?Color.black.opacity(0.3) :Color.black.opacity(0.1), lineWidth: 1)
                    .foregroundStyle(.gray)
            )
            .scaleEffect(isSelected ? 1.3 : 1)
        }
        .padding(4)
        .buttonStyle(PlainButtonStyle())
        .onTapGesture {
            action()
        }
    }
}
