//
//  ClassMapper.swift
//  Data
//
//  Created by 김동준 on 7/21/24
//

import Domain

class ClassMapper {
    static func toClassInformationList(response: ClassListResponse) -> ClassInformation {
        return ClassInformation(
            classCount: response.numberOfElements,
            classInformationItems: response.content.map { item in
                ClassInformationItem(
                    id: item.id,
                    subject: SubjectType(rawValue: item.subject) ?? .none,
                    studentName: item.studentName,
                    grade: item.grade,
                    days: item.classDays.map { ClassDayType(rawValue: $0) ?? .mon },
                    sessionDuration: SessionDurationType(rawValue: item.sessionDuration) ?? .none,
                    numberOfSessions: item.numberOfSessions,
                    currentNumOfClass: item.numberOfSessionsCompleted
                )
                
            }
        )
    }
    
    static func toClassDetail(response: ClassDetailResponse) -> ClassDetail {
        return ClassDetail(
            id: response.id,
            studentName: response.studentName,
            grade: response.grade,
            memo: response.memo,
            subject: SubjectType(rawValue: response.subject) ?? .none,
            sessionDuration: SessionDurationType(rawValue: response.sessionDuration) ?? .none,
            classDays: response.classDays.map { ClassDayType(rawValue: $0) ?? .mon },
            numberOfSessions: response.numberOfSessions,
            startDate: response.startDate,
            rescheduleCount: RescheduleCountType(rawValue: String(response.rescheduleCount)) ?? .none,
            hasStudent: response.hasStudent,
            schedules: response.schedules.map {
                ClassSchedule(
                    id: $0.id,
                    date: $0.date,
                    status: ClassScheduleStatus(rawValue: $0.status) ?? .scheduled
                )
            }
        )
    }
}
