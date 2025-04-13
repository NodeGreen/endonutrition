import SwiftUI
import Combine

struct MealsSelectionView: View {
    @Binding var cards: [Meal]
    @Binding var hasInteracted: Bool
    
    @State private var cardPositions: [CardPosition] = []
    @State private var isDragging = false
    @State private var isShowingHint = false
    @State private var timerStarted = false
    
    @State private var hintTimer: AnyCancellable?
    
    private let cornerRadius: CGFloat = 20
    private let dragThreshold: CGFloat = 100
    private let hintOffset: CGFloat = -30
    private let rotationFactor: CGFloat = 0.1
    
    var onCardSelected: ((Meal) -> Void)?
    
    private struct CardPosition: Identifiable {
        let id = UUID()
        var offsetX: CGFloat = 0
        var offsetY: CGFloat = 0
        var rotation: Double = 0
        var index: Int
        var isAnimating = false
    }
    
    var body: some View {
        ZStack {
            if !cards.isEmpty && !cardPositions.isEmpty {
                ForEach(Array(cardPositions.prefix(3).enumerated()), id: \.element.id) { i, position in
                    if position.index < cards.count {
                        MealCardView(
                            meal: cards[position.index],
                            isTopCard: i == 0,
                            offset: position.offsetX,
                            cornerRadius: cornerRadius,
                            index: i,
                            offsetY: position.offsetY
                        )
                        .rotationEffect(.degrees(position.rotation))
                        .zIndex(Double(100 - i))
                        .gesture(i == 0 ? dragGesture : nil)
                        .transition(.identity)
                    }
                }
            }
        }
        .animation(nil, value: cardPositions.count)
        .onAppear {
            resetCardPositions()
        }
        .onChange(of: cards) { _ in
            resetCardPositions()
        }
        .onDisappear {
            hintTimer?.cancel()
        }
    }
    
    private func resetCardPositions() {
        if cards.isEmpty {
            cardPositions = []
            return
        }
        
        cardPositions = []
        for i in 0..<min(cards.count, 3) {
            cardPositions.append(CardPosition(index: i))
        }
        
        if let firstCard = cards.first, !timerStarted {
            DispatchQueue.main.async {
                onCardSelected?(firstCard)
                setupHintTimer()
                timerStarted = true
            }
        }
    }
    
    private func setupHintTimer() {
        hintTimer?.cancel()
        hintTimer = Timer.publish(every: 5, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if !isDragging && !isShowingHint && !hasInteracted {
                    showSwipeHint()
                }
            }
    }
    
    private func showSwipeHint() {
        isShowingHint = true
        
        guard !cardPositions.isEmpty else { return }
        
        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
            cardPositions[0].offsetX = hintOffset
            cardPositions[0].rotation = -5
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                if !cardPositions.isEmpty {
                    cardPositions[0].offsetX = 0
                    cardPositions[0].offsetY = 0
                    cardPositions[0].rotation = 0
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isShowingHint = false
            }
        }
    }
    
    private func moveToNextCard() {
        guard cards.count > 1 else { return }
        
        if !cardPositions.isEmpty {
            let currentTopIndex = cardPositions[0].index
            let nextIndex = (currentTopIndex + 1) % cards.count
            
            var updatedPositions: [CardPosition] = []
            
            for i in 1..<cardPositions.count {
                var newPosition = cardPositions[i]
                newPosition.offsetX = 0
                newPosition.offsetY = 0
                newPosition.rotation = 0
                updatedPositions.append(newPosition)
            }
            
            let newCardIndex = (nextIndex + updatedPositions.count) % cards.count
            updatedPositions.append(CardPosition(index: newCardIndex))
            
            cardPositions = updatedPositions
            
            onCardSelected?(cards[nextIndex])
        }
    }
    
    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 5, coordinateSpace: .local)
            .onChanged { value in
                if isShowingHint {
                    isShowingHint = false
                }
                
                if !hasInteracted {
                    hasInteracted = true
                }
                
                isDragging = true
                
                if !cardPositions.isEmpty {
                    cardPositions[0].offsetX = value.translation.width
                    cardPositions[0].offsetY = min(0, value.translation.height)
                    
                    let maxRotation: Double = 12
                    let horizontalRotation = Double(value.translation.width * rotationFactor)
                    cardPositions[0].rotation = min(maxRotation, max(-maxRotation, horizontalRotation))
                }
            }
            .onEnded { value in
                isDragging = false
                
                let horizontalDragPastThreshold = abs(value.translation.width) > dragThreshold
                let verticalDragPastThreshold = value.translation.height < -dragThreshold
                
                if horizontalDragPastThreshold || verticalDragPastThreshold {
                    if !cardPositions.isEmpty {
                        let direction: CGFloat = value.translation.width > 0 ? 1000.0 : -1000.0
                        let finalRotation: Double = value.translation.width > 0 ? 12 : -12
                        
                        if verticalDragPastThreshold {
                            withAnimation(.spring(response: 0.25, dampingFraction: 0.7)) {
                                cardPositions[0].offsetY = -1000
                                cardPositions[0].rotation = 0
                            }
                        } else {
                            withAnimation(.spring(response: 0.25, dampingFraction: 0.7)) {
                                cardPositions[0].offsetX = direction
                                cardPositions[0].rotation = finalRotation
                            }
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            moveToNextCard()
                        }
                    }
                } else {
                    if !cardPositions.isEmpty {
                        withAnimation(.spring(response: 0.25, dampingFraction: 0.7)) {
                            cardPositions[0].offsetX = 0
                            cardPositions[0].offsetY = 0
                            cardPositions[0].rotation = 0
                        }
                    }
                }
            }
    }
}

// MARK: - Preview

// Preview ottimizzata per la verifica
struct MealsSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        MealsSelectionViewContainer()
    }
    
    // Container ottimizzato per il preview
    struct MealsSelectionViewContainer: View {
        @State private var meals: [Meal] = [
            Meal(id: 0, mealType: .breakfast),
            Meal(id: 1, mealType: .lunch),
            Meal(id: 2, mealType: .dinner)
        ]
        @State private var hasInteracted: Bool = false
        
        @State private var selectedMeal: Meal?
        
        var body: some View {
            VStack {
                if let meal = selectedMeal {
                    Text("Selezionato: \(meal.title)")
                        .padding()
                }
                
                MealsSelectionView(cards: $meals, hasInteracted: $hasInteracted, onCardSelected: { meal in
                    selectedMeal = meal
                })
            }
        }
    }
}

// Preview moderno per iOS 17+ ottimizzato
#if swift(>=5.9)
#Preview {
    MealsSelectionView_Previews.MealsSelectionViewContainer()
}
#endif
