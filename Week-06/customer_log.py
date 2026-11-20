import os
LOG_FILE = "interactions.txt"

if not os.path.exists(LOG_FILE):

    with open(LOG_FILE, "w") as file:
        file.write("=== Customer Interaction log ===\n")
        file.write("Date      | Customer      |Issue       |Rep\n")

        print("Log create:", LOG_FILE)

        SAMPLE = [
            ("2025-05-01", "Alice Nguyen", "Billing query", "J. Park"),
            ("2025-05-01", "Bob Carter", "Login issue", "s. Diaz"),
            ("2025-05-01", "Carol Singh", "Refund request", "J. Park"),
            ("2025-05-01", "Alice Nguyen", "Follow-up", "M. lee"),

        ]

        def append_records(entries):
            records = [
                f"{date} | {customer:<15} | {issue:<15} | {rep}\n"
                for date, customer, issue, rep in entries
            ]
            with open(LOG_FILE, "a") as file:
                file.writelines(records)
                print(f"{len(records)} record(s) appended.")

        def display_log():
            try:
                with open(LOG_FILE, "r") as file:
                    content = file.read()
                    print(content)
            except FileNotFoundError:
                print("Log not found. Run the program first.")

        def search_customer(name):
            try:     
                    with open(LOG_FILE, "r") as file:
                        lines = file.readlines()
                        matches = [line for line in lines if name.lower() in line.lower()]
                    if matches:
                        print(f'Found {len(matches)} record(s) for "{name}":')
                        print("".join(matches))
                    else:
                        print('No records found for "{name}".')
            except FileNotFoundError:
                print("Lon not found.")
                
        def update_entry_count():
             try:
               with open(LOG_FILE, "r+") as file:
                lines = file.readlines()
                count = sum(1 for line in lines[2:] if line.strip())
                lines[0] = f"=== Customer Interaction Log | Entries: {count} ===\n"
                file.seek(0)
                file.writelines(lines)
                file.truncate()
               print(f'Header updated. Total entries: {count}')
             except FileNotFoundError:
                 print("Log not found. Run program first.") 
        def show_header():
            try:
                with open(LOG_FILE, "r") as file:
                    header = file.readline()
                    print("Header:", header.strip())
            except FileNotFoundError:
                print("Log not found.") 

        def create_log():
                 with open(LOG_FILE, "W") as file:
                    file.write("===Customer Interaction log ===\n")
                    file.write("Date    |Customer      | Issue           |Rep\n")
                    print(f"log create: {LOG_FILE}")

        def main():
            while True:
                    print("\n=== Customer Log Manager ===")
                    print("1 Create / reset log")
                    print("2 Append sample records")
                    print("3 Display full log")
                    print("4 Search by customer name")
                    print("5 Update entry count in header")
                    print("6 Show header line only")
                    print("0 Quit")

                    choice = input("Choose: ").strip()
                    if choice == "1":
                        create_log()
                    elif choice == "2":
                        append_records(SAMPLE)
                    elif choice == "3": 
                        display_log()
                    elif choice == "4":
                          name = input('Customer name to search: ')
                          search_customer(name)
                    elif choice == "5":
                        update_entry_count()
                    elif choice == "6": 
                        show_header()
                    elif choice == "0":
                          break
                    else:
                        print("Invalid choice.")

        if not os.path.exists(LOG_FILE):
            create_log()
                    
        if __name__ == "__main__":
                main()


    
















