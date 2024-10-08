//
//  GCalendar.swift
//  DesignSystem
//
//  Created by 김동준 on 7/21/24
//

import Foundation
import SwiftUI
import Util

public struct GCalenderView: View {
    @State private var month: Date = Date()
    @State private var clickedCurrentMonthDates: Date?
    private var schedules: [GCalendarSchedule]
    private var action: (Date) -> Void
  
    public init(
        month: Date = Date(),
        clickedCurrentMonthDates: Date? = nil,
        schedules: [GCalendarSchedule],
        action: @escaping (Date) -> Void
    ) {
        _month = State(initialValue: month)
        _clickedCurrentMonthDates = State(initialValue: clickedCurrentMonthDates)
        self.schedules = schedules
        self.action = action
    }
  
    public var body: some View {
        VStack(spacing: 0) {
            HeaderView
            CalendarGridView
        }
    }
  
    private var HeaderView: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                Button {
                    changeMonth(by: -1)
                } label: {
                    GImage.icBack.swiftUIImage
                        .renderingMode(.template).resizedToFit(20, 20)
                        .foregroundStyle(canMoveToPreviousMonth() ? GColor.staticBlack.swiftUIColor : GColor.labelDisable.swiftUIColor)
                }.vPadding(4).disabled(!canMoveToPreviousMonth())
                GText(
                    month.formattedString(format: DateFormatConstants.calendarHeaderFormat),
                    fontStyle: .Heading_2_B,
                    color: .labelNormal
                )
                Button {
                    changeMonth(by: 1)
                } label: {
                    GImage.icMore.swiftUIImage
                        .renderingMode(.template).resizedToFit(20, 20)
                        .foregroundStyle(canMoveToNextMonth() ? GColor.staticBlack.swiftUIColor : GColor.labelDisable.swiftUIColor)
                }.vPadding(4).disabled(!canMoveToNextMonth())
            }.greedyWidth()
            DayOfWeekTitleView
        }
    }
    
    private var DayOfWeekTitleView: some View {
        HStack {
            ForEach(Array(zip(Self.weekdaySymbols.indices, Self.weekdaySymbols)), id: \.0) { index, item in
                GText(
                    item.uppercased(),
                    fontStyle: .Caption_2_B,
                    color: .labelNormal
                ).vPadding(5).hPadding(7).greedyWidth()
            }
        }.padding(.bottom, 20)
    }
    
    // MARK: - 날짜 그리드 뷰
    private var CalendarGridView: some View {
        let daysInMonth: Int = numberOfDays(in: month)
        let firstWeekday: Int = firstWeekdayOfMonth(in: month) - 1
        let lastDayOfMonthBefore = numberOfDays(in: previousMonth())
        let numberOfRows = Int(ceil(Double(daysInMonth + firstWeekday) / 7.0))
        let visibleDaysOfNextMonth = numberOfRows * 7 - (daysInMonth + firstWeekday)
        
        return LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
            ForEach(-firstWeekday ..< daysInMonth + visibleDaysOfNextMonth, id: \.self) { index in
                Group {
                    if index > -1 && index < daysInMonth {
                        let date = getDate(for: index)
                        let day = Calendar.current.component(.day, from: date)
                        let clicked = clickedCurrentMonthDates == date
                        let isToday = date.formattedString(format: DateFormatConstants.calendarDayDateFormatter) == today.formattedString(format: DateFormatConstants.calendarDayDateFormatter)
                        let calendarStatusType: CalendarStatusType = getCalendarStatusType(date: date, clicked: clicked, isToday: isToday)

                        CellView(day: day, clicked: clicked, isToday: isToday, calendarStatusType: calendarStatusType)
                    } else if let prevMonthDate = Calendar.current.date(
                        byAdding: .day,
                        value: index + lastDayOfMonthBefore,
                        to: previousMonth()
                    ) {
                        let day = Calendar.current.component(.day, from: prevMonthDate)
                        
                        CellView(day: day, isCurrentMonthDay: false, calendarStatusType: .notAvailable)
                    }
                }
                .onTapGesture {
                    if 0 <= index && index < daysInMonth {
                        let date = getDate(for: index)
                        clickedCurrentMonthDates = date
                        action(date)
                    }
                }
            }
        }
    }
    
    private func getCalendarStatusType(date: Date, clicked: Bool, isToday: Bool) -> CalendarStatusType {
        let formattedDate: String = date.formattedString(format: DateFormatConstants.calendarDayDateFormatter)
        
        if let schedule = schedules.first{ item in
            item.date.toDateFromIntEpochMilliseconds().formattedString(format: DateFormatConstants.calendarDayDateFormatter) == formattedDate
        } {
            switch schedule.status {
            case .canceled: return .canceled
            case .completed: return .completed
            case .scheduled: return .scheduled
            }
        } else {
            if (clicked) {
                return .selected
            } else {
                return .notAvailable
            }
        }
    }
}

// MARK: - 일자 셀 뷰
private struct CellView: View {
    private var day: Int
    private var clicked: Bool
    private var isToday: Bool
    private var isCurrentMonthDay: Bool
    private var calendarStatusType: CalendarStatusType
    
    fileprivate init(
        day: Int,
        clicked: Bool = false,
        isToday: Bool = false,
        isCurrentMonthDay: Bool = true,
        calendarStatusType: CalendarStatusType
    ) {
        self.day = day
        self.clicked = clicked
        self.isToday = isToday
        self.isCurrentMonthDay = isCurrentMonthDay
        self.calendarStatusType = calendarStatusType
    }
    
    private var textColor: Color {
        if (isCurrentMonthDay) {
            switch calendarStatusType {
            case .canceled:
                return .staticWhite
            case .completed:
                return .staticWhite
            case .notAvailable:
                return .staticBlack
            case .scheduled:
                return .primaryNormal
            case .selected:
                return .staticBlack
            }
        } else {
            return .labelDisable
        }
    }
    
    private var backgroundColor: Color {
        switch calendarStatusType {
        case .canceled:
            return .statusNegative
        case .completed:
            return .primaryNormal
        case .notAvailable:
            return .staticWhite
        case .scheduled:
            return .staticWhite
        case .selected:
            return .fillStrong
        }
    }
  
    fileprivate var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 4)
            .fill(backgroundColor)
            .overlay(
                GText(String(day), fontStyle: clicked ? .Caption_2_B : .Caption_2_R, color: textColor)
            )
            .frame(width: 36, height: 36)
            .modifier(GCalendarCellStrokeModifier(calendarStatusType: calendarStatusType))
            Spacer().frame(height: 20) // TODO: fix spacer
        }
    }
}

private struct GCalendarCellStrokeModifier: ViewModifier {
    let calendarStatusType: CalendarStatusType
    
    fileprivate func body(content: Content) -> some View {
        if (calendarStatusType == .scheduled) {
            content
                .overlay(RoundedRectangle(cornerRadius: 4)
                    .stroke(GColor.primaryNormal.swiftUIColor, lineWidth: 1.0))
        } else {
            content
        }
    }
}

private extension GCalenderView {
    var today: Date {
        let now = Date()
        let components = Calendar.current.dateComponents([.year, .month, .day], from: now)
        return Calendar.current.date(from: components)!
    }
  
    static var weekdaySymbols: [String] = Calendar.current.shortWeekdaySymbols.map {
        WeekSymbols(rawValue: $0)?.translateToKorean() ?? ""
    }
    
    private enum WeekSymbols: String {
        case SUN = "Sun"
        case MON = "Mon"
        case TUE = "Tue"
        case WED = "Wed"
        case THU = "Thu"
        case FRI = "Fri"
        case SAT = "Sat"
        
        func translateToKorean() -> String {
            switch self {
            case .SUN: return "일"
            case .MON: return "월"
            case .TUE: return "화"
            case .WED: return "수"
            case .THU: return "목"
            case .FRI: return "금"
            case .SAT: return "토"
            }
        }
    }
}

private extension GCalenderView {
    /// 특정 해당 날짜
    func getDate(for index: Int) -> Date {
        let calendar = Calendar.current
        guard let firstDayOfMonth = calendar.date(
            from: DateComponents(
                year: calendar.component(.year, from: month),
                month: calendar.component(.month, from: month),
                day: 1
            )
        ) else {
            return Date()
        }
    
        var dateComponents = DateComponents()
        dateComponents.day = index
    
        let timeZone = TimeZone.current
        let offset = Double(timeZone.secondsFromGMT(for: firstDayOfMonth))
        dateComponents.second = Int(offset)
    
        let date = calendar.date(byAdding: dateComponents, to: firstDayOfMonth) ?? Date()
        return date
    }
  
    /// 해당 월에 존재하는 일자 수
    func numberOfDays(in date: Date) -> Int {
        return Calendar.current.range(of: .day, in: .month, for: date)?.count ?? 0
    }
  
    /// 해당 월의 첫 날짜가 갖는 해당 주의 몇번째 요일
    func firstWeekdayOfMonth(in date: Date) -> Int {
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        let firstDayOfMonth = Calendar.current.date(from: components)!
    
        return Calendar.current.component(.weekday, from: firstDayOfMonth)
    }
  
    /// 이전 월 마지막 일자
    func previousMonth() -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: month)
        let firstDayOfMonth = Calendar.current.date(from: components)!
        let previousMonth = Calendar.current.date(byAdding: .month, value: -1, to: firstDayOfMonth)!
        
        return previousMonth
    }
    
    /// 월 변경
    func changeMonth(by value: Int) {
        self.month = adjustedMonth(by: value)
    }
  
    /// 이전 월로 이동 가능한지 확인
    func canMoveToPreviousMonth() -> Bool {
        let currentDate = Date()
        let calendar = Calendar.current
        let targetDate = calendar.date(byAdding: .month, value: -3, to: currentDate) ?? currentDate
        
        if adjustedMonth(by: -1) < targetDate {
            return false
        }
        return true
    }
    
    /// 다음 월로 이동 가능한지 확인
    func canMoveToNextMonth() -> Bool {
        let currentDate = Date()
        let calendar = Calendar.current
        let targetDate = calendar.date(byAdding: .month, value: 3, to: currentDate) ?? currentDate
        
        if adjustedMonth(by: 1) > targetDate {
            return false
        }
        return true
    }
    
    /// 변경하려는 월 반환
    func adjustedMonth(by value: Int) -> Date {
        if let newMonth = Calendar.current.date(byAdding: .month, value: value, to: month) {
            return newMonth
        }
        return month
    }
}

private enum CalendarStatusType {
    case canceled
    case completed
    case scheduled
    case selected
    case notAvailable
}

public struct GCalendarSchedule {
    public let id: Int
    public let date: Int
    public let status: GCalendarScheduleStatus
    
    public init(
        id: Int,
        date: Int,
        status: GCalendarScheduleStatus
    ) {
        self.id = id
        self.date = date
        self.status = status
    }
}

public enum GCalendarScheduleStatus: String {
    case scheduled = "SCHEDULED"
    case completed = "COMPLETED"
    case canceled = "CANCELED"
}
