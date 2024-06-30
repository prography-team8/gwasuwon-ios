//
//  GChips.swift
//  DesignSystem
//
//  Created by 김동준 on 6/30/24
//

import SwiftUI

public struct GChips: View {
    let title: String
    let fontColor: Color
    let style: GChipsStyle
    
    public init(
        title: String,
        fontColor: Color = .staticWhite,
        style: GChipsStyle = .positive
    ) {
        self.title = title
        self.fontColor = fontColor
        self.style = style
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            GText(
                title,
                fontStyle: .Lable_2_R,
                color: fontColor
            )
            .vPadding(4)
            .hPadding(8)
            .background(getBackgroundColor())
            .cornerRadius(8)
        }
    }
    
    private func getBackgroundColor() -> Color {
        switch style {
        case .positive:
            return .statusPositive
        case .cautionary:
            return .statusCautionary
        }
    }
}

public enum GChipsStyle {
    case positive
    case cautionary
}