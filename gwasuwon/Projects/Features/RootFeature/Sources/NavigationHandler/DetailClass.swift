//
//  DetailClass.swift
//  RootFeature
//
//  Created by 김동준 on 7/14/24
//

import HomeFeature
import ComposableArchitecture

extension RootCoordinator {
    func detailClassNavigationHandler(_ action: DetailClassFeature.Action, state: inout RootCoordinator.State) {
        switch action {
        case .navigateToBack:
            state.routes.goBack()
        case let .navigateToQRGeneration(classId, isInvite):
            state.routes.push(.qrGenerator(.init(classId: classId, isInvite: isInvite)))
        case let .navigateToClassEdit(classId):
            state.routes.push(.editClass(.init(classId: classId)))
        default:
            break
        }
    }
}
