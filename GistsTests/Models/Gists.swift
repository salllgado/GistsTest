//
//  Gists.swift
//  GistsTests
//
//  Created by Chrystian Salgado on 13/05/24.
//

import Foundation

struct Gist: Decodable {
    let url: String
    let forksUrl: String
    let commitsUrl: String
    let id: String
    let nodeId: String
    let gitPullUrl: String
    let gitPushUrl: String
    let htmlUrl: String
    let files: [String: FileDetail]
    let isPublic: Bool
    let createdAt: String
    let updatedAt: String
    let description: String?
    let comments: Int
    let user: User?
    let commentsUrl: String
    let owner: Owner
    let truncated: Bool
    
    enum CodingKeys: String, CodingKey {
        case url
        case forksUrl = "forks_url"
        case commitsUrl = "commits_url"
        case id
        case nodeId = "node_id"
        case gitPullUrl = "git_pull_url"
        case gitPushUrl = "git_push_url"
        case htmlUrl = "html_url"
        case files
        case isPublic = "public"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case description
        case comments
        case user
        case commentsUrl = "comments_url"
        case owner
        case truncated
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
    let nodeId: String
    let avatarUrl: URL
    let gravatarId: String
    let url: String
    let htmlUrl: String
    let followersUrl: String
    let followingUrl: String
    let gistsUrl: String
    let starredUrl: String
    let subscriptionsUrl: String
    let organizationsUrl: String
    let reposUrl: String
    let eventsUrl: String
    let receivedEventsUrl: String
    let type: String
    let siteAdmin: Bool
    
    enum CodingKeys: String, CodingKey {
        case login
        case id
        case nodeId = "node_id"
        case avatarUrl = "avatar_url"
        case gravatarId = "gravatar_id"
        case url
        case htmlUrl = "html_url"
        case followersUrl = "followers_url"
        case followingUrl = "following_url"
        case gistsUrl = "gists_url"
        case starredUrl = "starred_url"
        case subscriptionsUrl = "subscriptions_url"
        case organizationsUrl = "organizations_url"
        case reposUrl = "repos_url"
        case eventsUrl = "events_url"
        case receivedEventsUrl = "received_events_url"
        case type
        case siteAdmin = "site_admin"
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
