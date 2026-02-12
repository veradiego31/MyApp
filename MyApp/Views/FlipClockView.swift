import SwiftUI

struct FlipClockView: View {
    let timeComponents: TimeComponents

    var body: some View {
        GeometryReader { geo in
            let digitCount = timeComponents.dayDigits.count + 2 + 2 + 2
            let computedSize = computeDigitSize(
                availableWidth: geo.size.width,
                digitCount: digitCount
            )
            HStack(spacing: computedSize.groupSpacing) {
                digitGroup(digits: timeComponents.dayDigits, label: "DAYS", digitSize: computedSize.digit)
                separatorColon(size: computedSize.digit)
                digitGroup(digits: timeComponents.hourDigits, label: "HRS", digitSize: computedSize.digit)
                separatorColon(size: computedSize.digit)
                digitGroup(digits: timeComponents.minuteDigits, label: "MIN", digitSize: computedSize.digit)
                separatorColon(size: computedSize.digit)
                digitGroup(digits: timeComponents.secondDigits, label: "SEC", digitSize: computedSize.digit)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .frame(height: 80)
    }

    private struct ComputedSize {
        let digit: CGFloat
        let groupSpacing: CGFloat
    }

    private func computeDigitSize(availableWidth: CGFloat, digitCount: Int) -> ComputedSize {
        // Layout budget:
        //   digitCount * (digitSize * 0.7)        — card widths
        // + (digitCount - 4) * 2                   — intra-group gaps (2pt each)
        // + 6 * groupSpacing                       — gaps between groups & colons
        // + 3 * (digitSize * 0.35)                 — colon widths
        //
        // Solve for digitSize with groupSpacing = digitSize * 0.15

        let cardRatio: CGFloat = 0.7
        let colonRatio: CGFloat = 0.35
        let spacingRatio: CGFloat = 0.15
        let intraGaps = CGFloat(digitCount - 4) * 2

        // totalWidth = digitSize * (digitCount * cardRatio + 3 * colonRatio + 6 * spacingRatio) + intraGaps
        let factor = CGFloat(digitCount) * cardRatio + 3 * colonRatio + 6 * spacingRatio
        let digitSize = min(54, (availableWidth - intraGaps) / factor)
        let groupSpacing = digitSize * spacingRatio

        return ComputedSize(digit: digitSize, groupSpacing: groupSpacing)
    }

    private func digitGroup(digits: [Int], label: String, digitSize: CGFloat) -> some View {
        VStack(spacing: 4) {
            HStack(spacing: 2) {
                ForEach(Array(digits.enumerated()), id: \.offset) { _, digit in
                    FlipDigitView(digit: digit, size: digitSize)
                }
            }
            Text(label)
                .font(.caption2)
                .fontWeight(.semibold)
                .foregroundStyle(.white.opacity(0.8))
                .tracking(1)
        }
    }

    private func separatorColon(size: CGFloat) -> some View {
        VStack(spacing: 4) {
            Text(":")
                .font(.system(size: size * 0.4, weight: .bold, design: .rounded))
                .foregroundStyle(.white.opacity(0.8))
                .offset(y: -2)
            Text(" ")
                .font(.caption2)
        }
    }
}

#Preview {
    FlipClockView(
        timeComponents: TimeComponents(days: 107, hours: 12, minutes: 30, seconds: 45)
    )
    .padding()
}
