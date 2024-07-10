//
//  ScheduledJobCardCell.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 10/07/24.
//

import SwiftUI

struct ScheduledJobCardCell: View {
    @StateObject private var viewModel: ScheduledJobCardViewModel
    @EnvironmentObject var supabaseClient: SupabaseManager

    init(data: ScheduledJobsModel) {
        _viewModel = StateObject(wrappedValue: ScheduledJobCardViewModel(data: data))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            headerView
            navigationLinks
            locationView
            actionButton
        }
        .padding()
        .frame(maxWidth: 400, alignment: .leading)
        .background(Color(hex: "#F7F7F7"))
        .cornerRadius(10)
        .onAppear {
            Task {
                await viewModel.checkJobStatus(supabaseClient: supabaseClient)
            }
        }
    }

    private var headerView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 16) {
                dateView
                priceView
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 0) {
                statusView
                roomInfoView
            }
        }
    }

    private var dateView: some View {
        Text(viewModel.formattedDate)
            .foregroundStyle(.white)
            .font(.cascaded(ofSize: .h14, weight: .regular))
            .padding(4)
            .frame(maxWidth: 70, alignment: .leading)
            .background(Color.black)
            .padding(.leading, -16)
            .padding(.top, -16)
            .padding(.bottom, -8)
    }

    private var priceView: some View {
        Text("$\(viewModel.data.price ?? "")")
            .font(.cascaded(ofSize: .h22, weight: .medium))
            .foregroundColor(Color.black.opacity(0.9))
            .lineLimit(1)
    }

    private var statusView: some View {
        Group {
            if viewModel.isJobInReview {
                Text(viewModel.statusText)
                    .foregroundStyle(viewModel.statusColor)
                    .font(.cascaded(ofSize: .h16, weight: .bold))
            }
        }
    }

    private var roomInfoView: some View {
        Text("\(viewModel.data.bedroom ?? 0) Bed, \(viewModel.data.bathroom ?? 0) Bath")
            .font(.cascaded(ofSize: .h22, weight: .medium))
            .foregroundColor(Color.black.opacity(0.5))
            .lineLimit(1)
    }

    private var navigationLinks: some View {
        ZStack {
            NavigationLink(destination: WorkFlowInReviewScreen(), tag: 1, selection: $viewModel.navigation) { EmptyView() }
            NavigationLink(destination: WorkFlowCompletedScreen(), tag: 2, selection: $viewModel.navigation) { EmptyView() }
            NavigationLink(destination: WorkFlowView(data: $viewModel.tasklistInfo, dateTime: viewModel.data.dateTime), tag: 3, selection: $viewModel.navigation) { EmptyView() }
        }
        .opacity(0)
        .frame(width: 0, height: 0)
    }

    private var locationView: some View {
        Text("Location: \(viewModel.data.addressJSON?.street ?? ""), \(viewModel.data.addressJSON?.city ?? ""), \(viewModel.data.addressJSON?.state ?? "")")
            .font(.cascaded(ofSize: .h16, weight: .medium))
            .foregroundColor(Color.black.opacity(0.9))
            .lineLimit(1)
    }

    private var actionButton: some View {
        NotSoRoundedButton(title: "View Job Info", action: {
            Task {
                await viewModel.viewJobInfo(supabaseClient: supabaseClient)
            }
        }, color: Color(hex: AppUserInterface.Colors.appButtonBlack), textColor: .white)
    }
}

