//
//  ConstantHolder.swift
//  Storj
//
//  Created by Koray Koska on 18/09/2017.
//

import Foundation
import LibStorj

struct ConstantHolder {

    struct APIValues {

        static let apiProto: StorjBridgeOptionsProto = .https
        static let apiUrl = "api.storj.io"
        static let apiPort: Int32 = 443
    }
}
