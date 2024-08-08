# newdemo.py

def greet_user(name):
    """Function to greet the user"""
    return f"Hello, {name}!"

def add_numbers(a, b):
    """Function to add two numbers"""
    return a + b

def main():
    # Greet the user
    user_name = input("Enter your name: ")
    greeting = greet_user(user_name)
    print(greeting)

    # Add two numbers
    try:
        num1 = float(input("Enter the first number: "))
        num2 = float(input("Enter the second number: "))
        result = add_numbers(num1, num2)
        print(f"The sum of {num1} and {num2} is {result}")
    except ValueError:
        print("Invalid input. Please enter numeric values.")

if __name__ == "__main__":
    main()
