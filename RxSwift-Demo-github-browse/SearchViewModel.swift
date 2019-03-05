//
//  SearchViewModel.swift
//  RxSwift-Demo-github-browse
//
//  Created by Sean Yin on 2019/3/4.
//  Copyright © 2019 Sean Yin. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Moya_ObjectMapper

class SearchViewModel {
    
    public let repos:PublishSubject<[GitRepo]> = PublishSubject.init()
    public var keywords:PublishSubject<String> = PublishSubject.init()
    
    private let disposeBag = DisposeBag()
    private let provider = MoyaProvider<NetworkManager>()
    
    init() {
        
        keywords.asDriver(onErrorJustReturn: "")
            .drive(onNext: { [weak self] string in
                self?.provider.rx
                    .request(.searchRepos(keywrod: string))
                    .mapArray(GitRepo.self)
                    .subscribe(onSuccess: { repos in
                        self?.repos.onNext(repos)
                    }, onError: { error in
                        self?.repos.onNext([])
                    })
                    .disposed(by: (self?.disposeBag)!)
            })
            .disposed(by: self.disposeBag)
    }
}
