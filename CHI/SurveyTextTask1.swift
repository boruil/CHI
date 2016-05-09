//
//  SurveyTask.swift
//  HelloMedicalResearch
//
//  Created by Borui "Andy" Li on 12/8/15.
//  Copyright © 2015 Borui "Andy" Li. All rights reserved.
//

import Foundation
import ResearchKit
public var SurveyTextTask1: ORKOrderedTask {
    
    var steps = [ORKStep]()
    
    //TODO: add instructions step
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "The Text Task Set"
    instructionStep.text = "Choose the word that appears in the previous test."
    steps += [instructionStep]
    
    //TODO: add name question
    
    //TODO: add 'what is your quest' question
    let questQuestionStepTitle1 = "What do you remember?"
    let textChoices1 = [
        ORKTextChoice(text: "Caustic", value: 0),
        ORKTextChoice(text: "Simplified", value: 1),
        ORKTextChoice(text: "Fated", value: 2)
    ]
    let questAnswerFormat1: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices1)
    let questQuestionStep1 = ORKQuestionStep(identifier: "TextChoiceQuestionStep1", title: questQuestionStepTitle1, answer: questAnswerFormat1)
    steps += [questQuestionStep1]
    
    let questQuestionStepTitle2 = "What do you remember?"
    let textChoices2 = [
        ORKTextChoice(text: "long", value: 0),
        ORKTextChoice(text: "dry", value: 1),
        ORKTextChoice(text: "happy", value: 2)
    ]
    let questAnswerFormat2: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices2)
    let questQuestionStep2 = ORKQuestionStep(identifier: "TextChoiceQuestionStep2", title: questQuestionStepTitle2, answer: questAnswerFormat2)
    steps += [questQuestionStep2]
    
    //TODO: add color question step
    
    //TODO: add summary step
    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "Right. Off you go!"
    summaryStep.text = "That was easy!"
    steps += [summaryStep]
    
    return ORKOrderedTask(identifier: "SurveyTask", steps: steps)
}