#!/bin/bash

# Tic Tac Toe implementation in bash
# Author: Dariusz Rzepka <rzepkadarek@gmail.com>
# TODO:
# * check if input position is correct


BOARD=(" " " " " " " " " " " " " " " " " ")


PLAYER="X"
WIN="0"
INPUT=

function print_cell {
  echo "$([ "$1" == " " ] && echo "$2" || echo "$1")"
}

function print_board {
  echo ""
  echo " $(print_cell "${BOARD[0]}" 1) | $(print_cell "${BOARD[1]}" 2) | $(print_cell "${BOARD[2]}" 3)"
  echo "-----------"
  echo " $(print_cell "${BOARD[3]}" 4) | $(print_cell "${BOARD[4]}" 5) | $(print_cell "${BOARD[5]}" 6)"
  echo "-----------"
  echo " $(print_cell "${BOARD[6]}" 7) | $(print_cell "${BOARD[7]}" 8) | $(print_cell "${BOARD[8]}" 9)"
  echo ""
}

function ask_next_position {
    read -p "Select next position for \"${PLAYER}\"? " INPUT
}


function read_next_position {
  IS_NEXT_POSITION_CORRECT="0"
  while [ "${IS_NEXT_POSITION_CORRECT}" -eq "0" ]
  do
    ask_next_position
    # TODO: check if position is correct
    IS_NEXT_POSITION_CORRECT="1"
    BOARD[$INPUT - 1]="${PLAYER}"
  done
}

function check_the_same {
  if [[ "${BOARD[$1]}" != " " ]] && [[ "${BOARD[$1]}" == "${BOARD[$2]}" ]] && [[ "${BOARD[$1]}" == "${BOARD[$3]}" ]]
  then
    WIN="1"
  fi
}


# TODO: try find solution with iterating
WIN_OPTIONS=("0,1,2" "3,4,5" "6,7,8" "0,3,6" "1,4,7" "2,5,8" "0,4,8" "2,4,6")

function check_win {
  # rows
  check_the_same 0 1 2
  check_the_same 3 4 5
  check_the_same 6 7 8
  # columns
  check_the_same 0 3 6
  check_the_same 1 4 7
  check_the_same 2 5 8
  # diagonals
  check_the_same 0 4 8
  check_the_same 2 4 6
}

function switch_player {
  if [[ "${PLAYER}" == "X" ]]
    then
      PLAYER="O"
    else
      PLAYER="X"
    fi
}


# the main loop
while [ "${WIN}" -eq "0" ]
do
  switch_player
  clear
  print_board
  read_next_position
  check_win
done

# The end!
clear
print_board
echo "${PLAYER} win!"
