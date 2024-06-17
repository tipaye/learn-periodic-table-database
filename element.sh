#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

LOOKUP() {
  #AN=0
  #AM=0
  #MP=0
  #BP=0
  #SY=0
  #NA=0
  #TY=0
  #ID=0

  case $1 in
    1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10)
      AN=$1
      NA=$($PSQL "SELECT name FROM elements WHERE atomic_number=$AN")
      SY=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$AN")
      AM=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$AN")
      MP=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$AN")
      BP=$($PSQL "SELECT boiling_point_celsius  FROM properties WHERE atomic_number=$AN")
      ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$AN")
      TY=$($PSQL "SELECT type FROM types WHERE type_id=$ID")
      echo "The element with atomic number $AN is $NA ($SY). It's a $TY, with a mass of $AM amu. $NA has a melting point of $MP celsius and a boiling point of $BP celsius."
      ;;

    H | He | Li | Be | B | C | N | O | F | Ne)
      SY=$1
      AN=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$SY'")
      NA=$($PSQL "SELECT name FROM elements WHERE atomic_number=$AN")
      AM=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$AN")
      MP=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$AN")
      BP=$($PSQL "SELECT boiling_point_celsius  FROM properties WHERE atomic_number=$AN")
      ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$AN")
      TY=$($PSQL "SELECT type FROM types WHERE type_id=$ID")
      echo "The element with atomic number $AN is $NA ($SY). It's a $TY, with a mass of $AM amu. $NA has a melting point of $MP celsius and a boiling point of $BP celsius."
      ;;

    Hydrogen | Helium | Lithium | Beryllium | Boron | Carbon | Nitrogen | Oxygen | Fluorine | Neon)
      NA=$1
      AN=$($PSQL "SELECT atomic_number FROM elements WHERE name='$NA'")
      SY=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$AN")
      AM=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$AN")
      MP=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$AN")
      BP=$($PSQL "SELECT boiling_point_celsius  FROM properties WHERE atomic_number=$AN")
      ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$AN")
      TY=$($PSQL "SELECT type FROM types WHERE type_id=$ID")
      echo "The element with atomic number $AN is $NA ($SY). It's a $TY, with a mass of $AM amu. $NA has a melting point of $MP celsius and a boiling point of $BP celsius."
      ;;

    *)
      echo -e "I could not find that element in the database."
      exit 0
      ;;
  esac
}

if [[ $# -eq 0 ]] 
then
  echo -e 'Please provide an element as an argument.'  
  exit 0
fi

LOOKUP $1
exit 0