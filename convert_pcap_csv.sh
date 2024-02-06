#!/bin/bash

pcap_file="$1"
[[ ! -f "${pcap_file}" ]] && echo "Arquivo PCAP \"${pcap_file}\" nao existe!" && exit 255

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"  # On the same directory.
echo ">>> Script dir: ${script_dir}"

output_dir="${script_dir}"/csv


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

