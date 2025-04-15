//
//  AddDishView.swift
//  EndoNutrition
//
//  Created by Endo on 15/04/25.
//

import SwiftUI

struct AddDishView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @StateObject private var viewModel = AddDishViewModel()
    @State private var selectedTab = 0
    @State private var showingAddIngredientSheet = false
    @State private var showingAddNutritionSheet = false
    @State private var showingAddStepSheet = false
    @State private var isEditing = false
    
    let editDish: Dish?
    
    init(editDish: Dish? = nil) {
        self.editDish = editDish
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                AddDishHeaderView()
                
                AddDishFormView(
                    name: $viewModel.name,
                    description: $viewModel.description,
                    mealType: $viewModel.mealType,
                    executionTime: $viewModel.executionTime
                )
                
                AddDishTabView(selectedTab: $selectedTab)
                
                tabContent
                
                AddDishSaveButton(
                    isEditing: isEditing,
                    isValid: !viewModel.name.isEmpty && !viewModel.ingredients.isEmpty
                ) {
                    if isEditing {
                        viewModel.updateDish()
                    } else {
                        viewModel.saveDish()
                    }
                    dismiss()
                }
            }
            .padding(.bottom, 40)
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle(isEditing ? "Edit Dish" : "Add Dish")
        .sheet(isPresented: $showingAddIngredientSheet) {
            AddIngredientSheet(ingredients: $viewModel.ingredients)
        }
        .sheet(isPresented: $showingAddNutritionSheet) {
            AddNutritionSheet(nutritionFacts: $viewModel.nutritionFacts)
        }
        .sheet(isPresented: $showingAddStepSheet) {
            AddStepSheet(preparationSteps: $viewModel.preparationSteps)
        }
        .onAppear {
            if let dish = editDish {
                viewModel.loadDish(dish)
                isEditing = true
            }
        }
    }
    
    private var tabContent: some View {
        Group {
            switch selectedTab {
            case 0:
                AddDishIngredientsView(
                    ingredients: $viewModel.ingredients,
                    onAddIngredient: { showingAddIngredientSheet = true },
                    onRemoveIngredient: { viewModel.removeIngredient($0) }
                )
            case 1:
                AddDishNutritionView(
                    nutritionFacts: $viewModel.nutritionFacts,
                    onAddNutrition: { showingAddNutritionSheet = true },
                    onRemoveNutrition: { viewModel.removeNutritionFact(key: $0) }
                )
            case 2:
                AddDishStepsView(
                    preparationSteps: $viewModel.preparationSteps,
                    onAddStep: { showingAddStepSheet = true },
                    onRemoveStep: { viewModel.removeStep($0) }
                )
            default:
                EmptyView()
            }
        }
    }
}

struct AddDishHeaderView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        ZStack {
            Circle()
                .fill(colorScheme == .dark ? Color(UIColor.systemGray6) : Color.white)
                .frame(width: 120, height: 120)
                .shadow(color: colorScheme == .dark ? Color.black.opacity(0.3) : Color.black.opacity(0.1),
                        radius: colorScheme == .dark ? 10 : 8,
                        x: 0,
                        y: colorScheme == .dark ? 6 : 4)
            
            Image(systemName: "fork.knife")
                .resizable()
                .scaledToFit()
                .foregroundColor(colorScheme == .dark ? Color(UIColor.systemGray2) : Color.gray)
                .frame(width: 60, height: 60)
        }
        .padding(.top, 30)
    }
}

struct AddDishFormView: View {
    @Binding var name: String
    @Binding var description: String
    @Binding var mealType: MealType
    @Binding var executionTime: Dish.ExecutionTime
    
    var body: some View {
        VStack(spacing: 20) {
            // Name field
            VStack(alignment: .leading, spacing: 8) {
                Text("Dish Name")
                    .font(.headline)
                    .foregroundColor(Color(UIColor.label))
                
                TextField("Enter dish name", text: $name)
                    .padding()
                    .background(Color.darkModeBgColor)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 1)
            }
            .padding(.horizontal)
            
            // Description field
            VStack(alignment: .leading, spacing: 8) {
                Text("Description")
                    .font(.headline)
                    .foregroundColor(Color(UIColor.label))
                
                TextEditor(text: $description)
                    .frame(height: 100)
                    .padding(10)
                    .background(Color.darkModeBgColor)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 1)
            }
            .padding(.horizontal)
            
            // Meal type picker
            VStack(alignment: .leading, spacing: 8) {
                Text("Meal Type")
                    .font(.headline)
                    .foregroundColor(Color(UIColor.label))
                
                Picker("Meal Type", selection: $mealType) {
                    Text("Breakfast").tag(MealType.breakfast)
                    Text("Lunch").tag(MealType.lunch)
                    Text("Dinner").tag(MealType.dinner)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .background(Color.darkModeBgColor)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 1)
            }
            .padding(.horizontal)
            
            // Execution time picker
            VStack(alignment: .leading, spacing: 8) {
                Text("Preparation Time")
                    .font(.headline)
                    .foregroundColor(Color(UIColor.label))
                
                HStack {
                    TimeButton(
                        title: "Fast",
                        isSelected: executionTime == .fast,
                        color: .green
                    ) {
                        executionTime = .fast
                    }
                    
                    TimeButton(
                        title: "Medium",
                        isSelected: executionTime == .medium,
                        color: .orange
                    ) {
                        executionTime = .medium
                    }
                    
                    TimeButton(
                        title: "Slow",
                        isSelected: executionTime == .slow,
                        color: .red
                    ) {
                        executionTime = .slow
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct TimeButton: View {
    let title: String
    let isSelected: Bool
    let color: Color
    let action: () -> Void
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Circle()
                    .fill(isSelected ? color : Color.gray.opacity(0.3))
                    .frame(width: 40, height: 40)
                    .overlay(
                        Image(systemName: "clock.fill")
                            .foregroundColor(.white)
                    )
                    .shadow(color: isSelected ? color.opacity(0.3) : Color.clear, radius: 3)
                
                Text(title)
                    .font(.caption)
                    .fontWeight(isSelected ? .bold : .regular)
                    .foregroundColor(isSelected ? color : Color(UIColor.secondaryLabel))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(isSelected ?
                        Color.darkModeBgColor :
                        colorScheme == .dark ? Color(UIColor.systemGray5) : Color(UIColor.systemGray6))
            .cornerRadius(10)
        }
    }
}

struct AddDishTabView: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack(spacing: 0) {
            TabButton(
                title: "Ingredients",
                icon: "leaf.fill",
                isSelected: selectedTab == 0
            ) {
                selectedTab = 0
            }
            
            TabButton(
                title: "Nutrition",
                icon: "heart.fill",
                isSelected: selectedTab == 1
            ) {
                selectedTab = 1
            }
            
            TabButton(
                title: "Steps",
                icon: "list.bullet",
                isSelected: selectedTab == 2
            ) {
                selectedTab = 2
            }
        }
        .background(Color.darkModeBgColor)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 1)
        .padding(.horizontal)
        .padding(.top, 10)
    }
}

struct TabButton: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            .foregroundColor(isSelected ? Color.blue : Color(UIColor.secondaryLabel))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
                isSelected ?
                    Color.blue.opacity(0.1) :
                    Color.clear
            )
            .cornerRadius(12)
        }
    }
}


struct AddDishIngredientsView: View {
    @Binding var ingredients: [Dish.Ingredients]
    var onAddIngredient: () -> Void
    var onRemoveIngredient: (Dish.Ingredients) -> Void
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Text("Ingredients")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor.label))
                
                Spacer()
                
                Button(action: onAddIngredient) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal)
            
            if ingredients.isEmpty {
                EmptyStateView(
                    icon: "leaf.fill",
                    message: "No ingredients added yet",
                    buttonText: "Add Ingredient"
                ) {
                    onAddIngredient()
                }
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(ingredients) { ingredient in
                            IngredientCardView(ingredient: ingredient) {
                                onRemoveIngredient(ingredient)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .padding(.top)
    }
}

struct IngredientCardView: View {
    let ingredient: Dish.Ingredients
    let onDelete: () -> Void
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(alignment: .center, spacing: 6) {
            ZStack {
                Circle()
                    .fill(Color.green.opacity(0.1))
                    .frame(width: 60, height: 60)
                
                Image(systemName: "leaf.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.green)
            }
            
            Text(ingredient.name)
                .font(.headline)
                .foregroundColor(Color(UIColor.label))
                .multilineTextAlignment(.center)
                .frame(width: 100)
                .lineLimit(2)
            
            Text("\(Int(ingredient.quantity)) \(ingredient.quantityType.rawValue)")
                .font(.caption)
                .foregroundColor(Color(UIColor.secondaryLabel))
            
            Button(action: onDelete) {
                Image(systemName: "minus.circle.fill")
                    .foregroundColor(.red)
            }
            .padding(.top, 6)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 10)
        .background(Color.darkModeBgColor)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 1)
    }
}

struct AddDishNutritionView: View {
    @Binding var nutritionFacts: [String: String]
    var onAddNutrition: () -> Void
    var onRemoveNutrition: (String) -> Void
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Text("Nutrition Facts")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor.label))
                
                Spacer()
                
                Button(action: onAddNutrition) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal)
            
            if nutritionFacts.isEmpty {
                EmptyStateView(
                    icon: "heart.text.square.fill",
                    message: "No nutrition info added yet",
                    buttonText: "Add Nutrition Info"
                ) {
                    onAddNutrition()
                }
            } else {
                VStack(spacing: 12) {
                    ForEach(Array(nutritionFacts.keys.sorted()), id: \.self) { key in
                        if let value = nutritionFacts[key] {
                            NutritionRowView(label: key, value: value) {
                                onRemoveNutrition(key)
                            }
                        }
                    }
                }
                .padding()
                .background(Color.darkModeBgColor)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 1)
                .padding(.horizontal)
            }
        }
        .padding(.top)
    }
}

struct NutritionRowView: View {
    let label: String
    let value: String
    let onDelete: () -> Void
    
    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(Color(UIColor.label))
            
            Spacer()
            
            Text(value)
                .font(.subheadline)
                .foregroundColor(Color(UIColor.secondaryLabel))
            
            Button(action: onDelete) {
                Image(systemName: "minus.circle.fill")
                    .foregroundColor(.red)
            }
            .padding(.leading, 8)
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
        .background(Color.blue.opacity(0.05))
        .cornerRadius(10)
    }
}

struct AddDishStepsView: View {
    @Binding var preparationSteps: [Dish.PreparationStep]
    var onAddStep: () -> Void
    var onRemoveStep: (Dish.PreparationStep) -> Void
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Text("Preparation Steps")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor.label))
                
                Spacer()
                
                Button(action: onAddStep) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal)
            
            if preparationSteps.isEmpty {
                EmptyStateView(
                    icon: "list.bullet.rectangle.fill",
                    message: "No preparation steps added yet",
                    buttonText: "Add Steps"
                ) {
                    onAddStep()
                }
            } else {
                VStack(spacing: 15) {
                    ForEach(Array(preparationSteps.enumerated()), id: \.element.id) { index, step in
                        StepCardView(step: step, stepNumber: index + 1) {
                            onRemoveStep(step)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.top)
    }
}

struct StepCardView: View {
    let step: Dish.PreparationStep
    let stepNumber: Int
    let onDelete: () -> Void
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            ZStack {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 36, height: 36)
                
                Text("\(stepNumber)")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(step.title)
                    .font(.headline)
                    .foregroundColor(Color(UIColor.label))
                
                Text(step.description)
                    .font(.subheadline)
                    .foregroundColor(Color(UIColor.secondaryLabel))
                    .lineLimit(4)
            }
            
            Spacer()
            
            Button(action: onDelete) {
                Image(systemName: "minus.circle.fill")
                    .foregroundColor(.red)
            }
        }
        .padding()
        .background(Color.darkModeBgColor)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 1)
    }
}

struct AddDishSaveButton: View {
    let isEditing: Bool
    let isValid: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: isEditing ? "square.and.pencil" : "plus.circle.fill")
                    .font(.headline)
                
                Text(isEditing ? "Update Dish" : "Save Dish")
                    .font(.headline)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
            .padding(.horizontal)
            .padding(.top, 20)
        }
        .disabled(!isValid)
        .opacity(isValid ? 1 : 0.5)
    }
}

struct EmptyStateView: View {
    let icon: String
    let message: String
    let buttonText: String
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 15) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(Color(UIColor.systemGray3))
            
            Text(message)
                .font(.headline)
                .foregroundColor(Color(UIColor.secondaryLabel))
            
            Button(action: action) {
                Text(buttonText)
                    .font(.headline)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
        .background(Color.darkModeBgColor)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 1)
        .padding(.horizontal)
    }
}

struct AddIngredientSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var ingredients: [Dish.Ingredients]
    
    @State private var name: String = ""
    @State private var quantity: String = ""
    @State private var selectedQuantityType: Dish.QuantityType = .grams
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Ingredient Details")) {
                    TextField("Ingredient Name", text: $name)
                    
                    HStack {
                        TextField("Quantity", text: $quantity)
                            .keyboardType(.decimalPad)
                        
                        Picker("Unit", selection: $selectedQuantityType) {
                            Text("Grams").tag(Dish.QuantityType.grams)
                            Text("Pieces").tag(Dish.QuantityType.number)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 150)
                    }
                }
                
                Section {
                    Button(action: addIngredient) {
                        HStack {
                            Spacer()
                            Text("Add Ingredient")
                                .fontWeight(.semibold)
                            Spacer()
                        }
                    }
                    .disabled(name.isEmpty || quantity.isEmpty)
                }
            }
            .navigationTitle("Add Ingredient")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func addIngredient() {
        guard let quantityValue = Double(quantity) else { return }
        
        let newIngredient = Dish.Ingredients(
            name: name,
            quantity: quantityValue,
            quantityType: selectedQuantityType
        )
        
        ingredients.append(newIngredient)
        dismiss()
    }
}

struct AddNutritionSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var nutritionFacts: [String: String]
    
    @State private var label: String = ""
    @State private var value: String = ""
    
    private let commonLabels = ["Calories", "Protein", "Carbohydrates", "Fat", "Fiber", "Sugar", "Sodium"]
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Nutrition Facts Details")) {
                        if label.isEmpty {
                            Picker("Select Nutrient", selection: $label) {
                                Text("Custom").tag("")
                                ForEach(commonLabels, id: \.self) { label in
                                    Text(label).tag(label)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                        
                        if label.isEmpty {
                            TextField("Nutrient Name", text: $label)
                                .autocapitalization(.words)
                        }
                        
                        TextField("Value (e.g. 150 kcal, 10g)", text: $value)
                    }
                    
                    Section {
                        Button(action: addNutritionFact) {
                            HStack {
                                Spacer()
                                Text("Add Nutrition Fact")
                                    .fontWeight(.semibold)
                                Spacer()
                            }
                        }
                        .disabled(label.isEmpty || value.isEmpty)
                    }
                }
                
                if !nutritionFacts.isEmpty {
                    List {
                        Section(header: Text("Current Nutrition Facts")) {
                            ForEach(Array(nutritionFacts.keys.sorted()), id: \.self) { key in
                                if let value = nutritionFacts[key] {
                                    HStack {
                                        Text(key)
                                        Spacer()
                                        Text(value)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                        }
                    }
                    .frame(height: 200)
                }
            }
            .navigationTitle("Add Nutrition Facts")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func addNutritionFact() {
        guard !label.isEmpty && !value.isEmpty else { return }
        
        nutritionFacts[label] = value
        label = ""
        value = ""
    }
}

struct AddStepSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var preparationSteps: [Dish.PreparationStep]
    
    @State private var title: String = ""
    @State private var description: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Step Details")) {
                        TextField("Step Title", text: $title)
                        
                        ZStack(alignment: .topLeading) {
                            if description.isEmpty {
                                Text("Step Description")
                                    .foregroundColor(.gray.opacity(0.8))
                                    .padding(.top, 8)
                                    .padding(.leading, 4)
                            }
                            
                            TextEditor(text: $description)
                                .frame(minHeight: 100)
                                .padding(4)
                        }
                    }
                    
                    Section {
                        Button(action: addStep) {
                            HStack {
                                Spacer()
                                Text("Add Step")
                                    .fontWeight(.semibold)
                                Spacer()
                            }
                        }
                        .disabled(title.isEmpty || description.isEmpty)
                    }
                }
                
                if !preparationSteps.isEmpty {
                    List {
                        Section(header: Text("Current Steps")) {
                            ForEach(Array(preparationSteps.enumerated()), id: \.element.id) { index, step in
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Step \(index + 1): \(step.title)")
                                        .font(.headline)
                                    
                                    Text(step.description)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .lineLimit(2)
                                }
                                .padding(.vertical, 4)
                            }
                        }
                    }
                    .frame(height: 200)
                }
            }
            .navigationTitle("Add Preparation Step")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func addStep() {
        guard !title.isEmpty && !description.isEmpty else { return }
        
        let newStep = Dish.PreparationStep(
            title: title,
            description: description
        )
        
        preparationSteps.append(newStep)
        title = ""
        description = ""
    }
}

struct AddDishView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddDishView()
        }
    }
}
