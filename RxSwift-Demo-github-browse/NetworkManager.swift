//
//  NetworkManager.swift
//  RxSwift-Demo-github-browse
//
//  Created by Sean Yin on 2019/3/4.
//  Copyright © 2019 Sean Yin. All rights reserved.
//

import Moya

enum NetworkManager {
    case searchRepos(keywrod:String)
}

extension NetworkManager:TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
            case .searchRepos(let keyword):
                return "/users/\(keyword)/repos"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        switch self {
            case .searchRepos( _):
                return "".data(using: String.Encoding.utf8)!
        }
    }
    
    var task: Task {
        switch self {
            case .searchRepos(_):
                return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
            case .searchRepos(_):
                return [:]
        }
    }
}
