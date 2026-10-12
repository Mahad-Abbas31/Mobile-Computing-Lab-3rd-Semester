class Vehicle {
  void drive(int speed) {
    print("Vehicle is driving at $speed km/h.");
  }
}

class Car extends Vehicle {
  @override
  void drive(int speed) {
    print("Car is driving smoothly at $speed km/h.");
  }
}

class Bike extends Vehicle {
  @override
  void drive(int speed) {
    print("Bike is driving quickly at $speed km/h.");
  }
}

void main() {
  Vehicle car = Car();
  Vehicle bike = Bike();

  car.drive(80);
  bike.drive(60);
}