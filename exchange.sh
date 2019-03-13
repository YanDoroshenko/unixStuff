#!/bin/bash
amount=$1
from=$2
to=$3
rate=$(curl -s https://ratesapi.io/api/latest?base=$from | json_pp | egrep -io "$to.*[0-9]+\.[0-9]+" | egrep -o "[0-9]+\.[0-9]+")
bc <<< "$amount * $rate"
