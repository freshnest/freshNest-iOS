//
//  StripeVC.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 24/07/24.
//

import SwiftUI
import StripeFinancialConnections

class ViewController: UIViewController {
  @IBOutlet weak var connectFinancialAccountButton: UIButton!
  var financialConnectionsSheet: FinancialConnectionsSheet?
  let backendCheckoutUrl = URL(string: "Your backend endpoint")! // Your backend endpoint

  override func viewDidLoad() {
    super.viewDidLoad()

    connectFinancialAccountButton.addTarget(self, action: #selector(didTapConnectFinancialAccountButton), for: .touchUpInside)
    connectFinancialAccountButton.isEnabled = false

    // MARK: Fetch the FinancialConnectionsSession client secret and publishable key
    var request = URLRequest(url: backendCheckoutUrl)
    request.httpMethod = "POST"
    let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
      guard let data = data,
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
            let clientSecret = json["client_secret"] as? String,
            let publishableKey = json["publishable_key"] as? String,
            let self = self else {
        // Handle error
        return
      }

      // MARK: Set your Stripe publishable key - this allows the SDK to make requests to Stripe for your account
      STPAPIClient.shared.publishableKey = publishableKey

      self.financialConnectionsSheet = FinancialConnectionsSheet(
        financialConnectionsSessionClientSecret: clientSecret,
        returnURL: "https://your-app-domain.com/stripe-redirect"
      )

      DispatchQueue.main.async {
        self.connectFinancialAccountButton.isEnabled = true
      }
    })
    task.resume()
  }

    @objc
    func didTapConnectFinancialAccountButton() {
      // MARK: Start the financial connections flow
      financialConnectionsSheet?.present(
        from: self,
        completion: { result in
            switch result {
            case .completed(session: let financialConnectionsSession):
                let accounts = financialConnectionsSession.accounts.data.filter { $0.last4 != nil }
                let accountInfos = accounts.map { "\($0.institutionName) ....\($0.last4!)" }
                print("Completed with \(accountInfos.joined(separator: "\n")) accounts")
            case .canceled:
                print("Canceled!")
            case .failed(let error):
                print("Failed!")
                print(error)
            }
      })
    }
}
