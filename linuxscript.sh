#!/bin/bash

while true; do
    echo "Menu:"
    echo "1. Read text from file"
    echo "2. Type message"
    echo "3. Quit"
    read -p "Choose an option: " option

    case $option in
        1)
            read -p "Enter the filename to read from: " filename
            if [ ! -f "$filename" ]; then
                echo "File not found!"
                continue
            fi
            text=$(cat "$filename")
            ;;

        2)
            read -p "Enter your message: " text
            ;;

        3)
            echo "Exiting program..."
            exit 0
            ;;

        *)
            echo "Invalid option!"
            continue
            ;;
    esac

    read -p "Choose the encryption method (ROT13 (R) or Caesar's Cipher (CC) ): " method
    case $method in
        "R")
            encrypted_text=$(echo "$text" | tr "[A-Za-z]" "[N-ZA-Mn-za-m]")
            ;;

        "CC")
            read -p "Enter the number of shifts: " shifts
            encrypted_text=$(echo "$text" | tr "[A-Za-z]" "[$(printf %s {A..Z} | cut -c $((shifts + 1))-26)$(printf %s {a..z} | cut -c $((shifts + 1))-26)]")
            ;;

        *)
            echo "Invalid encryption method!"
            continue
            ;;
    esac

    read -p "Encrypt (E) or Decrypt (D)? " operation
    case $operation in
        "E")
            echo "Result:"
            echo "$encrypted_text"
            read -p "Enter the output filename: " output_file
            echo "$encrypted_text" > "$output_file"
            ;;

        "D")
            if [ "$method" == "R" ]; then
                decrypted_text=$(echo "$text" | tr "[A-Za-z]" "[N-ZA-Mn-za-m]")
            elif [ "$method" == "CC" ]; then
                decrypted_text=$(echo "$text" | tr "[$(printf %s {A..Z} | cut -c $((26 - shifts + 1))-26)$(printf %s {a..z} | cut -c $((26 - shifts + 1))-26)]" "[A-Za-z]")
            fi
            echo "Result:"
            echo "$decrypted_text"
            read -p "Enter the output filename: " output_file
            echo "$decrypted_text" > "$output_file"
            ;;
        *)
            echo "Invalid operation!"
            continue
            ;;
    esac
done

