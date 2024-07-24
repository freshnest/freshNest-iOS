//
//  EarningListView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 17/05/24.
//

import SwiftUI
import Functions
import Combine
import WebKit

struct EarningListView: View {
    @EnvironmentObject var supabaseClient: SupabaseManager

    @State private var isStripeIntegrated = false
    @State private var showStripeWebView = false

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Earnings")
                    .font(.cascaded(ofSize: .h28, weight: .bold))
                    .accessibility(addTraits: .isHeader)
                    .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                Spacer()
            }
            if isStripeIntegrated {
               BalanceCard()
            } else {
                Button(action: {
                    print("Stripe Integrate button tapped!")
                    supabaseClient.createStripeAccount()
                }){
                    RoundedRectangle(cornerRadius: 16)
                        .frame(height: 100)
                        .foregroundColor(Color(hex: "#12121D").opacity(0.05))
                        .shadow(color: Color.gray.opacity(0.2), radius: 8, x: 0, y: 2)
                        .overlay {
                            VStack {
                                Image(systemName: "link")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                Text("Integrate your Stripe account with FreshNest")
                                    .font(.cascaded(ofSize: .h14, weight: .regular))
                            }
                            .foregroundColor(.black)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
            }
            
            Text("Recent Earnings")
                .font(.cascaded(ofSize: .h24, weight: .medium))
                .padding(.top, 32)
           
            ScrollView(showsIndicators: false) {
                if !earnings.isEmpty {
                    VStack(alignment: .center) {
                        EmptyStateView(message: "You don't have any earnings currently.", imageText: "💳")
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                } else {
                    ForEach(earnings, id: \.self) { item in
                        EarningListViewCell(address: item.address, date: item.date, amount: item.amount)
                    }
                }
            }
           
        }
        .padding(16)
        .onReceive(supabaseClient.$stripeURL) { url in
            if let url = url {
                self.showStripeWebView = true
            }
        }
        .sheet(isPresented: $showStripeWebView) {
            if let url = supabaseClient.stripeURL {
                WebView(url: url)
            }
        }
    }
    
    private func BalanceCard() -> some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.white)
            .frame(maxWidth: .infinity)
            .frame(maxHeight: 120)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: -5, y: -5)
            .shadow(color: Color.white.opacity(0.7), radius: 10, x: 5, y: 5)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
            .overlay(
                VStack(alignment: .leading, spacing: 10) {
                    Text("Balance")
                        .font(.cascaded(ofSize: .h16, weight: .medium))
                    Text("$ 1355.97")
                        .font(.cascaded(ofSize: .h42, weight: .bold))
                        .foregroundStyle(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(hex: AppUserInterface.Colors.gradientColor1),
                                    Color(hex: AppUserInterface.Colors.gradientColor1),
                                    Color(hex: AppUserInterface.Colors.gradientColor3)
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            ))
                    Text("All pending amount will be added once they are verified.")
                        .font(.cascaded(ofSize: .h12, weight: .regular))
                        .foregroundColor(.gray)
                }
                    .padding(.leading, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
            )
    }
}

#Preview {
    EarningListView()
//    EarningListViewCell()
}

extension SupabaseManager {
    func createStripeAccount() {
        Task {
            do {
                let response: String = try await supabase
                    .functions
                    .invoke("create-stripe-account",
                            options: FunctionInvokeOptions(
                                body: ["email": "nathanielfrederick78@gmail.com"]
                            ),
                            decode: { data, response in
                        
                        if let stringData = String(data: data, encoding: .utf8) {
                            print("Data from create-stripe-account", stringData)
                            print("Response from create-stripe-account", response)
                            return stringData
                        } else {
                            print("Dailed to decode data during create-stripe-account")
                            return ""
                        }
                    })
                if let responseData = response.data(using: .utf8),
                   let json = try? JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any],
                   let urlString = json["success"] as? String,
                   let url = URL(string: urlString) {
                    DispatchQueue.main.async {
                        self.stripeURL = url
                    }
                }
            } catch {
                print("Error while creating stripe account:", error.localizedDescription)
            }
        }
    }
}

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
