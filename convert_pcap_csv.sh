#!/bin/bash

pcap_file="$1"
[[ ! -f "${pcap_file}" ]] && echo "Arquivo PCAP \"${pcap_file}\" nao existe!" && exit 255

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"  # On the same directory.
echo ">>> Script dir: ${script_dir}"

output_dir="${script_dir}"/csv

pcap_dir="${script_dir}"/pcap

max_files=60

# Lista todos os arquivos pcap na pasta e conta quantos existem
file_count=$(ls -1 "$pcap_dir" | grep -c ".*\.pcap$")

echo "Quantidade de arquivos PCAP no diretorio [pcap]: ${file_count}"

# Se o número de arquivos for maior que o máximo, exclui o mais antigo
if [ $file_count -gt $max_files ]; then
        oldest_file=$(ls -1t "$pcap_dir" | grep ".*\.pcap$" | tail -1)
        rm -f "$pcap_dir/$oldest_file"
fi

## Clean
cancel() {
	echo "+++ Conversao esta sendo cancelada +++"
	echo "+++ A ultima conversao, ${pcap_file}, esta incompleta!"
	echo
	exit 0
}
trap 'cancel' INT TERM

cleanup() {
#    echo "+++ Remove ${pcap_file}"
#    rm -f "${pcap_file}"

	echo "+++ Conversao finalizada"
	echo
    exit 0
}
trap 'cleanup' EXIT

## Convert
echo "+++ Conversor CICFlowMeter 4.0 PCAP-to-CSV +++"
echo "    Arquivo de entrada: ${pcap_file}"
echo "    Diretorio de saida: ${output_dir}"

# CICFlowMeter-3.0/bin/CICFlowMeter
#cic="${script_dir}"/CICFlowMeters/CICFlowMeter-3.0/bin/CICFlowMeter
cic="${script_dir}"/CICFlowMeters/CICFlowMeter-4.0/bin/CICFlowMeter

"${cic}" "${pcap_file}" "${output_dir}"
base_pcap="${pcap_file%.*}"
base_pcap="${base_pcap##*/}"
arq="${output_dir}/${base_pcap}_ISCX.csv"

python3 Analisador.py $arq

echo "+++ Removendo arquivos restantes"

