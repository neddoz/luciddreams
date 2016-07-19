//
//  LDTrendingModelView.swift
//  LucidDreams
//
//  Created by Pablo on 7/18/16.
//
//

import Moya
import UIKit
import RxSwift
import RxCocoa
import RxOptional
import Foundation
import Moya_ModelMapper

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