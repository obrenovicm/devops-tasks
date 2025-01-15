#!/bin/bash

# script that generates report file with system information

display_date() {
	echo "$(date)"
}

display_user() {
	echo "$(whoami)"
}

display_internal() {
	echo "$(ipconfig getifaddr en0)"	
}

display_external() {
	echo "$(curl ifconfig.me --silent)"
}

display_distro() {
	echo "$(uname -mrs)"
}

display_uptime() {
	echo "$(uptime)"
}

display_disk() {
	echo "Total space : $(df -h | sed -n 2p | awk '{print $2}')"
	echo "Used space : $(df -h | sed -n 2p | awk '{print $3}')"
}

display_ram() {
	memsize=$(sysctl -n hw.memsize)
	ramsize=$(( $memsize / $(( 1024**3 ))))
	echo "RAM: $ramsize GB"
}

display_cpu() {
	full=$(sysctl -a machdep.cpu)
	brand=$(echo "$full" | grep brand_string | cut -d ":" -f 2)
	cores=$(echo "$full" | grep core_count | cut -d ":" -f 2)
	threads=$(echo "$full" | grep thread_count | cut -d ":" -f 2)
	echo "CPU : $brand"
	echo -e "Cores : $cores \t Threads: "$threads""
}

display_date
display_user
display_internal
display_external
display_distro
display_uptime
display_disk
display_ram
display_cpu
