# Title: Start Tydbase Project
# Description: This script is used to start the existing tydbase project
# Author: Moeen Mahmud, Team Wildtunes

# How to execute the script?
# 1. Open terminal
# 
# 2. Locate the script file and move to HOME directory or any other directory of your choice
# `sudo mv start-tydbase.sh ~/scripts/start-tydbase.sh`
# 
# 3. Run the following command to make the script executable
# `sudo chmod +x ~/scripts/start-tydbase.sh`
# 
# 4. Add PATH to the script on .bashrc or .zshrc file
# `export PATH=$PATH:~/scripts/`
# 
# 5. Reload the .bashrc or .zshrc file
# `source ~/.bashrc` or `source ~/.zshrc`
# 
# 6. Run the script
# `start-tydbase.sh`


#!/bin/bash
# Function to check command availability
check_command() {
    command -v "$1" >/dev/null 2>&1 || { echo >&2 "$1 is not installed. Aborting."; exit 1; }
}

# Check if necessary commands are available
check_command code
check_command npm
check_command gnome-terminal


# user work choice function
user_work_choice() {
    echo "1. Open VSCode and start the server"
    echo "2. Start the server"
    echo "3. Open VSCode"
    echo "4. None"
}

# Check if the project directory is saved
if [ -f "project-directory.txt" ]; then
    echo "Do you want to use the saved project directory? (yes/no)"
    read -r use_saved_project_directory

    if [ "$use_saved_project_directory" = "yes" ]; then
        _project_directory=$(cat "project-directory.txt" | tr -d '\r')  # Remove any extra characters
    else
        echo "Please provide the location of the project directory"
        read -r _project_directory
        echo "$_project_directory" > project-directory.txt
    fi
else
    echo "Please provide the location of the project directory"
    read -r _project_directory
    echo "$_project_directory" > project-directory.txt
fi

# Check if the project directory exists
if [ ! -d "$_project_directory" ]; then
    echo "Directory $_project_directory not found. Aborting."
    exit 1
fi

# Print the project directory
echo "You're on $_project_directory"

# Function to navigate and print the current directory
navigate_and_print() {
    cd "$1" || { echo >&2 "Directory $1 not found. Aborting."; exit 1; }
    echo "Navigating to $1..."
    echo "$(pwd)"
}

# Function to handle frontend tasks
frontend() {
    # title
    echo "******** FRONTEND ********"
    for i in {1..3}
    do
        echo ">"
    done

    navigate_and_print "$_project_directory/tydbase-frontend"

    echo "Choose frontend work options -> 1 / 2 / 3 / 4"
    user_work_choice

    read input

    case $input in
        1)
            echo "Opening VSCode..."
            code "$_project_directory/tydbase-frontend"

            echo "Starting the frontend server in a new window..."
            gnome-terminal -- bash -c "cd $_project_directory/tydbase-frontend && npm run dev"
            ;;
        2)
            echo "Starting the frontend server in a new window..."
            gnome-terminal -- bash -c "cd $_project_directory/tydbase-frontend && npm run dev"
            ;;
        3)
            echo "Opening VSCode..."
            code "$_project_directory/tydbase-frontend"
            ;;
        4)
            echo "It's okay not to work on the frontend today!"
            ;;
        *)
            echo "Invalid frontend work choice. Please try again."
            ;;
    esac

    # play completion sound
    tput bel
}

# Function to handle backend tasks
backend() {
    # title
    echo "******** BACKEND ********"
    for i in {1..3}
    do
        echo ">"
    done

    navigate_and_print "$_project_directory/tydbase-backend"

    echo "Choose backend work options -> 1 / 2 / 3 / 4"
    user_work_choice

    read input

    case $input in
        1)
            echo "Opening VSCode..."
            code "$_project_directory/tydbase-backend"

            echo "Starting the backend server in a new window..."
            gnome-terminal -- bash -c "cd $_project_directory/tydbase-backend && npm run start:dev"
            ;;
        2)
            echo "Starting the backend server in a new window..."
            gnome-terminal -- bash -c "cd $_project_directory/tydbase-backend && npm run start:dev"
            ;;
        3)
            echo "Opening VSCode..."
            code "$_project_directory/tydbase-backend"
            ;;
        4)
            echo "It's okay not to work on the backend today!"
            ;;
        *)
            echo "Invalid backend work choice. Please try again."
            ;;
    esac

    # play completion sound
    tput bel
}

end_message() {
    echo "You're all set! Happy coding!!"
    exit 1
}

echo "In which end do you want to work? (frontend/backend/both)"
read choice

case $choice in
    frontend)
        echo "Starting the frontend project..."
        frontend
        end_message
        ;;
    backend)
        echo "Starting the backend project..."
        backend
        end_message
        ;;
    both)
        echo "Great choice!"
        frontend
        backend
        end_message
        ;;
    *)
        echo "Invalid work choice. Please try again."
        ;;
esac



