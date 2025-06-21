//
//  ChatView.swift
//  InterviewPrep
//
//  Created by Julie Childress on 6/21/25.
//

/* REQUIREMENTS:
 Scrollable chat list from bottom up
 Input bar
 Auto scroll to bottom
*/
//import Observation
//import SwiftUI
//
//struct ChatView: View {
//    @State private var state: ChatState
//
//    init(
//        chatName: String,
//        messages: [Message]
//    ) {
//        state = ChatState(
//            chatName: chatName,
//            messages: messages
//        )
//    }
//
//    var body: some View {
//        NavigationStack {
//            VStack {
//                ContentScrollView(
//                    messages: $state.messages
//                )
//                InputBar(
//                    currentInput: $state.currentInput,
//                    onSend: { state.sendMessage() },
//                    sendButtonEnabled: state.sendButtonEnabled
//                )
//                .frame(maxHeight: 200)
//            }
//            .toolbar {
//                ToolbarItem(placement: .principal) {
//                    Text(state.chatName)
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    let messages: [Message] = [
//        .init(
//            content: "My first message",
//            didUserSend: true
//        ),
//        .init(
//            content: "Another message",
//            didUserSend: true
//        ),
//        .init(
//            content: "Another message",
//            didUserSend: false
//        ),
//        .init(
//            content: "Another really really really really long long long long message",
//            didUserSend: false
//        ),
//        .init(
//            content: "Another message",
//            didUserSend: true
//        ),
//    ]
//    ChatView(
//        chatName: "My Group Chat",
//        messages: messages
//    )
//}
//
//struct ContentScrollView: View {
//    @Binding var messages: [Message]
//
//    var body: some View {
//        ScrollView(.vertical) {
//            ForEach(messages) { message in
//                HStack(spacing: 24) {
//                    if message.didUserSend {
//                        Spacer()
//                    }
//
//                    MessageContentView(
//                        didUserSend: message.didUserSend,
//                        content: message.content
//                    )
//                    .padding(.horizontal)
//
//                    if !message.didUserSend {
//                        Spacer()
//                    }
//                }
//            }
//        }
//        .defaultScrollAnchor(.bottom)
//    }
//}
//
//struct MessageContentView: View {
//    let didUserSend: Bool
//    let content: String
//
//    var body: some View {
//        let color: Color = didUserSend ? Color.cyan : Color.gray
//        Text(content)
//            .padding()
//            .background {
//                Capsule()
//                    .foregroundStyle(color)
//            }
//    }
//}
//
//struct InputBar: View {
//    @Binding var currentInput: String
//    var onSend: () -> Void
//    let sendButtonEnabled: Bool
//
//    var body: some View {
//        ZStack {
//            Color.gray
//                .ignoresSafeArea()
//
//            VStack {
//                HStack {
//                    TextField(
//                        "Input Field",
//                        text: $currentInput
//                    )
//                    .padding()
//                    .background {
//                        Color.white
//                            .cornerRadius(8)
//                            .padding(.horizontal)
//                    }
//
//                    Button(action: onSend) {
//                        Image(systemName: "arrow.up.circle.fill")
//                            .padding(.horizontal)
//                            .foregroundStyle(Color.cyan)
//                    }
//                }
//
//                Spacer()
//            }
//            .padding(.vertical)
//        }
//    }
//}
