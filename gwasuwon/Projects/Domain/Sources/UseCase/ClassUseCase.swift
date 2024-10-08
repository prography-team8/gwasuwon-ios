//
//  ClassUseCase.swift
//  Domain
//
//  Created by 김동준 on 7/11/24
//

import Dependencies
import DI

public struct ClassUseCase {
    public let getClassList: () async -> Result<ClassInformation, NetworkError>
    public let getDetailClass: (_ id: String) async -> Result<ClassDetail, NetworkError>
    public let postCreateClass: (
        _ studentName: String,
        _ grade: String,
        _ memo: String,
        _ subject: SubjectType,
        _ sessionDuration: SessionDurationType,
        _ classDays: [String],
        _ numberOfSessions: Int,
        _ startDate: Int,
        _ rescheduleCount: Int
    ) async -> Result<Int, NetworkError>
    public let postJoinClass: (_ classId: String) async -> Result<Int, NetworkError>
    public let getDetailClassForStudent: () async -> Result<ClassDetail, NetworkError>
    public let putDetailClass: (
        _ classId: String,
        _ studentName: String,
        _ grade: String,
        _ memo: String,
        _ subject: SubjectType,
        _ sessionDuration: SessionDurationType,
        _ classDays: [String],
        _ numberOfSessions: Int,
        _ startDate: Int,
        _ rescheduleCount: Int
    ) async -> Result<Bool, NetworkError>
    public let deleteClass: (_ classId: String) async -> Result<Bool, NetworkError>
    public let postAttendance: (_ classId: String) async -> Result<Bool, NetworkError>
}

extension ClassUseCase: DependencyKey {
    public static var liveValue: ClassUseCase = {
        let repository: ClassRepositoryProtocol = DIContainer.shared.resolve()
        return ClassUseCase(
            getClassList: {
                await repository.getClassList()
            },
            getDetailClass: { id in
                await repository.getDetailClass(id: id)
            },
            postCreateClass: { studentName, grade, memo, subject, sessionDuration, classDays, numberOfSessions, startDate, rescheduleCount in
                await repository.postCreateClass(studentName, grade, memo, subject, sessionDuration, classDays, numberOfSessions, startDate, rescheduleCount)
            },
            postJoinClass: { classId in
                await repository.postJoinClass(classId: classId)
            },
            getDetailClassForStudent: {
                await repository.getDetailClass()
            },
            putDetailClass: { classId, studentName, grade, memo, subject, sessionDuration, classDays, numberOfSessions, startDate, rescheduleCount in
                await repository.putDetailClass(classId, studentName, grade, memo, subject, sessionDuration, classDays, numberOfSessions, startDate, rescheduleCount)
            },
            deleteClass: { classId in
                await repository.deleteClass(classId)
            },
            postAttendance: { classId in
                await repository.postAttendance(classId)
            }
        )
    }()
}

extension DependencyValues {
    public var classUseCase: ClassUseCase {
        get { self[ClassUseCase.self] }
        set { self[ClassUseCase.self] = newValue }
    }
}
