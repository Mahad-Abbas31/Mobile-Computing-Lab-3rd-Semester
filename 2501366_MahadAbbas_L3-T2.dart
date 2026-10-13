/*
Task2:
Consider a class named Animal having typical function named eat that accepts a parameter of type
string. Three classes i.e. Herbivore, Carnivore, and Omnivore have been inherited from Animal
class. All these classes i.e. Herbivore, Carnivore, and Omnivore must have their own (overridden)
eat function. 
a) Draw UML diagram for each class and show inheritance relationship between these classes.

-> Ma'am ye khud bnai hy -- agar handwritten bnana ho to bta dijiye ga 
                 ┌───────────────────┐
                 │      Animal       │
                 ├───────────────────┤
                 │ + eat(food:String)│
                 └─────────┬─────────┘
                           │
          ┌────────────────┼────────────────┐
          │                │                │
          ▼                ▼                ▼
 ┌────────────────┐ ┌────────────────┐ ┌────────────────┐
 │   Herbivore    │ │   Carnivore    │ │    Omnivore    │
 ├────────────────┤ ├────────────────┤ ├────────────────┤
 │ + eat(String)  │ │ + eat(String)  │ │ + eat(String)  │
 └────────────────┘ └────────────────┘ └────────────────┘
*/

//  b) Implement all these classes c) In the main function, create instances of Herbivore,
// Carnivore, and Omnivore classes and invoke eat function with appropriate string parameter to
// display the liking of that animal in eating.

class Animal {
  void eat(String food) {
    print("Animal eats $food.");
  }
}

class Herbivore extends Animal {
  @override
  void eat(String food) {
    print("Herbivore likes eating $food.");
  }
}

class Carnivore extends Animal {
  @override
  void eat(String food) {
    print("Carnivore likes eating $food.");
  }
}

class Omnivore extends Animal {
  @override
  void eat(String food) {
    print("Omnivore likes eating $food.");
  }
}

void main() {
  Herbivore herbivore = Herbivore();
  Carnivore carnivore = Carnivore();
  Omnivore omnivore = Omnivore();

  herbivore.eat("grass");
  carnivore.eat("meat");
  omnivore.eat("both plants and meat");
}