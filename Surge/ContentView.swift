import SwiftUI
import SwiftData
import AVFoundation

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    let synthesizer = AVSpeechSynthesizer()

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                            .contextMenu {
                                Button("Play text") {
                                        let utterance = AVSpeechUtterance(string: "好痛 好痛")
                                        // 指定使用中文语音
                                        utterance.voice = AVSpeechSynthesisVoice(language: "zh-CN")
//                                        for voice in AVSpeechSynthesisVoice.speechVoices() {
//                                            print("语音名称: \(voice.name), 语言: \(voice.language), 标识符: \(voice.identifier)")
//                                        }
                                        utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.voice.premium.zh-CN.Yue")
                                        synthesizer.speak(utterance)
                                    
                                    }
                            }
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                    .contextMenu {
                        Button("Delete", role: .destructive) {
                            withAnimation {
                                modelContext.delete(item)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
            .toolbar {
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
