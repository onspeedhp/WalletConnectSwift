//
//  ContentView.swift
//  WalletConnectSwift
//
//  Created by Châu Khắc on 26/5/25.
//

import SwiftUI
import Solana

struct ContentView: View {
    @State private var amount: String = ""
    @State private var status: String = ""

    // Replace with your actual private key string (Base58 encoded)
    let privateKeyString = "2t1aZHHuq9vrCeHKSZBLs8LqgiNxcQTnUdKZwXX3AX3AiY8c6UDtzApKNMJPtGFU4rhZEw4GWLMMuRMeZjpQrBUo"

    var body: some View {
        VStack(spacing: 20) {
            TextField("Amount (SOL)", text: $amount)
                .keyboardType(.decimalPad)
                .padding()
                .border(Color.gray)

            Button("Send to Random Wallet") {
                Task {
                    await transferSOL()
                }
            }
            .padding()

            Text(status)
                .foregroundColor(.blue)
        }
        .padding()
    }

    func transferSOL() async {
        guard let solAmount = Double(amount), solAmount > 0 else {
            status = "Invalid amount"
            return
        }
        let lamports = UInt64(solAmount * 1_000_000_000)

        do {
            // Decode Base58 private key string to Data
            let secretKeyBytes = Base58.decode(privateKeyString)
            let secretKeyData = Data(secretKeyBytes)
            
            guard let signer = HotAccount(secretKey: secretKeyData) else {
                        status = "Invalid private key"
                        return
                    }
            
            let endpoint = RPCEndpoint.devnetSolana
            let router = NetworkingRouter(endpoint: endpoint)
            let solana = Solana(router: router)
            
            let toPublicKey = "3h1zGmCwsRJnVk5BuRNMLsPaQu1y2aqXqXDWYCgrp5UG"
            
            let transactionId = try await solana.action.sendSOL(
                        to: toPublicKey,
                        from: signer,
                        amount: lamports
            )
           
            let signature = "a" + transactionId
            status = "Success! Tx: )"
        } catch {
            status = "Error: \(error.localizedDescription)"
        }
    }
}

#Preview {
    ContentView()
}

#Preview {
    ContentView()
}
