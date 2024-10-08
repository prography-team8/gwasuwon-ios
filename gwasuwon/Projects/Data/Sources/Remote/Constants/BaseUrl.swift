//
//  BaseUrl.swift
//  Data
//
//  Created by 김동준 on 6/7/24
//

import Foundation

public enum BaseUrl: String {
    case DEV = "https://44ff-58-227-3-21.ngrok-dev-free.app"
    case PROD = "http://3.36.89.70:8080"
    public static let environment: BaseUrl = {
        #if DEV
        return .DEV
        #else
        return .PROD
        #endif
    }()
}
