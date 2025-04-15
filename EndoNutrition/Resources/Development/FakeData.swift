import Foundation

let meals: [Meal] = [
    Meal(id: 0, mealType: .breakfast),
    Meal(id: 1, mealType: .lunch),
    Meal(id: 2, mealType: .dinner)
]

let dishes: [Dish] = [
    // Colazione
    Dish(
        name: "Pancake integrali",
        mealType: .breakfast,
        executionTime: .medium,
        ingredients: [
            Dish.Ingredients(name: "Farina integrale", quantity: 150, quantityType: .grams),
            Dish.Ingredients(name: "Uova", quantity: 2, quantityType: .number),
            Dish.Ingredients(name: "Latte", quantity: 200, quantityType: .grams),
            Dish.Ingredients(name: "Miele", quantity: 30, quantityType: .grams)
        ],
        description: "Deliziosi pancake integrali con miele, perfetti per iniziare la giornata con energia e gusto.",
        nutritionFacts: [
            "Calorie": "320 kcal",
            "Proteine": "12g",
            "Carboidrati": "48g",
            "Grassi": "9g",
            "Fibre": "6g"
        ],
        preparationSteps: [
            Dish.PreparationStep(title: "Preparare gli ingredienti", description: "Misurare tutti gli ingredienti e metterli a portata di mano"),
            Dish.PreparationStep(title: "Mescolare", description: "In una ciotola unire farina, uova e latte fino a ottenere un composto liscio"),
            Dish.PreparationStep(title: "Cuocere", description: "Versare piccole quantità di pastella in una padella calda e cuocere 2 minuti per lato")
        ]
    ),
    
    Dish(
        name: "Yogurt greco con frutta",
        mealType: .breakfast,
        executionTime: .fast,
        ingredients: [
            Dish.Ingredients(name: "Yogurt greco", quantity: 150, quantityType: .grams),
            Dish.Ingredients(name: "Mirtilli", quantity: 50, quantityType: .grams),
            Dish.Ingredients(name: "Banana", quantity: 1, quantityType: .number),
            Dish.Ingredients(name: "Miele", quantity: 10, quantityType: .grams)
        ],
        description: "Colazione fresca e nutriente con yogurt greco ricco di proteine e frutta fresca.",
        nutritionFacts: [
            "Calorie": "210 kcal",
            "Proteine": "15g",
            "Carboidrati": "30g",
            "Grassi": "4g",
            "Fibre": "3g"
        ],
        preparationSteps: [
            Dish.PreparationStep(title: "Preparare la frutta", description: "Lavare i mirtilli e tagliare la banana a fettine"),
            Dish.PreparationStep(title: "Assemblare", description: "Versare lo yogurt in una ciotola e aggiungere la frutta sopra"),
            Dish.PreparationStep(title: "Completare", description: "Aggiungere un cucchiaino di miele e servire immediatamente")
        ]
    ),
    
    Dish(
        name: "Porridge con frutta secca",
        mealType: .breakfast,
        executionTime: .fast,
        ingredients: [
            Dish.Ingredients(name: "Fiocchi d'avena", quantity: 50, quantityType: .grams),
            Dish.Ingredients(name: "Latte", quantity: 200, quantityType: .grams),
            Dish.Ingredients(name: "Mandorle", quantity: 15, quantityType: .grams),
            Dish.Ingredients(name: "Datteri", quantity: 3, quantityType: .number)
        ],
        description: "Porridge cremoso con avena, arricchito da frutta secca energizzante e naturalmente dolce.",
        nutritionFacts: [
            "Calorie": "280 kcal",
            "Proteine": "10g",
            "Carboidrati": "45g",
            "Grassi": "8g",
            "Fibre": "5g"
        ],
        preparationSteps: [
            Dish.PreparationStep(title: "Preparare gli ingredienti", description: "Tritare grossolanamente le mandorle e i datteri"),
            Dish.PreparationStep(title: "Cuocere l'avena", description: "In un pentolino, portare a ebollizione il latte e aggiungere i fiocchi d'avena, cuocere a fiamma bassa per 3-4 minuti mescolando"),
            Dish.PreparationStep(title: "Servire", description: "Versare il porridge in una ciotola e guarnire con mandorle e datteri")
        ]
    ),
    
    Dish(
        name: "Uova strapazzate",
        mealType: .breakfast,
        executionTime: .fast,
        ingredients: [
            Dish.Ingredients(name: "Uova", quantity: 3, quantityType: .number),
            Dish.Ingredients(name: "Latte", quantity: 30, quantityType: .grams),
            Dish.Ingredients(name: "Sale", quantity: 2, quantityType: .grams),
            Dish.Ingredients(name: "Pepe", quantity: 1, quantityType: .grams)
        ],
        description: "Uova strapazzate cremose e saporite, ricche di proteine per iniziare la giornata.",
        nutritionFacts: [
            "Calorie": "215 kcal",
            "Proteine": "18g",
            "Carboidrati": "2g",
            "Grassi": "15g"
        ],
        preparationSteps: [
            Dish.PreparationStep(title: "Preparare le uova", description: "Rompere le uova in una ciotola e sbatterle con il latte, sale e pepe"),
            Dish.PreparationStep(title: "Cuocere", description: "Versare il composto in una padella antiaderente a fuoco medio-basso"),
            Dish.PreparationStep(title: "Mescolare", description: "Mescolare delicatamente con una spatola fino a quando le uova sono cotte ma ancora morbide")
        ]
    ),
    
    Dish(
        name: "Smoothie bowl",
        mealType: .breakfast,
        executionTime: .medium,
        ingredients: [
            Dish.Ingredients(name: "Banana", quantity: 1, quantityType: .number),
            Dish.Ingredients(name: "Fragole", quantity: 100, quantityType: .grams),
            Dish.Ingredients(name: "Yogurt", quantity: 100, quantityType: .grams),
            Dish.Ingredients(name: "Semi di chia", quantity: 10, quantityType: .grams),
            Dish.Ingredients(name: "Latte di mandorla", quantity: 100, quantityType: .grams)
        ],
        description: "Una colazione fresca e colorata a base di frutta e yogurt, ricca di antiossidanti e fibre.",
        nutritionFacts: [
            "Calorie": "240 kcal",
            "Proteine": "8g",
            "Carboidrati": "35g",
            "Grassi": "7g",
            "Fibre": "8g"
        ],
        preparationSteps: [
            Dish.PreparationStep(title: "Preparare la frutta", description: "Tagliare la banana a pezzi e lavare le fragole"),
            Dish.PreparationStep(title: "Frullare", description: "Mettere la frutta, lo yogurt e il latte di mandorla nel frullatore e frullare fino a ottenere una consistenza cremosa"),
            Dish.PreparationStep(title: "Servire", description: "Versare in una ciotola e guarnire con semi di chia e altra frutta fresca a piacere")
        ]
    ),
    
    // Pranzo
    Dish(
        name: "Insalata di quinoa",
        mealType: .lunch,
        executionTime: .medium,
        ingredients: [
            Dish.Ingredients(name: "Quinoa", quantity: 80, quantityType: .grams),
            Dish.Ingredients(name: "Pomodorini", quantity: 100, quantityType: .grams),
            Dish.Ingredients(name: "Cetriolo", quantity: 1, quantityType: .number),
            Dish.Ingredients(name: "Avocado", quantity: 0.5, quantityType: .number),
            Dish.Ingredients(name: "Olio d'oliva", quantity: 15, quantityType: .grams)
        ],
        description: "Insalata proteica e saziante con quinoa, verdure fresche e avocado cremoso.",
        nutritionFacts: [
            "Calorie": "380 kcal",
            "Proteine": "10g",
            "Carboidrati": "40g",
            "Grassi": "22g",
            "Fibre": "12g"
        ],
        preparationSteps: [
            Dish.PreparationStep(title: "Cuocere la quinoa", description: "Sciacquare la quinoa e cuocerla in acqua bollente per 15 minuti, quindi scolare e lasciar raffreddare"),
            Dish.PreparationStep(title: "Preparare le verdure", description: "Tagliare i pomodorini a metà, il cetriolo a dadini e l'avocado a cubetti"),
            Dish.PreparationStep(title: "Assemblare", description: "Mescolare tutti gli ingredienti in una ciotola, condire con olio d'oliva, sale e pepe")
        ]
    ),
    
    Dish(
        name: "Bowl di riso e verdure",
        mealType: .lunch,
        executionTime: .medium,
        ingredients: [
            Dish.Ingredients(name: "Riso integrale", quantity: 80, quantityType: .grams),
            Dish.Ingredients(name: "Carote", quantity: 50, quantityType: .grams),
            Dish.Ingredients(name: "Zucchine", quantity: 50, quantityType: .grams),
            Dish.Ingredients(name: "Peperoni", quantity: 50, quantityType: .grams),
            Dish.Ingredients(name: "Salsa di soia", quantity: 10, quantityType: .grams)
        ],
        description: "Bowl nutriente con riso integrale e verdure colorate saltate, condita con salsa di soia.",
        nutritionFacts: [
            "Calorie": "310 kcal",
            "Proteine": "7g",
            "Carboidrati": "65g",
            "Grassi": "3g",
            "Fibre": "7g"
        ],
        preparationSteps: [
            Dish.PreparationStep(title: "Cuocere il riso", description: "Sciacquare il riso e cuocerlo in acqua bollente per 30-35 minuti, quindi scolare"),
            Dish.PreparationStep(title: "Preparare le verdure", description: "Tagliare carote, zucchine e peperoni a julienne o a dadini piccoli"),
            Dish.PreparationStep(title: "Saltare le verdure", description: "In una padella con un filo d'olio, saltare le verdure per 5-7 minuti"),
            Dish.PreparationStep(title: "Servire", description: "Disporre il riso in una ciotola, aggiungere le verdure sopra e condire con salsa di soia")
        ]
    ),
    
    Dish(
        name: "Wrap di pollo",
        mealType: .lunch,
        executionTime: .medium,
        ingredients: [
            Dish.Ingredients(name: "Tortilla integrale", quantity: 1, quantityType: .number),
            Dish.Ingredients(name: "Petto di pollo", quantity: 100, quantityType: .grams),
            Dish.Ingredients(name: "Insalata", quantity: 30, quantityType: .grams),
            Dish.Ingredients(name: "Pomodoro", quantity: 50, quantityType: .grams),
            Dish.Ingredients(name: "Yogurt greco", quantity: 30, quantityType: .grams)
        ],
        description: "Wrap saporito con pollo grigliato, verdure fresche e salsa leggera allo yogurt.",
        nutritionFacts: [
            "Calorie": "350 kcal",
            "Proteine": "30g",
            "Carboidrati": "35g",
            "Grassi": "10g",
            "Fibre": "5g"
        ],
        preparationSteps: [
            Dish.PreparationStep(title: "Preparare il pollo", description: "Tagliare il petto di pollo a strisce e cuocerlo in padella con un po' d'olio fino a doratura"),
            Dish.PreparationStep(title: "Preparare la salsa", description: "Mescolare lo yogurt greco con un pizzico di sale, pepe e eventualmente erbe aromatiche"),
            Dish.PreparationStep(title: "Preparare le verdure", description: "Lavare l'insalata e tagliare il pomodoro a fettine"),
            Dish.PreparationStep(title: "Assemblare", description: "Stendere la tortilla, spalmare la salsa, aggiungere pollo e verdure e arrotolare")
        ]
    ),
    
    Dish(
        name: "Zuppa di legumi",
        mealType: .lunch,
        executionTime: .slow,
        ingredients: [
            Dish.Ingredients(name: "Lenticchie", quantity: 80, quantityType: .grams),
            Dish.Ingredients(name: "Carote", quantity: 50, quantityType: .grams),
            Dish.Ingredients(name: "Sedano", quantity: 30, quantityType: .grams),
            Dish.Ingredients(name: "Cipolla", quantity: 50, quantityType: .grams),
            Dish.Ingredients(name: "Brodo vegetale", quantity: 500, quantityType: .grams)
        ],
        description: "Zuppa calda e nutriente con lenticchie e verdure, ideale per un pranzo invernale.",
        nutritionFacts: [
            "Calorie": "250 kcal",
            "Proteine": "15g",
            "Carboidrati": "40g",
            "Grassi": "2g",
            "Fibre": "15g"
        ],
        preparationSteps: [
            Dish.PreparationStep(title: "Preparare le verdure", description: "Tagliare carote, sedano e cipolla a dadini piccoli"),
            Dish.PreparationStep(title: "Soffriggere", description: "In una pentola, far appassire le verdure con un filo d'olio per 5 minuti"),
            Dish.PreparationStep(title: "Aggiungere lenticchie e brodo", description: "Unire le lenticchie sciacquate e il brodo vegetale, portare a ebollizione"),
            Dish.PreparationStep(title: "Cuocere", description: "Abbassare la fiamma e cuocere per 30-40 minuti fino a quando le lenticchie sono tenere")
        ]
    ),
    
    Dish(
        name: "Pasta integrale al pesto",
        mealType: .lunch,
        executionTime: .fast,
        ingredients: [
            Dish.Ingredients(name: "Pasta integrale", quantity: 80, quantityType: .grams),
            Dish.Ingredients(name: "Pesto", quantity: 30, quantityType: .grams),
            Dish.Ingredients(name: "Pomodorini", quantity: 50, quantityType: .grams),
            Dish.Ingredients(name: "Parmigiano", quantity: 10, quantityType: .grams)
        ],
        description: "Pasta integrale condita con pesto fresco, pomodorini e una spolverata di parmigiano.",
        nutritionFacts: [
            "Calorie": "380 kcal",
            "Proteine": "15g",
            "Carboidrati": "60g",
            "Grassi": "12g",
            "Fibre": "8g"
        ],
        preparationSteps: [
            Dish.PreparationStep(title: "Cuocere la pasta", description: "Portare a ebollizione abbondante acqua salata e cuocere la pasta seguendo i tempi indicati sulla confezione"),
            Dish.PreparationStep(title: "Preparare i pomodorini", description: "Lavare e tagliare i pomodorini a metà"),
            Dish.PreparationStep(title: "Condire", description: "Scolare la pasta, condirla con il pesto e mescolare bene"),
            Dish.PreparationStep(title: "Servire", description: "Aggiungere i pomodorini e completare con una spolverata di parmigiano")
        ]
    ),
    
    // Cena
    Dish(
        name: "Salmone al forno",
        mealType: .dinner,
        executionTime: .medium,
        ingredients: [
            Dish.Ingredients(name: "Filetto di salmone", quantity: 150, quantityType: .grams),
            Dish.Ingredients(name: "Limone", quantity: 0.5, quantityType: .number),
            Dish.Ingredients(name: "Aneto", quantity: 5, quantityType: .grams),
            Dish.Ingredients(name: "Olio d'oliva", quantity: 10, quantityType: .grams),
            Dish.Ingredients(name: "Sale", quantity: 2, quantityType: .grams)
        ],
        description: "Filetto di salmone succoso cotto al forno con limone e aneto, ricco di omega-3.",
        nutritionFacts: [
            "Calorie": "300 kcal",
            "Proteine": "30g",
            "Carboidrati": "1g",
            "Grassi": "20g",
            "Omega-3": "3.5g"
        ],
        preparationSteps: [
            Dish.PreparationStep(title: "Preriscaldare il forno", description: "Portare il forno a 180°C"),
            Dish.PreparationStep(title: "Preparare il salmone", description: "Disporre il filetto di salmone su un foglio di carta da forno, condire con sale, olio d'oliva e succo di limone"),
            Dish.PreparationStep(title: "Aggiungere le erbe", description: "Cospargere con aneto fresco tritato"),
            Dish.PreparationStep(title: "Cuocere", description: "Infornare per 15-18 minuti, fino a quando il salmone è opaco e si sfalda facilmente con una forchetta")
        ]
    ),
    
    Dish(
        name: "Tofu saltato con verdure",
        mealType: .dinner,
        executionTime: .medium,
        ingredients: [
            Dish.Ingredients(name: "Tofu", quantity: 150, quantityType: .grams),
            Dish.Ingredients(name: "Broccoli", quantity: 100, quantityType: .grams),
            Dish.Ingredients(name: "Carote", quantity: 50, quantityType: .grams),
            Dish.Ingredients(name: "Salsa di soia", quantity: 15, quantityType: .grams),
            Dish.Ingredients(name: "Zenzero", quantity: 5, quantityType: .grams)
        ],
        description: "Piatto vegano nutriente con tofu croccante e verdure croccanti saltate con zenzero.",
        nutritionFacts: [
            "Calorie": "280 kcal",
            "Proteine": "20g",
            "Carboidrati": "15g",
            "Grassi": "15g",
            "Fibre": "7g"
        ],
        preparationSteps: [
            Dish.PreparationStep(title: "Preparare il tofu", description: "Tagliare il tofu a cubetti di circa 2 cm e tamponarlo con carta assorbente per rimuovere l'umidità in eccesso"),
            Dish.PreparationStep(title: "Preparare le verdure", description: "Tagliare i broccoli a cimette e le carote a julienne o rondelle sottili"),
            Dish.PreparationStep(title: "Saltare il tofu", description: "In una padella con un filo d'olio, far dorare il tofu su tutti i lati per 5-7 minuti"),
            Dish.PreparationStep(title: "Aggiungere le verdure", description: "Unire le verdure e lo zenzero grattugiato, saltare per altri 5 minuti"),
            Dish.PreparationStep(title: "Condire", description: "Aggiungere la salsa di soia, mescolare bene e cuocere per un altro minuto")
        ]
    ),
    
    Dish(
        name: "Frittata alle verdure",
        mealType: .dinner,
        executionTime: .fast,
        ingredients: [
            Dish.Ingredients(name: "Uova", quantity: 3, quantityType: .number),
            Dish.Ingredients(name: "Zucchine", quantity: 80, quantityType: .grams),
            Dish.Ingredients(name: "Cipolla", quantity: 30, quantityType: .grams),
            Dish.Ingredients(name: "Formaggio", quantity: 30, quantityType: .grams)
        ],
        description: "Frittata leggera con verdure fresche e un tocco di formaggio, veloce da preparare.",
        nutritionFacts: [
            "Calorie": "290 kcal",
            "Proteine": "22g",
            "Carboidrati": "6g",
            "Grassi": "20g"
        ],
        preparationSteps: [
            Dish.PreparationStep(title: "Preparare le verdure", description: "Tagliare le zucchine a rondelle sottili e la cipolla a fettine"),
            Dish.PreparationStep(title: "Cuocere le verdure", description: "In una padella antiaderente, far appassire le verdure con un filo d'olio per 5 minuti"),
            Dish.PreparationStep(title: "Preparare le uova", description: "Sbattere le uova in una ciotola con un pizzico di sale e pepe"),
            Dish.PreparationStep(title: "Cuocere la frittata", description: "Versare le uova sopra le verdure, cospargere con il formaggio grattugiato e cuocere a fuoco medio-basso con coperchio per 5-7 minuti"),
            Dish.PreparationStep(title: "Completare la cottura", description: "Quando la parte superiore è quasi cotta, girare la frittata o completare la cottura sotto il grill per 2 minuti")
        ]
    ),
    
    Dish(
        name: "Insalata di farro",
        mealType: .dinner,
        executionTime: .medium,
        ingredients: [
            Dish.Ingredients(name: "Farro", quantity: 70, quantityType: .grams),
            Dish.Ingredients(name: "Pomodorini", quantity: 100, quantityType: .grams),
            Dish.Ingredients(name: "Rucola", quantity: 40, quantityType: .grams),
            Dish.Ingredients(name: "Mozzarella", quantity: 50, quantityType: .grams),
            Dish.Ingredients(name: "Basilico", quantity: 5, quantityType: .grams)
        ],
        description: "Insalata fresca e saporita con farro integrale, pomodorini, rucola e mozzarella.",
        nutritionFacts: [
            "Calorie": "320 kcal",
            "Proteine": "15g",
            "Carboidrati": "50g",
            "Grassi": "8g",
            "Fibre": "6g"
        ],
        preparationSteps: [
            Dish.PreparationStep(title: "Cuocere il farro", description: "Sciacquare il farro e cuocerlo in abbondante acqua salata per circa 25-30 minuti, poi scolare e lasciar raffreddare"),
            Dish.PreparationStep(title: "Preparare gli ingredienti", description: "Tagliare i pomodorini a metà, la mozzarella a cubetti e lavare la rucola"),
            Dish.PreparationStep(title: "Assemblare l'insalata", description: "In una ciotola mescolare il farro con pomodorini, rucola e mozzarella"),
            Dish.PreparationStep(title: "Condire", description: "Aggiungere un filo d'olio d'oliva, sale, pepe e foglie di basilico fresco")
        ]
    ),
    
    Dish(
        name: "Pollo grigliato",
        mealType: .dinner,
        executionTime: .medium,
        ingredients: [
            Dish.Ingredients(name: "Petto di pollo", quantity: 150, quantityType: .grams),
            Dish.Ingredients(name: "Rosmarino", quantity: 5, quantityType: .grams),
            Dish.Ingredients(name: "Aglio", quantity: 5, quantityType: .grams),
            Dish.Ingredients(name: "Olio d'oliva", quantity: 10, quantityType: .grams),
            Dish.Ingredients(name: "Limone", quantity: 0.5, quantityType: .number)
        ],
        description: "Petto di pollo grigliato aromatizzato con erbe fresche, aglio e limone, ricco di proteine.",
        nutritionFacts: [
            "Calorie": "240 kcal",
            "Proteine": "35g",
            "Carboidrati": "2g",
            "Grassi": "10g"
        ],
        preparationSteps: [
            Dish.PreparationStep(title: "Marinare il pollo", description: "In una ciotola, mescolare olio d'oliva, rosmarino tritato, aglio schiacciato e succo di limone. Aggiungere il pollo e lasciarlo marinare per almeno 30 minuti"),
            Dish.PreparationStep(title: "Preriscaldare la griglia", description: "Scaldare bene una griglia o una padella rigata"),
            Dish.PreparationStep(title: "Grigliare", description: "Cuocere il pollo sulla griglia calda per 5-6 minuti per lato, fino a quando è ben cotto ma ancora succoso"),
            Dish.PreparationStep(title: "Riposare", description: "Lasciar riposare il pollo per 5 minuti prima di servire, per mantenere i succhi all'interno")
        ]
    )
]
