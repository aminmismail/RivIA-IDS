#!/bin/bash

interface=$1
output_dir=$2
user=$3
rotate_interval=60

[[ "$(grep -c "$interface" /proc/net/dev)" == "0" ]] && echo "A interface nao foi encontrada!" && exit 255
[[ ! -d "$output_dir" ]] && echo "O diretorio de saida nao existe!" && exit 255

# Clean
cleanup() {
	echo "=== Captura esta sendo cancelada ==="
        echo "=== Aguarde 3 segundos ..."
	sleep 3
	echo 
	echo "=== Convertendo arquivos PCAP restantes se houver"
	OIFS="$IFS"
	IFS=$'\n'
	for f in `find "${output_dir}" -type f -name "*.pcap"`; do
		echo "=== $f is left"
		"${post_rotate_command}" "$f"
	done
	IFS="$OIFS"

        echo "=== Limpando alguns arquivos"
        rm -f "$output_dir"/*.pcap
        rm -f csv/*.csv

	echo 
    exit 0
}

trap 'cleanup' INT TERM EXIT

output_file_format=${output_dir}/'%d-%m-%Y_%H:%M:%S.pcap'
options="-n -nn -N -s 0"

[[ ! -z "${user}" ]] && options="${options} -Z ${user}"  #$(id -nu 1000)

# Before the post-rotatation script can be run, please edit an AppArmor configuration file:
#   $ sudo vi /etc/apparmor.d/usr.sbin.tcpdump
# by adding the line:
#   /**/* ixr,
# then
#   $ sudo service apparmor restart
#
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"  # On the same directory.
post_rotate_command="${script_dir}"/convert_pcap_csv_v2.sh

sudo tcpdump ${options} -z "${post_rotate_command}" -i ${interface} -G ${rotate_interval} -w "${output_file_format}"

#sudo chown 1000:1000 "${output_dir}"/*

