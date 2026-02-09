import SwiftUI

struct ChatMessage: Identifiable {
    let id = UUID()
    let role: String
    let content: String
    let isUser: Bool
}

struct EdibleExperiencesScreen: View {
    @State private var messages: [ChatMessage] = []
    @State private var inputText = ""
    @State private var isLoading = false
    @FocusState private var isInputFocused: Bool

    private let suggestions = [
        "Plan a date night",
        "Bar crawl in Brooklyn",
        "Dinner and a movie",
        "Birthday dinner for 6",
        "Best late-night eats"
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                Color.edibleBackground
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    // Header
                    headerView

                    Divider()
                        .foregroundColor(.edibleBorder)

                    // Chat area
                    if messages.isEmpty {
                        emptyStateView
                    } else {
                        chatListView
                    }

                    Divider()
                        .foregroundColor(.edibleBorder)

                    // Input bar
                    inputBar
                }
            }
            .navigationBarHidden(true)
        }
    }

    // MARK: - Header
    private var headerView: some View {
        VStack(spacing: Spacing.xxs) {
            Text("Edible Experiences")
                .font(.edibleHeadline)
                .foregroundColor(.edibleTextPrimary)

            Text("AI-curated dining experiences")
                .font(.edibleCaption)
                .foregroundColor(.edibleTextSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, Spacing.sm)
    }

    // MARK: - Empty State
    private var emptyStateView: some View {
        ScrollView {
            VStack(spacing: Spacing.xl) {
                Spacer()
                    .frame(height: Spacing.xl)

                Image(systemName: "sparkles")
                    .font(.system(size: 48))
                    .foregroundColor(.edibleGreen)

                VStack(spacing: Spacing.xs) {
                    Text("What are you in the mood for?")
                        .font(.edibleSubheadline)
                        .foregroundColor(.edibleTextPrimary)

                    Text("Tell me about your plans and I'll curate the perfect dining experience.")
                        .font(.edibleBody)
                        .foregroundColor(.edibleTextSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, Spacing.xl)
                }

                // Suggestion chips
                VStack(spacing: Spacing.sm) {
                    ForEach(suggestions, id: \.self) { suggestion in
                        Button(action: { sendMessage(suggestion) }) {
                            HStack {
                                Text(suggestion)
                                    .font(.edibleBody)
                                    .foregroundColor(.edibleGreen)
                                Spacer()
                                Image(systemName: "arrow.up.circle.fill")
                                    .foregroundColor(.edibleGreen)
                            }
                            .padding(.horizontal, Spacing.md)
                            .padding(.vertical, Spacing.sm)
                            .background(Color.edibleCardBackground)
                            .cornerRadius(CornerRadius.medium)
                            .overlay(
                                RoundedRectangle(cornerRadius: CornerRadius.medium)
                                    .stroke(Color.edibleBorder, lineWidth: 1)
                            )
                        }
                    }
                }
                .padding(.horizontal, Spacing.lg)

                Spacer()
            }
        }
    }

    // MARK: - Chat List
    private var chatListView: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: Spacing.md) {
                    ForEach(messages) { message in
                        chatBubble(for: message)
                            .id(message.id)
                    }

                    if isLoading {
                        HStack(spacing: Spacing.xs) {
                            ProgressView()
                                .tint(.edibleGreen)
                            Text("Curating your experience...")
                                .font(.edibleCaption)
                                .foregroundColor(.edibleTextSecondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, Spacing.md)
                        .id("loading")
                    }
                }
                .padding(.vertical, Spacing.md)
            }
            .onChange(of: messages.count) { _, _ in
                if let lastMessage = messages.last {
                    withAnimation {
                        proxy.scrollTo(lastMessage.id, anchor: .bottom)
                    }
                }
            }
            .onChange(of: isLoading) { _, newValue in
                if newValue {
                    withAnimation {
                        proxy.scrollTo("loading", anchor: .bottom)
                    }
                }
            }
        }
    }

    private func chatBubble(for message: ChatMessage) -> some View {
        HStack {
            if message.isUser { Spacer(minLength: Spacing.xl) }

            VStack(alignment: message.isUser ? .trailing : .leading, spacing: Spacing.xxs) {
                if !message.isUser {
                    HStack(spacing: Spacing.xxs) {
                        Image(systemName: "sparkles")
                            .font(.system(size: 12))
                            .foregroundColor(.edibleGreen)
                        Text("Edible Concierge")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.edibleGreen)
                    }
                }

                Text(message.content)
                    .font(.edibleBody)
                    .foregroundColor(message.isUser ? .white : .edibleTextPrimary)
                    .padding(.horizontal, Spacing.md)
                    .padding(.vertical, Spacing.sm)
                    .background(message.isUser ? Color.edibleGreen : Color.edibleCardBackground)
                    .cornerRadius(CornerRadius.large)
                    .overlay(
                        RoundedRectangle(cornerRadius: CornerRadius.large)
                            .stroke(message.isUser ? Color.clear : Color.edibleBorder, lineWidth: 1)
                    )
            }

            if !message.isUser { Spacer(minLength: Spacing.xl) }
        }
        .padding(.horizontal, Spacing.md)
    }

    // MARK: - Input Bar
    private var inputBar: some View {
        HStack(spacing: Spacing.sm) {
            TextField("Plan an experience...", text: $inputText)
                .font(.edibleBody)
                .foregroundColor(.edibleTextPrimary)
                .focused($isInputFocused)
                .onSubmit { sendCurrentMessage() }

            Button(action: { sendCurrentMessage() }) {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 28))
                    .foregroundColor(inputText.isEmpty ? .edibleTextSecondary : .edibleGreen)
            }
            .disabled(inputText.isEmpty || isLoading)
        }
        .padding(.horizontal, Spacing.md)
        .padding(.vertical, Spacing.sm)
        .background(Color.edibleCardBackground)
    }

    // MARK: - Actions
    private func sendCurrentMessage() {
        let text = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }
        inputText = ""
        sendMessage(text)
    }

    private func sendMessage(_ text: String) {
        let userMessage = ChatMessage(role: "user", content: text, isUser: true)
        messages.append(userMessage)
        isLoading = true

        let apiMessages = messages.map { msg in
            ["role": msg.role, "content": msg.content]
        }

        Task {
            do {
                let response = try await AIService.shared.sendExperienceChat(messages: apiMessages)
                await MainActor.run {
                    let assistantMessage = ChatMessage(role: "assistant", content: response, isUser: false)
                    messages.append(assistantMessage)
                    isLoading = false
                }
            } catch {
                await MainActor.run {
                    let errorMessage = ChatMessage(role: "assistant", content: "Sorry, I couldn't process that right now. Please try again.", isUser: false)
                    messages.append(errorMessage)
                    isLoading = false
                }
            }
        }
    }
}

struct EdibleExperiencesScreen_Previews: PreviewProvider {
    static var previews: some View {
        EdibleExperiencesScreen()
    }
}
