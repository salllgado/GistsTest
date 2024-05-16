//
//  GistListRequestManager.swift
//  GistsTests
//
//  Created by Chrystian Salgado on 15/05/24.
//

import Foundation

protocol GistListRequestManagerProtocol {
    func requestGists(
            page: Int,
            limit: Int,
            completion: @escaping (Result<[Gist], NetworkError>
        ) -> Void
    )
}

final class GistListRequestManager: GistListRequestManagerProtocol {
    func requestGists(page: Int, limit: Int, completion: @escaping (Result<[Gist], NetworkError>) -> Void) {
        NetworkServiceProvider.shared.request(
            target: GistsAPI.getGistsFromRemote(
                page: page,
                limit: limit
            )
        ) { result in
            completion(.success(result))
        } failure: { error in
            completion(.failure(error))
        }
    }
}
