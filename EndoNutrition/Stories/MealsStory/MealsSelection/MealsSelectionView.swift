import SwiftUI
import Combine

struct MealsSelectionView: View {
    // MARK: - Properties
    
    // Binding per i dati delle card
    @Binding var cards: [Meal]
    @Binding var hasInteracted: Bool

    
    // Stati UI ottimizzati con @State per lo storage locale
    @State private var cardOffset: CGFloat = 0
    @State private var isDragging = false
    @State private var isShowingHint = false
    
    // Timer ottimizzato come AnyCancellable
    @State private var hintTimer: AnyCancellable?
    
    // Proprietà misurabili per ottimizzare le prestazioni
    @State private var timerStarted = false
    
    // Costanti
    private let cornerRadius: CGFloat = 20
    private let dragThreshold: CGFloat = 100
    private let hintOffset: CGFloat = -30
    
    // Callback ottimizzato (Sendable per la concorrenza moderna)
    var onCardSelected: ((Meal) -> Void)?
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            // Ottimizzazione del rendering: solo le card visibili
            ForEach(Array(zip(cards.prefix(3).indices, cards.prefix(3))), id: \.0) { index, card in
                MealCardView(
                    meal: card,
                    isTopCard: index == 0,
                    offset: index == 0 ? cardOffset : 0,
                    cornerRadius: cornerRadius,
                    index: index
                )
                .zIndex(Double(cards.count - index))
                // Applica il gesto solo alla prima card
                .if(index == 0) { view in
                    view.gesture(dragGesture)
                }
            }
        }
        .onAppear {
            // Notifica la selezione iniziale, evitando operazioni costose ripetute
            if let firstCard = cards.first, !timerStarted {
                onCardSelected?(firstCard)
                setupHintTimer()
                timerStarted = true
            }
        }
        .onDisappear {
            // Pulizia esplicita delle risorse
            hintTimer?.cancel()
        }
    }
    
    // MARK: - Metodi privati
    
    // Setup ottimizzato del timer di suggerimento
    private func setupHintTimer() {
        hintTimer = Timer.publish(every: 5, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                // Verifica delle condizioni per mostrare il suggerimento
                if !self.isDragging && !self.isShowingHint && !self.hasInteracted {
                    self.showSwipeHint()
                }
            }
    }
    
    // Ottimizzazione dell'animazione di suggerimento
    private func showSwipeHint() {
        isShowingHint = true
        
        // Animazione fluida, evitando delay chains quando possibile
        withAnimation(.easeInOut(duration: 0.4)) {
            cardOffset = hintOffset
        }
        
        // Task asincrono per ritardare il reset con meno overhead
        Task { @MainActor in
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            
            withAnimation(.easeInOut(duration: 0.3)) {
                cardOffset = 0
            }
            
            try? await Task.sleep(nanoseconds: 500_000_000)
            isShowingHint = false
        }
    }
    
    // Ottimizzazione del gesto di trascinamento
    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 5) // Evita di attivare il gesto per movimenti piccoli
            .onChanged { value in
                // Ottimizzazione della logica durante il trascinamento
                if isShowingHint {
                    isShowingHint = false
                }
                
                if !hasInteracted {
                    hasInteracted = true
                }
                
                isDragging = true
                cardOffset = value.translation.width
            }
            .onEnded { value in
                isDragging = false
                
                // Ottimizzazione della logica di fine trascinamento
                let isDraggedPastThreshold = abs(value.translation.width) > dragThreshold
                
                if isDraggedPastThreshold {
                    let direction = value.translation.width > 0 ? 1000.0 : -1000.0
                    
                    withAnimation(.easeOut(duration: 0.1)) {
                        cardOffset = direction
                    }
                    
                    // Ottimizzazione dell'aggiornamento delle card
                    Task { @MainActor in
                        try? await Task.sleep(nanoseconds: 100_000_000)
                        
                        // Aggiornamento atomico dello stato
                        if cards.isEmpty { return }
                        
                        let topCard = cards.removeFirst()
                        cards.append(topCard)
                        cardOffset = 0
                        
                        // Notifica la nuova card selezionata
                        if let newTopCard = cards.first {
                            onCardSelected?(newTopCard)
                        }
                    }
                } else {
                    // Reset immediato senza animazione
                    cardOffset = 0
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
