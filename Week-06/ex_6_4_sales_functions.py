# Prat 1 Add the sales data

employees = ['John', 'Sarah', 'Michael', 'Jennifer', 'David']
sales = [5200, 6800, 4500, 7200, 5800]

# Task 1
def calculate_total(sales):
    total = 0
    for amount in sales:
        total += amount
    return total

total = calculate_total(sales)
print(f"Total Monthly Sales: ${total:,.2f}")

# Task_2
def calculate_average(total, number_of_employees):
    average = total / number_of_employees
    return average

average = calculate_average(total, len(employees))
print(f"Average Sales per Employee: ${average:,.2f}")

# Task_3
def evaluate_performance(amount):
    if amount >= 7000:
        return "Excellent"
    elif amount >= 6000:
        return "Good"
    elif amount >= 5000:
        return "Average"
    else:
        return "Needs Improvement"

print("EMPLOYEE SALES PERFORMANCE")
print("--------------------------")

for name, amount in zip(employees, sales):
    performance = evaluate_performance(amount)
    print(f"{name}: ${amount:,.2f} - {performance}")

    # Task_4+
    def find_highest_sales(sales):
        highest = sales[0]
        for amount in sales:
            if amount > highest:
             highest = amount
        return highest

    highest_sales = find_highest_sales(sales)
    print(f"Highest Sales Amount: ${highest_sales:,.2f}")

    # Task_5
# challege one
    def calculate_commission(amount):
        if amount >= 7000:
         rate = 0.10
        else:
         rate = 0.05
        commission = amount * rate
        return commission
    commission = calculate_commission(5200)
    print(f"John's Commission: ${commission:,.2f}")

    # Task_6
    print("\nEMPLOYEE SALESSUMMARY")
    print("_" * 60)
    print(f"{'Employee':<12}{'sales':<12}{'Performance':<20}{'Commission'}")
    print("_" * 60)

    for name, amount in zip(employees, sales):
        performance = evaluate_performance(amount)
        commission = calculate_commission(amount)
        sales_text = f"${amount:,.2f}"
        commission_text = f"${commission:,.2f}"
        print(f"{name:<12}{sales_text:<12}{performance:<20}{commission_text}")

    # Challenge 2: Count employees above average
    def above_average(sales, average):
        count = 0
        for amount in sales:
            if amount > average:
                count += 1
        return count
    number_above_average = above_average(sales, average)
    print(f"Employees Above Average: {number_above_average}")

    # Challenga 3: Calculate annual sales
    def calculate_annual_sales(monthly_sales):
        annual_sales = monthly_sales * 12
        return annual_sales
    for name, amount in zip(employees, sales):
        annual_sales = calculate_annual_sales(amount)
        print(f"{name}: ${annual_sales:,.2f}")
            

        # Task_6

        # 1) What is a user-defined function in python?
        # A user_defined function in python is a reusable block of code that a programmer creates to perform a 
        # specific task. For example I wrote calculate_commission() to colculate an employee's 
        # commission from their sales amount and commission rate.
        # 2) What is the difference between a parameter and an argument?
        #  A parameter is a variable named in the function definition, while an argument is the value passed when the function is called.
        # In my program, amount and rate are parameters, and 5200 and 0.05 are aruments in calculate_commission(5200, 0.05).
        # 3) What is the purpose of the return statement?
        # The purpose of return is to send the result back to the code that called the function.
        # 4)  What is the difference between print() and return?
        # Return sends a function's result black so the programer can use it.print() display a value on the screen.
        # 5) Why is it beneficial to divide a large program into smaller functions?
        # Smaller functions maks a program easier to understand and fix. Each function handles one task, such as adding sales or calculating commission.
        # 6)   In the code below, identify the function name, the parameters, and the arguments.
# def calculate_commission(amount, rate):
# return amount * rate
# commission = calculate_commission(5200, 0.05)
# The function name is calculate_commission. The arguments are 5200 and 0.05, because those values are passed when function is called.
# My biggest challenge was undestand the difference between parameters and arguments.
# I also had to learn that return guves a result back to the program, while  print() displays it.
# Using my commission function helped me see how these ideas work in my own code.
