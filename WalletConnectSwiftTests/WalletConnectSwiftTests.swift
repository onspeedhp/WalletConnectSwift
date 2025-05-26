//
//  WalletConnectSwiftTests.swift
//  WalletConnectSwiftTests
//
//  Created by Châu Khắc on 26/5/25.
//

import Testing
import Solana
@testable import WalletConnectSwift

struct WalletConnectSwiftTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        let endpoint = RPCEndpoint.devnetSolana
        let router = NetworkingRouter(endpoint: endpoint)
        let solana = Solana(router: router)
        
        let account = HotAccount()

    }

}
