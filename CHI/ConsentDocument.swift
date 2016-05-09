//
//  ConsentDocument.swift
//  HelloMedicalResearch
//
//  Created by Borui "Andy" Li on 12/7/15.
//  Copyright © 2015 Borui "Andy" Li. All rights reserved.
//

import Foundation
import ResearchKit

public var ConsentDocument: ORKConsentDocument {
    let consentDocument = ORKConsentDocument()
    consentDocument.title = "Alzheimer's User Consent"
    
    //TODO: content of consent
    //Put the conventional sections for now. I am not sure what of if any sections we will need here
    let consentSectionTypes: [ORKConsentSectionType] = [
        .Overview,
        .DataGathering,
        .Privacy,
        .DataUse,
        .TimeCommitment,
        .StudySurvey,
        .StudyTasks,
        .Withdrawing
    ]
    
    // iterate through the consentSectionTypes to put same content for each section
    // replace each section with different content later
    let consentSections: [ORKConsentSection] = consentSectionTypes.map { contentSectionType in
        let consentSection = ORKConsentSection(type: contentSectionType)
        consentSection.summary = "This is the agreement for Alzheimer's Patient Study"
        consentSection.content = "In this study, you will finish tasks in a daily basis and record some data."
        return consentSection
    }
    
    consentDocument.sections = consentSections
    
    //TODO: add a signature
    consentDocument.addSignature(ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature"))
    
    return consentDocument
}