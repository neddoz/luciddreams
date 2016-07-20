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

class LDTrendingViewModel {
    
    typealias LDLoadingType = (Bool, String)
    
    let refreshTrigger = PublishSubject<Bool>()
    let fullloading    = Variable<LDLoadingType>((false, "1"))
    let elements       = Variable<[LDGif]>([])
    
    private let provider   = RxMoyaProvider<Giphy>()
    private var disposeBag = DisposeBag()
    
    init() {
        
        bindPaginationRequest()
        setupForceRefresh()
        
    }
    
    private func fetchTrend() -> Observable<[LDGif]> {
        
        return self.provider
            .request(Giphy.Trend)
            .debug()
            .mapArray(LDGif.self, keyPath: "data")
        
    }
    
    private func setupForceRefresh() {
        
        refreshTrigger
            .filter   { $0 }
            .doOnNext { [weak self] _ in
                
                guard let mySelf = self else { return }
                
                mySelf.bindPaginationRequest()
                
            }
            .map { _ in false }
            .bindTo(refreshTrigger)
            .addDisposableTo(disposeBag)
        
    }
    
    private func bindPaginationRequest() {
        
        self.disposeBag = DisposeBag()
        
        let response = self.fetchTrend().take(1).shareReplay(1)
        
        let refreshRequest = self.refreshTrigger
            .filter { !$0 }
            .take(1)
            .map { _ in response }
        
        let request = Observable
            .of(refreshRequest)
            .merge()
            .take(1)
            .shareReplay(1)
        
        
        
        Observable.just(self.elements) { elements in
            
            elements
            
            }
            .take(1)
            .bindTo(elements)
            .addDisposableTo(disposeBag)
        
        //        response
        //            .doOnError { [weak self] _ in
        //                guard let mySelf = self else { return }
        //                mySelf.bindPaginationRequest(mySelf.paginationRequest, nextPage: mySelf.fullloading.value.1) }
        //            .subscribeNext { [weak self] paginationResponse in
        //                self?.bindPaginationRequest(paginationRequest, nextPage: paginationResponse.nextPage)
        //            }
        //            .addDisposableTo(disposeBag)
    }
    
}

extension LDTrendingViewModel {
    
    var loading: Driver<Bool> {
        
        return fullloading
            .asDriver()
            .map { $0.0 }
            .distinctUntilChanged()
        
    }
    
}