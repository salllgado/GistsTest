//
//  GistExtensions.swift
//  GistsTestsTests
//
//  Created by Chrystian Salgado on 15/05/24.
//

import Foundation
@testable import GistsTests

extension User {
    
    static func fixture() -> User {
        return .init(login: "dummy login value")
    }
}

extension Owner {
    
    static func fixture() -> Owner {
        return .init(login: "dummy login value", id: 0000, avatarUrl: .init(string: "www.dummy.com")!, url: "www.dummy.com")
    }
}

extension FileDetail {
    
    static func fixture() -> FileDetail {
        return .init(filename: "DummyFileName", type: "none", language: "us-UK", rawUrl: "", size: 1)
    }
}

extension Gist {
    
    static func fixture() -> Gist {
        return Gist(url: "https://dummy.com", id: UUID().uuidString, files: ["anyValue": .fixture()], user: .fixture(), owner: .fixture())
    }
}
