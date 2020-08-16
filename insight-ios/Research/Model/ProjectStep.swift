//
//  ProjectStep.swift
//  insight-ios
//
//  Created by Muhammad Hilmy Fauzi on 16/08/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import Foundation

struct ProjectStep {
    var desc: String
    var status: Status
    var dueDate: Date?
}

enum Status {
    case todo
    case doing
    case done
}

let step1 = ProjectStep(desc: "Gather All Your Data", status: .done, dueDate: nil)
let step2 = ProjectStep(desc: "Read All Your Data from Beginning to End", status: .done, dueDate: nil)
let step3 = ProjectStep(desc: "Code The Text Based On What It’s About", status: .doing, dueDate: Date())
let step4 = ProjectStep(desc: "Create New Codes That Encapsulate Potential Themes", status: .todo, dueDate: nil)
let step5 = ProjectStep(desc: "Take A Break For A Day, Then Return To The Data", status: .todo, dueDate: nil)
let step6 = ProjectStep(desc: "Evaluate Your Theme For Good Fit", status: .todo, dueDate: nil)

let getProjectStep = [step1, step2, step3, step4, step5, step6]
