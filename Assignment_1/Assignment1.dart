import 'dart:io';

//Function to Print the menu system
void menu() {
  print("This is a menu based assignment");
  print("1.To Get the Fibonacci Series until N numbers!!");
  print("2.Check whether the Number is a semi-prime!!");
  print("3.To check if the sum of the prime elements in an array is prime!!");
  print("4.Enter 4 to quit the program!!");

  print("\n");
}

//function to print the fibonacci series
void fibonacci(int N) {
  int a = 0;
  int b = 1;
  int c;

  stdout.write("${a} ");
  stdout.write("${b} ");

  for (int i = 0; i < N - 2; i++) {
    c = b;
    b = a + b;
    a = c;

    stdout.write("${b} ");
  }

  print("\n");
}

//function to check if the number is a prime
bool isPrime(int N) {
  if (N > 1) {
    for (int i = 2; i < N; i++) {
      if (N % i == 0) {
        return false;
      }
    }
    return true;
  } else {
    return false;
  }
}

//function to find if the number is semiprime or not
bool isSemiPrime(int N) {
  if (isPrime(N) == true) {
    return false;
  } else {
    for (int i = 2; i < N; i++) {
      if (N % i == 0) {
        int j = (N / i).toInt();

        if ((isPrime(i) == true) && (isPrime(j) == true)) {
          return true;
        }
      }
    }
    return false;
  }
}

//function to check for the sum being a prime or not
bool sumIsPrime(List<int> arr, int N) {
  int sum = 0;
  for (int i = 0; i < N; i++) {
    if ((isPrime(arr[i])) == true) {
      sum += arr[i];
    }
  }

  if (isPrime(sum) == true) {
    return true;
  }

  return false;
}

void main() {
  bool running = true;
  int choice;

  while (running) {
    menu();

    stdout.write("Enter the choice: ");
    choice = int.parse(stdin.readLineSync()!);

    //For Choice 1
    if (choice == 1) {
      stdout.write("\nEnter the number N:");
      int N = int.parse(stdin.readLineSync()!);
      fibonacci(N);
    }

    //For Choice 2
    else if (choice == 2) {
      stdout.write("\nEnter the number N:");
      int N = int.parse(stdin.readLineSync()!);
      var check = isSemiPrime(N);

      if (check == true) {
        print("${N} is a semiprime Number!!!");
      } else {
        print("${N} is a not semiprime Number!!!");
      }

      print("\n");
    }

    //For choice 3
    else if (choice == 3) {
      stdout.write("Enter the lenght of the array: ");
      int arrayLenght = int.parse(stdin.readLineSync()!);
      var arr = new List.filled(arrayLenght, 0);

      stdout.write("Now Enter the values for the array!!\n");

      for (int i = 0; i < arrayLenght; i++) {
        stdout.write("At position ${i + 1}: ");
        int entry = int.parse(stdin.readLineSync()!);
        arr[i] = entry;
      }

      var check = sumIsPrime(arr, arrayLenght);

      if (check == true) {
        print("The sum of prime numbers in the array is Prime as well!!");
      } else {
        print("The sum of prime numbers in the array is not Prime!");
      }

      print("\n");
    }

    //For the quit choice
    else if (choice == 4) {
      running = false;
    }
  }
}
