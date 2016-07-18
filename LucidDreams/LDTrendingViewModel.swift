//
//  LDTrendingModelView.swift
//  LucidDreams
//
//  Created by Pablo on 7/18/16.
//
//

import Foundation
import UIKit
import Moya
import RxSwift
import RxCocoa
import Moya_ModelMapper
import RxOptional

struct LDTrendingViewModel {
    
    let gifs: [LDGif]
    
    private let provider = RxMoyaProvider<Giphy>()
    
    func fetchTrend() -> Observable<[LDGif]?> {
        
        return self.provider
            .request(Giphy.Trend)
            .debug()
            .mapArrayOptional(LDGif.self, keyPath: "data")
        
    }
    
}