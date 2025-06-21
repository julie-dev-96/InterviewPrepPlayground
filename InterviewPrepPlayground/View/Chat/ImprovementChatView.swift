//
//  ImprovementChatView.swift
//  InterviewPrepPlayground
//
//  Created by Julie Childress on 6/21/25.
//

/* REQUIREMENTS:
 Scrollable chat list from bottom up
 Input bar
 Auto scroll to bottom
*/
import Observation
import SwiftUI

struct ChatView: View {
    @State private var state: ChatState

    init(
        chatName: String,
        messages: [Message]
    ) {
        state = ChatState(
            chatName: chatName,
            messages: messages
        )
    }

    var body: some View {
        NavigationStack {
            VStack {
                ContentScrollView(
                    messages: $state.messages
                )
                InputBar(
                    currentInput: $state.currentInput,
                    onSend: { state.sendMessage() },
                    sendButtonEnabled: state.sendButtonEnabled
                )
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(state.chatName)
                }
            }
        }
    }
}

#Preview {
    let messages: [Message] = {
        var messages: [Message] = []
        var didUserSend = true
        for _ in 0...50 {
            messages.append(
                .init(
                    content: "A text message",
                    didUserSend: didUserSend
                )
            )
            didUserSend.toggle()
        }
        return messages
    }()
    ChatView(
        chatName: "My Group Chat",
        messages: messages
    )
}

struct ContentScrollView: View {
    @Binding var messages: [Message]

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.vertical) {
                ForEach(messages) { message in
                    HStack(spacing: 24) {
                        if message.didUserSend {
                            Spacer()
                        }

                        MessageContentView(
                            didUserSend: message.didUserSend,
                            content: message.content
                        )
                        .padding(.horizontal)

                        if !message.didUserSend {
                            Spacer()
                        }
                    }
                }
            }
            .defaultScrollAnchor(.bottom)
            .onChange(of: messages) { _, newValue in
                if let last = newValue.last {
                    withAnimation {
                        proxy.scrollTo(
                            last.id,
                            anchor: .bottom
                        )
                    }
                }
            }
        }
    }
}

struct MessageContentView: View {
    let didUserSend: Bool
    let content: String

    var body: some View {
        let color: Color = didUserSend ? Color.cyan : Color.gray
        Text(content)
            .padding()
            .background {
                RoundedRectangle(
                    cornerSize: CGSize(
                        width: 8,
                        height: 8
                    )
                )
                .foregroundStyle(color)
            }
    }
}

struct InputBar: View {
    @Binding var currentInput: String
    var onSend: () -> Void
    let sendButtonEnabled: Bool

    var body: some View {
        HStack {
            TextField(
                "Input Field",
                text: $currentInput,
            )
            .padding()
            .textFieldStyle(.roundedBorder)

            Button(action: onSend) {
                Image(systemName: "arrow.up.circle.fill")
                    .padding(.horizontal)
                    .foregroundStyle(Color.cyan)
            }
        }
        .padding(.bottom)
        .background {
            Color.gray
                .ignoresSafeArea()
        }
    }
}
