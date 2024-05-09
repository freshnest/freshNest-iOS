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
                        .font(.system(size: 14, weight: .regular))
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
                    .font(.system(size: 22, weight: .medium))
                    .foregroundColor(Color.black.opacity(0.9))
                    .lineLimit(1)
                
                Spacer()
                
                Text(data.workItems)
                    .font(.system(size: 22, weight: .medium))
                    .foregroundColor(Color.black.opacity(0.5))
                    .lineLimit(1)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(data.timeToDestination)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(Color.black.opacity(0.9))
                    .lineLimit(1)
                Text(data.address)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color.black.opacity(0.9))
                    .lineLimit(1)
            }
            RoundedButton(title: data.jobType == .scheduled ? getFormattedTime() : "Match", action: {}, color: Color(hex: AppUserInterface.Colors.appButtonBlack), textColor: .white)
        }
        .padding()
        .frame(maxWidth: 400, alignment: .leading)
        .background(Color(hex: "#F7F7F7"))
        .cornerRadius(10)
//        .shadow(color: Color.gray.opacity(0.4), radius: 8, x: 0, y: 2)
    }
    
    func getFormattedTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = data.jobType == .scheduled ? "dd MMMM yyyy" : "dd/MM/yy"
        return dateFormatter.string(from: data.date)
    }
}

struct JobCardCell_Previews: PreviewProvider {
    static var previews: some View {
        let data = JobModel(jobType: .available, amount: "$100", workItems: "2Bed 1Bath", timeToDestination: "15min away", address: "Fenway, Boston, Massachusetts", date: Date())
        JobCardCell(data: data)
    }
}

