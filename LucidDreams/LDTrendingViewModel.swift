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
        
        let fetch = self.fetchTrend().take(1).shareReplay(1)
        
        let refreshRequest = self.refreshTrigger
            .filter { !$0 }
            .take(1)
            .flatMapLatest { _ in fetch }
        
        refreshRequest
            .take(1)
            .bindTo(self.elements)
            .addDisposableTo(disposeBag)
        
        
        //        let request = Observable
        //            .of(refreshRequest)
        //            .merge()
        //            .take(1)
        //            .shareReplay(1)
        //
        //        Observable.combineLatest(self.elements.asObservable(), request) { elements, response in
        //
        //            return elements.flatMapLatest { _ in }
        //
        //            }
        //            .take(1)
        //            .bindTo(self.elements)
        //            .addDisposableTo(disposeBag)
        
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