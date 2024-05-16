//
//  Gists.swift
//  GistsTests
//
//  Created by Chrystian Salgado on 13/05/24.
//

import Foundation

struct Gist: Decodable {
    let url: String
    let id: String
    let files: [String: FileDetail]
    let user: User?
    let owner: Owner
    
    enum CodingKeys: String, CodingKey {
        case url
        case id
        case files
        case user
        case owner
    }
    
    func toGistSimplified() -> GistSimplified{
        return .init(id: id, userImageURL: owner.avatarUrl, userName: owner.login, files: files)
    }
}

struct FileDetail: Decodable {
    let filename: String
    let type: String
    let language: String?
    let rawUrl: String
    let size: Int
    
    enum CodingKeys: String, CodingKey {
        case filename
        case type
        case language
        case rawUrl = "raw_url"
        case size
    }
}

struct User: Decodable {
    let login: String
}

struct Owner: Decodable {
    let login: String
    let id: Int
    let avatarUrl: URL
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case id
        case avatarUrl = "avatar_url"
        case url
    }
}

struct GistSimplified {
    let id: String
    let userImageURL: URL
    let userName: String
    let files: [String: FileDetail]
    
    func getFileCountText() -> String {
        files.count > 1 ? "Files \(files.count)" : "File \(files.count)"
    }
}
