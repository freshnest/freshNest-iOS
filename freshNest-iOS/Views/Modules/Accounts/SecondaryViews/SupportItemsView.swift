//
//  SupportItemsView.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 03/06/24.
//

import SwiftUI

struct SupportItemsView: View {
    let contactNumber = "tel://+13369643199"
    @Environment(\.openURL) var openURL
    let supportEmail = SupportEmail(toAddress: "edd@freshnest.tech", subject: "Support Email")
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Support")
                .font(.cascaded(ofSize: .h24, weight: .medium))
            
            Text("At FreshNest, we're committed to providing you with exceptional service and support. If you have any questions or need assistance, our support team is here to help you.\n\nWhether you prefer to speak with us directly over the phone or reach out via email, we're available to address any concerns and ensure your experience with FreshNest is smooth and enjoyable.\n\nFeel free to call us for immediate assistance or send us an email, and one of our dedicated support representatives will get back to you promptly.")
                .font(.cascaded(ofSize: .h18, weight: .regular))
            Spacer()
            RoundedButton(title: "Call Us", action: {
                if let url = URL(string: self.contactNumber), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }, color: .black, textColor: .white)
            
            RoundedButton(title: "Contact us via Email", action: {
                supportEmail.send(openURL: openURL)
            }, color: .black, textColor: .white)
        }
        .padding(16)
        .background(BackgroundBlurView())
        .navigationBarBackButtonHidden()
    }
}

struct BackgroundBlurView: UIViewRepresentable {
    func makeUIView(context _: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    
    func updateUIView(_: UIView, context _: Context) {}
}


#Preview {
    SupportItemsView()
}
