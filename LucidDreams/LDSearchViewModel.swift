//
//  LDSearchViewModel.swift
//  LucidDreams
//
//  Created by Pablo on 7/16/16.
//
//

import Moya
import UIKit
import RxSwift
import RxCocoa
import RxOptional
import Moya_ModelMapper
import CocoaLumberjack

enum ServiceState {
    
    case Online
    case Offline
    
}

struct ResultsState {
    
    let results:       [LDGif]
    let serviceState:  ServiceState?
    let limitExceeded: Bool
    
    static let empty = ResultsState(results:       [],
                                    serviceState:  nil,
                                    limitExceeded: false)
    
}

struct LDSearchViewModel {
    
    private let provider = RxMoyaProvider<Giphy>()
    
    let gifs:        [LDGif]
    let searchQuery: Driver<String>
    
    func fetchGifs() -> Observable<[LDGif]> {
        
        return searchQuery
            .flatMapLatest { query -> Driver<ResultsState> in
                
                if query.isEmpty {
                    
                    return Driver.just(ResutlsState.empty)
                    
                } else {
                    
                    return findGifs(query, loadNextPageTrigger: loadNextPageTrigger)
                        .asDriver(onErrorJustReturn: RepositoriesState.empty)
                }
                
        }
        
    }
    
    internal func findGifs(query: String) -> Observable<[LDGif]?> {
        
        return self.provider
            .request(Giphy.Search(query, 0))
            .debug()
            .mapArrayOptional(LDGif.self, keyPath: "data")
        
    }
    
}