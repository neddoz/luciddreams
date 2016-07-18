//
//  LDGifViewModel.swift
//  LucidDreams
//
//  Created by Pablo on 7/16/16.
//
//

import UIKit
import Moya
import RxSwift
import RxCocoa
import Moya_ModelMapper
import RxOptional

struct LDGifViewModel {
    
    private let provider = RxMoyaProvider<Giphy>()
    
    let searchQuery: Observable<String>
    
    func fetchGifs() -> Observable<[LDGif]> {
        
        return searchQuery
            .observeOn(MainScheduler.instance)
            .flatMapLatest { query -> Observable<[LDGif]?> in
                
                print("Searching with query: \(query)")
                
                return self.findGifs(query)
                
            }
            .replaceNilWith([])
        
    }
    
    internal func findGifs(query: String) -> Observable<[LDGif]?> {
        
        return self.provider
            .request(Giphy.Search(query, 0))
            .debug()
            .mapArrayOptional(LDGif.self, keyPath: "data")
        
    }
    
}