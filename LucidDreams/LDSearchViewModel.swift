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

class LDSearchViewModel {
    
    typealias LoadingType = (Bool, Int)
    
    let refreshTrigger      = PublishSubject<Bool>()
    let loadNextPageTrigger = PublishSubject<Void>()
    let queryTrigger        = PublishSubject<String>()
    let fullloading         = Variable<LoadingType>((false, 0))
    let elements            = Variable<[LDGif]>([])
    
    private let provider = RxMoyaProvider<Giphy>()
    
    private var nativeQuery:    String?
    private var nativeNextPage: Int
    
    private var disposeBag      = DisposeBag()
    private let queryDisposeBag = DisposeBag()
    
    init() {
        
        self.nativeNextPage = 0
        
        bindRequest(self.nativeNextPage)
        setupForceRefresh()
        
    }
    
    private func setupForceRefresh() {
        
        self.queryTrigger
            .doOnNext { [weak self] queryString in
                
                guard let mySelf = self else { return }
                
                mySelf.nativeQuery = queryString
            
                mySelf.bindRequest(0)
                
            }
            .map { _ in false }
            .bindTo(self.refreshTrigger)
            .addDisposableTo(self.queryDisposeBag)
        
        self.refreshTrigger
            .filter   { $0 }
            .doOnNext { [weak self] _ in
                
                guard let mySelf = self else { return }
                
                mySelf.bindRequest(0)
                
            }
            .map { _ in false }
            .bindTo(self.refreshTrigger)
            .addDisposableTo(self.queryDisposeBag)
        
    }
    
    private func bindRequest(nextPage: Int) {
        
        self.nativeNextPage = nextPage
        
        print(">>>>>>>>> \(self.nativeNextPage)")
        
        self.disposeBag = DisposeBag()
        
        let fetch = self.searchGIFs(self.nativeQuery, nextPage: self.nativeNextPage)
            .take(1)
            .shareReplay(1)
        
        let refreshRequest = self.refreshTrigger
            .filter { !$0 }
            .take(1)
            .flatMap { _ in fetch.asObservable() }
            .shareReplay(1)

        let nextPageRequest = self.loadNextPageTrigger
            .take(1)
            .flatMap { self.searchGIFs(self.nativeQuery, nextPage: self.nativeNextPage)
                .asObservable()
                .take(1)
                .shareReplay(1) ?? Observable.empty() }

        let response = Observable
            .of(refreshRequest, nextPageRequest)
            .merge()
            .take(1)
            .shareReplay(1)
        
        Observable
            .of(
                refreshRequest.map { _ in (true,  self.nativeNextPage < 0 ? self.nativeNextPage - 1 : 0) },
                response.map       { _ in (false, self.nativeNextPage) }.catchErrorJustReturn((false, fullloading.value.1))
            )
            .merge()
            .bindTo(fullloading)
            .addDisposableTo(disposeBag)

        Observable
            .combineLatest(elements.asObservable(), response ) { elements, responseElements in
                
                return (self.nativeNextPage > 0) ? elements + responseElements : responseElements
                
            }
            .take(1)
            .bindTo(self.elements)
            .addDisposableTo(self.disposeBag)
        
        response
            .doOnError { [weak self] _ in
                //                        guard let mySelf = self else { return }
                //                        mySelf.bindPaginationRequest(mySelf.paginationRequest, nextPage: mySelf.fullloading.value.1)
            }
            .subscribeNext { [weak self] paginationResponse in
                
                guard let mySelf = self else { return }
                
                mySelf.bindRequest(mySelf.nativeNextPage + kLDLimit)
                
            }
            .addDisposableTo(self.disposeBag)
        
        
    }
    
    private func searchGIFs(query: String?, nextPage: Int) -> Observable<[LDGif]> {
        
        return self.provider
            .request(Giphy.Search(query, nextPage))
            .debug()
            .mapArray(LDGif.self, keyPath: "data")
        
    }
    
}

extension LDSearchViewModel {
    
    var loading: Driver<Bool> {
        
        return fullloading
            .asDriver()
            .map { $0.0 }
            .distinctUntilChanged()
        
    }
    
    var firstPageLoading: Driver<Bool> {
        
        return fullloading.asDriver()
            .filter { $0.1 == 0 }
            .map { $0.0 }
        
    }
    
}