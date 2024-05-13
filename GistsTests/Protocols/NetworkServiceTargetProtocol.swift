//
//  NetworkServiceTargetProtocol.swift
//  GistsTests
//
//  Created by Chrystian Salgado on 13/05/24.
//

import Foundation

enum VLNetworkHTTPMethod: String {
    case GET
    case POST
    case PATCH
    case DELETE
}

protocol NetworkServiceTargetProtocol {
    var source: Source { get }
    var baseURL: URL? { get }
    var path: String { get }
    var method: VLNetworkHTTPMethod { get }
    var additionalHeaders: [String: String]? { get }
    var parameters: [String: String] { get }
    var body: [String: Any] { get }
    var timeout: TimeInterval { get }
    var shouldUseAccessToken: (Bool, String?) { get }
    var sessionId: String? { get }
}

extension NetworkServiceTargetProtocol {
    var additionalHeaders: [String: String]? {
        return nil
    }
    
    var sessionId: String? {
        return nil
    }
    
    var timeout: TimeInterval {
        return 60
    }
}

