import SwiftUI

struct FlipDigitView: View {
    let digit: Int
    let size: CGFloat

    @State private var currentDigit: Int
    @State private var previousDigit: Int
    @State private var topFlapAngle: Double = 0
    @State private var bottomFlapAngle: Double = -90

    init(digit: Int, size: CGFloat = 60) {
        self.digit = digit
        self.size = size
        _currentDigit = State(initialValue: digit)
        _previousDigit = State(initialValue: digit)
    }

    private var cardWidth: CGFloat { size * 0.7 }
    private var cardHeight: CGFloat { size }
    private var fontSize: CGFloat { size * 0.75 }
    private var cornerRadius: CGFloat { size * 0.1 }

    var body: some View {
        ZStack {
            // Layer 1: Static bottom half — NEW digit (revealed when bottom flap flips in)
            digitCard(digit: currentDigit, half: .bottom)

            // Layer 2: Static top half — NEW digit (revealed when top flap flips away)
            digitCard(digit: currentDigit, half: .top)

            // Layer 3: Bottom flap — NEW digit swinging from -90° to 0°
            digitCard(digit: currentDigit, half: .bottom)
                .rotation3DEffect(
                    .degrees(bottomFlapAngle),
                    axis: (x: 1, y: 0, z: 0),
                    anchor: .top,
                    perspective: 0.5
                )
                .opacity(bottomFlapAngle < -1 ? 1 : 0)

            // Layer 4: Top flap — OLD digit swinging from 0° to -90°
            digitCard(digit: previousDigit, half: .top)
                .rotation3DEffect(
                    .degrees(topFlapAngle),
                    axis: (x: 1, y: 0, z: 0),
                    anchor: .bottom,
                    perspective: 0.5
                )
                .opacity(topFlapAngle < -1 ? 1 : 0)
        }
        .frame(width: cardWidth, height: cardHeight)
        .onChange(of: digit) { _, newValue in
            guard newValue != currentDigit else { return }
            previousDigit = currentDigit
            currentDigit = newValue

            // Reset flap positions (avoid exactly ±90° to prevent singular projection matrix)
            topFlapAngle = 0
            bottomFlapAngle = -89.9

            // Phase 1: Top flap folds down (old digit disappears)
            withAnimation(.easeIn(duration: 0.2)) {
                topFlapAngle = -89.9
            } completion: {
                // Phase 2: Bottom flap unfolds (new digit appears)
                withAnimation(.easeOut(duration: 0.2)) {
                    bottomFlapAngle = 0
                }
            }
        }
    }

    private func digitCard(digit: Int, half: CardHalf) -> some View {
        Text("\(digit)")
            .font(.system(size: fontSize, weight: .bold, design: .rounded))
            .monospacedDigit()
            .foregroundStyle(.primary)
            .frame(width: cardWidth, height: cardHeight)
            .background(Color(.systemGray5))
            .clipShape(
                CardHalfShape(half: half, cornerRadius: cornerRadius)
            )
    }
}

private enum CardHalf {
    case top, bottom
}

private struct CardHalfShape: Shape {
    let half: CardHalf
    let cornerRadius: CGFloat

    func path(in rect: CGRect) -> Path {
        let gap: CGFloat = 0.5
        let halfRect: CGRect
        switch half {
        case .top:
            halfRect = CGRect(
                x: rect.minX,
                y: rect.minY,
                width: rect.width,
                height: rect.midY - gap
            )
        case .bottom:
            halfRect = CGRect(
                x: rect.minX,
                y: rect.midY + gap,
                width: rect.width,
                height: rect.midY - gap
            )
        }

        let corners: UIRectCorner = half == .top
            ? [.topLeft, .topRight]
            : [.bottomLeft, .bottomRight]

        return Path(
            UIBezierPath(
                roundedRect: halfRect,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
            ).cgPath
        )
    }
}

#Preview {
    HStack(spacing: 4) {
        FlipDigitView(digit: 3, size: 60)
        FlipDigitView(digit: 7, size: 60)
    }
    .padding()
}
