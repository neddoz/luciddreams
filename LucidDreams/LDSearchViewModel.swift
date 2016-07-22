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
    
    typealias LoadingType = (Bool, String)
    
    let refreshTrigger      = PublishSubject<Bool>()
    let loadNextPageTrigger = PublishSubject<Void>()
    let queryTrigger        = PublishSubject<String>()
    let fullloading         = Variable<LoadingType>((false, "1"))
    let elements            = Variable<[LDGif]>([])
    
    private let provider = RxMoyaProvider<Giphy>()
    
    private var nativeQuery: String?
    
    private var disposeBag      = DisposeBag()
    private let queryDisposeBag = DisposeBag()
    
    init() {
        
        bindRequest(nil)
        setupForceRefresh()
        
    }
    
    private func setupForceRefresh() {
        
        self.queryTrigger
            .doOnNext { [weak self] queryString in
                
                guard let mySelf = self else { return }
                
                mySelf.nativeQuery = queryString
                
                mySelf.bindRequest(nil)
                
            }
            .map { _ in false }
            .bindTo(self.refreshTrigger)
            .addDisposableTo(self.queryDisposeBag)
        
        self.refreshTrigger
            .filter   { $0 }
            .doOnNext { [weak self] _ in
                
                guard let mySelf = self else { return }
                
                mySelf.bindRequest(nil)
                
            }
            .map { _ in false }
            .bindTo(self.refreshTrigger)
            .addDisposableTo(self.queryDisposeBag)
        
    }
    
    private func bindRequest(nextPage: String?) {
        
        self.disposeBag = DisposeBag()
        
        let fetch = self.searchGIFs(self.nativeQuery, nextPage: nextPage)
            .take(1)
            .shareReplay(1)
        
        let refreshRequest = self.refreshTrigger
            .filter { !$0 }
            .take(1)
            .flatMap { _ in fetch.asObservable() }
            .shareReplay(1)
//        
//        let nextPageRequest = self.loadNextPageTrigger
//            .take(1)
//            .flatMap { nextPage.map { Observable.of(paginationRequest.routeWithPage($0)) } ?? Observable.empty() }
//
//        let request = Observable
//            .of(refreshRequest, nextPageRequest)
//            .merge()
//            .take(1)
//            .shareReplay(1)
//        
//        let response = request
//            .flatMap { $0.rx_collection() }
//            .shareReplay(1)
//        
//        Observable
//            .of(
//                request.map { (true, $0.page) },
//                response.map { (false, $0.page ?? "1") }.catchErrorJustReturn((false, fullloading.value.1))
//            )
//            .merge()
//            .bindTo(fullloading)
//            .addDisposableTo(disposeBag)
//        
//        Observable
//            .combineLatest(elements.asObservable(), refreshRequest) { elements, response in
//                
//                return response.hasPreviousPage ? elements + response.elements : response.elements
//                
//            }
//            .take(1)
//            .bindTo(elements)
//            .addDisposableTo(disposeBag)
//
//        response
//            .map { $0.hasNextPage }
//            .bindTo(hasNextPage)
//            .addDisposableTo(disposeBag)
//        
//        response
//            .doOnOperaError { [weak self] error throws in
//                guard let mySelf = self else { return }
//                Observable.just(error).bindTo(mySelf.errors).addDisposableTo(mySelf.disposeBag)
//            }
//            .doOnError { [weak self] _ in
//                guard let mySelf = self else { return }
//                mySelf.bindPaginationRequest(mySelf.paginationRequest, nextPage: mySelf.fullloading.value.1) }
//            .subscribeNext { [weak self] paginationResponse in
//                self?.bindPaginationRequest(paginationRequest, nextPage: paginationResponse.nextPage)
//            }
//            .addDisposableTo(disposeBag)

        
        Observable
            .of(
                refreshRequest.map { _ in (false, "0") },
                refreshRequest.map { _ in (true,  "0") }
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
            .subscribeNext { [weak self] paginationResponse in
                //                        self?.bindPaginationRequest(paginationRequest, nextPage: paginationResponse.nextPage)
            }
            .addDisposableTo(self.disposeBag)
        
        
    }
    
    private func searchGIFs(query: String?, nextPage: String?) -> Observable<[LDGif]> {
        
        return self.provider
            .request(Giphy.Search(query, 1))
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
            .filter { $0.1 == "1" }
            .map { $0.0 }
        
    }
    
}