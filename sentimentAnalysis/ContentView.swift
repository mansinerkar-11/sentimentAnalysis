
import SwiftUI
import NaturalLanguage

struct ContentView: View {
    
    @State private var inputText: String = ""
    
    
    private var sentimentAnalysis: (score: String, result: SentimentResult) {
        let score = analyzeSentiment(for: inputText)
        let result = getSentimentResult(from: score)
        return (score, result)
    }
    
    enum SentimentResult {
        case veryPositive, positive, neutral, negative, veryNegative, empty
        
        var emoji: String {
            switch self {
            case .veryPositive: return "😍"
            case .positive: return "😊"
            case .neutral: return "😐"
            case .negative: return "😔"
            case .veryNegative: return "😠"
            case .empty: return "📝"
            }
        }
        
        var description: String {
            switch self {
            case .veryPositive: return "Very Positive"
            case .positive: return "Positive"
            case .neutral: return "Neutral"
            case .negative: return "Negative"
            case .veryNegative: return "Very Negative"
            case .empty: return "Enter text to analyze"
            }
        }
        
        var color: Color {
            switch self {
            case .veryPositive: return .green
            case .positive: return .mint
            case .neutral: return .gray
            case .negative: return .orange
            case .veryNegative: return .red
            case .empty: return .white
            }
        }
    }
    
    private let tagger = NLTagger(tagSchemes: [.sentimentScore])
    
    private func analyzeSentiment(for stringToAnalyze: String) -> String {
        guard !stringToAnalyze.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return "0.0"
        }
        
        tagger.string = stringToAnalyze
        
        let (sentimentScore, _) = tagger.tag(
            at: stringToAnalyze.startIndex,
            unit: .paragraph,
            scheme: .sentimentScore
        )
        
        return sentimentScore?.rawValue ?? "0.0"
    }
    
    private func getSentimentResult(from score: String) -> SentimentResult {
        guard !inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return .empty
        }
        
        guard let numericScore = Double(score) else {
            return .neutral
        }
        
        switch numericScore {
        case 0.6...1.0:
            return .veryPositive
        case 0.1..<0.6:
            return .positive
        case -0.1..<0.1:
            return .neutral
        case -0.6..<(-0.1):
            return .negative
        case -1.0..<(-0.6):
            return .veryNegative
        default:
            return .neutral
        }
    }
    
    private func clearText() {
        inputText = ""
    }
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack(spacing: 30) {
                VStack(spacing: 10) {
                    Text("Sentiment Analyzer")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                    
                    Text("Discover the emotional tone of your text")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.top, 20)
                
                // Sentiment Display Card
                VStack(spacing: 15) {
                    Text(sentimentAnalysis.result.emoji)
                        .font(.system(size: 80))
                    
                    Text(sentimentAnalysis.result.description)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(sentimentAnalysis.result.color)
                    
                    if sentimentAnalysis.result != .empty {
                        Text("Score: \(sentimentAnalysis.score)")
                            .font(.title3)
                            .monospacedDigit()
                            .foregroundColor(.white)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 30)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(.systemBackground).opacity(0.2))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white.opacity(0.1), lineWidth: 1)
                        )
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                )
                .padding(.horizontal)
                
                // Text Input
                VStack(alignment: .leading, spacing: 10) {
                    Text("Enter your text:")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $inputText)
                            .frame(height: 120)
                            .padding(8)
                            .background(Color(.systemBackground).opacity(0.2))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                            .font(.body)
                            .foregroundColor(.white)
                            .scrollContentBackground(.hidden) // Hide default background
                        
                        if inputText.isEmpty {
                            Text("Type your message here...")
                                .foregroundColor(.gray)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 16)
                                .allowsHitTesting(false)
                        }
                    }
                }
                .padding(.horizontal)
                
                // Clear Button
                if !inputText.isEmpty {
                    Button(action: clearText) {
                        HStack {
                            Image(systemName: "trash")
                            Text("Clear Text")
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(Color.orange)
                        .cornerRadius(10)
                        
                    }
                }
                
                Spacer()
                
                // Info Section
                VStack(spacing: 8) {
                    Text("Made by ♥ Mansi Nerkar")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .padding(.bottom, 20)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: sentimentAnalysis.result)
        .animation(.easeInOut(duration: 0.3), value: inputText.isEmpty)
    }
}

#Preview {
    ContentView()
}
