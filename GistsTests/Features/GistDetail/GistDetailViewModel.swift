//
//  GistDetailViewModel.swift
//  GistsTests
//
//  Created by Chrystian Salgado on 10/05/24.
//

import Foundation

final class GistDetailViewModel: ViewModel {
    
    private(set) var gist: Gist
    
    init() {
        fatalError()
    }
    
    required init(gist: Gist) {
        self.gist = gist
    }
}
