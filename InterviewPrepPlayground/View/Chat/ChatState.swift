//
//  ChatState.swift
//  InterviewPrepPlayground
//
//  Created by Julie Childress on 6/21/25.
//

import Foundation
import Observation

@Observable
class ChatState {
    var chatName: String
    var messages: [Message]
    var currentInput: String
    var sendButtonEnabled: Bool {
        !currentInput.isEmpty
    }

    init(
        chatName: String,
        messages: [Message]
    ) {
        self.chatName = chatName
        self.messages = messages
        self.currentInput = ""
    }

    func sendMessage() {
        guard !currentInput.isEmpty else { return }
        messages.append(
            .init(
                content: currentInput,
                didUserSend: true
            )
        )
        currentInput = ""
    }
}

struct Message: Identifiable, Equatable, Hashable {
    let id: UUID = UUID()
    let content: String
    let didUserSend: Bool
}
