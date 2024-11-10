#!/bin/bash

echo -n '[..................................................] 0%'

passo='#####'

for i in 10 20 30 40 50 60 70 80 90 100;do
sleep 1
pos=$((i/2-5))
echo -ne '\033[G'
echo -ne "\033[${pos}C"
echo -n "$passo"
echo -ne '\033[53G'
echo -n "$i"
done
echo
