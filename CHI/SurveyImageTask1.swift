//
//  SurveyImageTask1.swift
//  HelloMedicalResearch
//
//  Created by Borui "Andy" Li on 12/8/15.
//  Copyright © 2015 Borui "Andy" Li. All rights reserved.
//

import ResearchKit

public var SurveyImageTask1: ORKOrderedTask {
    
    var steps = [ORKStep]()
    
    //TODO: add instructions step
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "The Image Selection Step"
    instructionStep.text = "Choose the Image that best fits the question."
    steps += [instructionStep]

    
    //TODO: add name question
    
    //TODO: add 'what is your quest' question
    
    //TODO: add color question step
    
    let colorQuestionStepTitle = "Which image is the same as the first one?"
    let colorTuples = [
        (UIImage(named: "a")!, "a"),
        (UIImage(named: "b")!, "b"),
        (UIImage(named: "c")!, "c"),
        (UIImage(named: "d")!, "d")
//        (UIImage(named: "purple")!, "Purple")
    ]
    let imageChoices : [ORKImageChoice] = colorTuples.map {
        return ORKImageChoice(normalImage: $0.0, selectedImage: nil, text: $0.1, value: $0.1)
    }
    let colorAnswerFormat: ORKImageChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormatWithImageChoices(imageChoices)
    let colorQuestionStep = ORKQuestionStep(identifier: "ImageChoiceQuestionStep", title: colorQuestionStepTitle, answer: colorAnswerFormat)
    steps += [colorQuestionStep]
    
    //TODO: add summary step
    
    return ORKOrderedTask(identifier: "SurveyTask", steps: steps)
}