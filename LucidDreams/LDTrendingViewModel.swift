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
    
    let refreshTrigger = PublishSubject<Bool>()
    let fullloading    = Variable<Bool>(false)
    let elements       = Variable<[LDGif]>([])
    
    private let provider = RxMoyaProvider<Giphy>()
    
    private var disposeBag      = DisposeBag()
    private var queryDisposeBag = DisposeBag()
    
    init() {
        
        bindRequest()
        setupForceRefresh()
        
    }
    
    private func setupForceRefresh() {
        
        self.refreshTrigger
            .filter   { $0 }
            .doOnNext { [weak self] _ in
                
                guard let mySelf = self else { return }
                
                mySelf.bindRequest()
                
            }
            .map { _ in false }
            .bindTo(self.refreshTrigger)
            .addDisposableTo(self.queryDisposeBag)
        
    }
    
    private func bindRequest() {
        
        self.disposeBag = DisposeBag()
        
        let fetch = self.fetchTrend().take(1).shareReplay(1)
        
        let refreshRequest = self.refreshTrigger
            .filter { !$0 }
            .take(1)
            .flatMap { _ in fetch.asObservable() }
            .shareReplay(1)
        
        Observable
            .of(
                refreshRequest.map { _ in (false) },
                refreshRequest.map { _ in (true) }
            )
            .merge()
            .bindTo(fullloading)
            .addDisposableTo(disposeBag)
        
        refreshRequest
            .take(1)
            .bindTo(self.elements)
            .addDisposableTo(self.disposeBag)
        
        fetch
            .doOnError { [weak self] _ in
                //                        guard let mySelf = self else { return }
                //                        mySelf.bindPaginationRequest(mySelf.paginationRequest, nextPage: mySelf.fullloading.value.1)
            }

    }
    
    private func fetchTrend() -> Observable<[LDGif]> {
        
        return self.provider
            .request(Giphy.Trend)
            .debug()
            .mapArray(LDGif.self, keyPath: "data")
        
    }
    
}

extension LDTrendingViewModel {
    
    var loading: Driver<Bool> {
        
        return fullloading
            .asDriver()
            .map { $0 }
            .distinctUntilChanged()
        
    }
    
}