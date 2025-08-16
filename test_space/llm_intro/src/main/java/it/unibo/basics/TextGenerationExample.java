package it.unibo.basics;

import dev.langchain4j.data.message.UserMessage;
import dev.langchain4j.model.chat.ChatLanguageModel;
import dev.langchain4j.model.ollama.OllamaChatModel;

public class TextGenerationExample {
    public static void main(String[] args) {
        ChatLanguageModel model = OllamaChatModel.builder()
            .baseUrl("http://localhost:11434")
            .logRequests(true)
            .logResponses(true)
            .modelName("smollm:360m")
            .numPredict(128)
            //.temperature(0.0)
            .build();
        final UserMessage message = UserMessage.userMessage("Say Hello!");
        var response = model.chat(message);
        System.out.println("Token used: " + response.tokenUsage().inputTokenCount());
        System.out.println("Toked in output: " + response.tokenUsage().outputTokenCount());
        System.out.println("Response: " + response.aiMessage().text());
    }
}
