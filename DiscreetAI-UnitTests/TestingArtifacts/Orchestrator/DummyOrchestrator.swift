//
//  DummyOrchestrator.swift
//  Discreet-DMLTests
//
//  Created by Neelesh on 2/3/20.
//  Copyright © 2020 DiscreetAI. All rights reserved.
//

import XCTest
@testable import DiscreetAI

class DummyOrchestrator: Orchestrator {
    
    override init(repoID: String, connectImmediately: Bool = false) throws {
        try super.init(repoID: repoID, connectImmediately: connectImmediately)
        let coreMLClient = self.communicationManager.coreMLClient!
        self.communicationManager = DummyCommunicationManager(coreMLClient: coreMLClient)
        coreMLClient.weightsProcessor = WeightsProcessor()
        coreMLClient.modelLoader = DummyImageModelLoader()
        coreMLClient.configure(communicationManager: self.communicationManager)
    }
}