import SwiftUI
import Combine

struct AudioWaveformView: View {
    let audioLevel: Float
    let barCount: Int = 40

    @State private var levels: [CGFloat] = Array(repeating: 0, count: 40)
    @State private var timer: AnyCancellable?

    var body: some View {
        HStack(spacing: 3) {
            ForEach(0..<barCount, id: \.self) { index in
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.edibleGreen.opacity(barOpacity(for: index)))
                    .frame(width: 4, height: barHeight(for: index))
            }
        }
        .frame(height: 48)
        .onAppear { startSampling() }
        .onDisappear { stopSampling() }
    }

    private func barHeight(for index: Int) -> CGFloat {
        let level = levels[index]
        let minHeight: CGFloat = 4
        let maxHeight: CGFloat = 46
        // Apply power curve to make peaks more dramatic
        let boosted = pow(level, 0.6)
        return minHeight + boosted * (maxHeight - minHeight)
    }

    private func barOpacity(for index: Int) -> Double {
        let center = Double(barCount - 1) / 2.0
        let distance = abs(Double(index) - center) / center
        return 0.5 + 0.5 * (1.0 - distance * 0.5)
    }

    private func startSampling() {
        timer = Timer.publish(every: 1.0 / 18.0, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                withAnimation(.interpolatingSpring(stiffness: 200, damping: 12)) {
                    levels.removeFirst()
                    let base = CGFloat(audioLevel)
                    // Boost the signal and add jitter for dramatic movement
                    let boosted = min(base * 1.5, 1.0)
                    let jitter = CGFloat.random(in: -0.12...0.12)
                    let newLevel = max(0, min(1, boosted + jitter))
                    levels.append(newLevel)
                }
            }
    }

    private func stopSampling() {
        timer?.cancel()
        timer = nil
    }
}
