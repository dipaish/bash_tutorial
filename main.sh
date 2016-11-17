#!/bin/bash

running=true
module=
module_entry_point=

main() {
    while [ $running == true ]; do
        clear_screen
        display_menu
        read_input
        parse_input
        load_module
        reset_input
    done

    quit_bash_tutorial
}

clear_screen() {
    clear
}

prompt_to_continue() {
    read -p "(press enter to continue)" prompt_to_continue_value
}

display_menu() {
    echo -e "\n\n\t--- BASH TUTORIAL ---\n"
    echo "1 - Introduction to Linux & Shell Scripting"
    echo "2 - Pipes & filters"
    echo "3 - Variables"
    echo "4 - Arithmetic operations"
    echo "5 - Conditionals"
    echo "6 - Loops"
    echo "7 - Functions"
    echo -e "8 - Quit\n"
}

read_input() {
    read -p ": " input
}

parse_input() {
    case $input in
        1)
            module=
            module_entry_point=
            ;;
        2)
            module=
            module_entry_point=
            ;;
        3)
            module=
            module_entry_point=
            ;;
        4)
            module=
            module_entry_point=
            ;;
        5)
            module=ch5_module.sh
            module_entry_point=main
            ;;
        6)
            module=
            module_entry_point=
            ;;
        7)
            module=
            module_entry_point=
            ;;
        8)
            running=false
            ;;
        *)
            echo -e "\nInvalid input, please try again."
            prompt_to_continue
            ;;
    esac
}

load_module() {
    if [[ "$module" == "" || "$module_entry_point" == "" ]]; then
        return;
    fi

    clear_screen
    source $module
    $module_entry_point
}

reset_input() {
    module=
    module_entry_point=
}

quit_bash_tutorial() {
    echo -e "\nGoodbye!"
}

main "$@"
