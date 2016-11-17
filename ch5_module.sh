#!/bin/bash

answer=""
answer_correct=false
show_exercise=true
current_exercise=0
num_exercises=6
exercises=()
answers=()
outputs=()

# The data follows a format of question, answer, output, 
# delimited by hashes.
load_exercises() {
    delimiter="#"
    i=0
    index=0

    while read -r line; do
        if [ "$line" == "$delimiter" ]; then
            i=$(($i+1))
        else
            if [ $(($i % 3)) == 0 ]; then
                exercises[$index]+="$line"
            elif [ $(($i % 3)) == 1 ]; then
                answers[$index]+="$line"
            else
                outputs[$index]+="$line"
                index=$(($index+1))
            fi
        fi
    done < "ch5_exercises.txt"
}

read_answer() {
    answer=""

    while read line
    do
        if [ -z "$line" ]; then
            return;
        else
            answer+="$line"
        fi
    done
}

display_output() {
        echo -e "${outputs[$current_exercise]}"
}

verify_answer() {
    if [ "$answer" == "quit" ]; then
        return
    elif [ "$answer" == "skip" ]; then
        answer_correct=true
        show_exercise=true
    elif [ "$answer" == "${answers[$current_exercise]}" ]; then
        display_output
        echo -e "\nWell done!"
        answer_correct=true
        show_exercise=true;
        prompt_to_continue
    else
        echo -e "Please try again.\n"
        show_exercise=false
    fi
}

load_next_exercise() {
    if [ "$answer_correct" == "true" ]; then
        current_exercise=$(($current_exercise+1))
        answer_correct=false
    fi
}

display_instructions() {
    echo -e "\n\n\tChapter 5 - Conditionals\n"
    echo -e "This chapter introduces conditional statements, which" \
         "\nallow you to control program flow." \
         "\n\nTo finish an answer, output an empty line by pressing enter twice." \
         "\nAnswer 'skip' to go to the next exercise" \
         "\nAnswer 'quit' to return back to the main menu.\n"

    prompt_to_continue
}

display_exercise() {
    if [ "$show_exercise" == "true" ]; then
        echo -e "${exercises[$current_exercise]}"
    fi
}

main() {
    load_exercises
    display_instructions

    while [[ "$answer" != "quit" && $current_exercise -lt $num_exercises ]]; do
        display_exercise
        read_answer
        verify_answer
        load_next_exercise
    done

    echo -e "\nThanks for using the conditionals tutorial!"
    prompt_to_continue
}
