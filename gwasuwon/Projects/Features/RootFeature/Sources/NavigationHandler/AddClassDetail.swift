//
//  AddClassDetail.swift
//  RootFeature
//
//  Created by 김동준 on 7/13/24
//

import ComposableArchitecture
import HomeFeature

extension RootCoordinator {
    func addClassDetailNavigationHandler(_ action: AddClassDetailFeature.Action, state: inout RootCoordinator.State) {
        switch action {
        case .navigateToBack:
            state.routes.goBack()
        case let .navigateToAddClassDone(id):
            state.routes.push(.addClassDone(.init(id: id)))
        default:
            break
        }
    }
}
