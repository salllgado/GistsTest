//
//  GistDetailViewModel.swift
//  GistsTests
//
//  Created by Chrystian Salgado on 10/05/24.
//

import Foundation

protocol GistDetailViewModable {
    
}

final class GistDetailViewModel: GistDetailViewModable {
    
    private(set) var gist: Gist
    
    init(gist: Gist) {
        self.gist = gist
    }
}
