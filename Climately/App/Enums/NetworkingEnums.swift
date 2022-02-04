//
//  NetworkingEnums.swift
//  Climately
//
//  Created by Mohammad Yasir on 04/02/22.
//

import SwiftUI

public enum NetworkError: Error {
    case wrongURL, timeOut, dataNotFound
}

public enum NetworkMethods: String {
    case GET = "GET"
    case POST = "POST"
}

