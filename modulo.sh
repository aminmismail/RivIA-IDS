#!/bin/bash

echo "_________________________________________"
echo "| Modulo de deteccao de ameacas         |"
echo "-----------------------------------------" 
echo "| Selecione uma opcao abaixo:           |"
echo "|                                       |"
echo "| [1] - Capturar via interface de rede  |"
echo "| [2] - Analisar arquivo PCAP           |"
echo "-----------------------------------------"
echo
echo -n ">"
read opt

if [[ $opt -eq 1 ]]; then
  echo ">Digite a interface"
   read interface
   ./capture_interface_pcap.sh $interface pcap $(id -nu 1000)
elif [[ $opt -eq 2 ]]; then
   echo ">Digite o nome do arquivo PCAP"
   read pcap_file
   ./convert_pcap_csv.sh $pcap_file
else
  echo "Opcao invalida! Tente novamente."
fi
