//
//  Networking+Utils.swift
//  InstaNorris
//
//  Created by Aline Borges on 30/04/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import RxSwift
import Moya

func jsonSerializedUTF8(json: [String: Any]) -> Data {
    do {
        return try JSONSerialization.data(
            withJSONObject: json,
            options: [.prettyPrinted]
        )
    } catch {
        return Data()
    }
}

func arrayJsonSerializedUTF8(json: [String]) -> Data {
    do {
        return try JSONSerialization.data(
            withJSONObject: json,
            options: [.prettyPrinted]
        )
    } catch {
        return Data()
    }
}

func stringArrayToData(array: [String]) -> Data {
    let data = NSMutableData()
    let terminator = [0]
    for string in array {
        if let encodedString = string.data(using: String.Encoding.utf8) {
            data.append(encodedString)
            data.append(terminator, length: 1)
        }
        else {
            NSLog("Cannot encode string \"\(string)\"")
        }
    }
    print(data as Data)
    return data as Data
}
