//
//  JobCardCell.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 07/05/24.
//

import SwiftUI

struct JobCardCell: View {
    var data: JobModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if data.jobType == .available {
                HStack(alignment: .center) {
                    Text(getFormattedTime())
                        .foregroundStyle(.white)
                        .font(.cascaded(ofSize: .h14, weight: .regular))
                }
                .padding(4)
                .frame(maxWidth: 70, alignment: .leading)
                .background(Color.black)
                .padding(.leading, -16)
                .padding(.top, -16)
                .padding(.bottom, -8)
            }
            HStack {
                Text(data.amount)
                    .font(.cascaded(ofSize: .h22, weight: .medium))
                    .foregroundColor(Color.black.opacity(0.9))
                    .lineLimit(1)
                
                Spacer()
                
                Text(data.workItems)
                    .font(.cascaded(ofSize: .h22, weight: .medium))
                    .foregroundColor(Color.black.opacity(0.5))
                    .lineLimit(1)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(data.timeToDestination)
                    .font(.cascaded(ofSize: .h18, weight: .medium))
                    .foregroundColor(Color.black.opacity(0.9))
                    .lineLimit(1)
                Text(data.address)
                    .font(.cascaded(ofSize: .h16, weight: .medium))
                    .foregroundColor(Color.black.opacity(0.9))
                    .lineLimit(1)
            }
            RoundedButton(title: data.jobType == .scheduled ? getFormattedTime() : "View Job Info", action: {}, color: Color(hex: AppUserInterface.Colors.appButtonBlack), textColor: .white)
        }
        .padding()
        .frame(maxWidth: 400, alignment: .leading)
        .background(Color(hex: "#F7F7F7"))
        .cornerRadius(10)
//        .shadow(color: Color.gray.opacity(0.4), radius: 8, x: 0, y: 2)
    }
    
    func getFormattedTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = data.jobType == .scheduled ? "MMMM dd, yyyy" : "MM/dd/yy"
        return dateFormatter.string(from: data.date)
    }
}

struct JobCardCell_Previews: PreviewProvider {
    static var previews: some View {
        let data = JobModel(jobType: .scheduled, amount: "$100", workItems: "2Bed 1Bath", timeToDestination: "15min away", address: "Fenway, Boston, Massachusetts", date: Date())
        JobCardCell(data: data)
    }
}

