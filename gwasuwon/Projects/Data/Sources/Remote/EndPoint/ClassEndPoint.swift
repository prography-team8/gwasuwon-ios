//
//  ClassEndPoint.swift
//  Data
//
//  Created by 김동준 on 7/21/24
//

import Foundation

enum ClassEndPoint {
    case classList
    case classDetail(String)
    case classJoin
    case classAttendance
    
    var url: String {
        switch self {
        case .classList:
            "/api/v1/classes"
        case let .classDetail(id):
            "/api/v1/classes/\(id)"
        case .classJoin:
            "/api/v1/classes/join"
        case .classAttendance:
            "/api/v1/schedules/attendance"
        }
    }
}

