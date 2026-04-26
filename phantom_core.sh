#!/bin/bash

# ==============================================================================
# NAME    : PHANTOM DINICAL - ULTIMATE CYBER (PRO UI)
# VERSION : 10.0.0 | FULL VISUAL OVERHAUL | ORIGINAL ENGINE
# ==============================================================================

# --- [ COLORS & THEMES - CYBERPUNK MODE ] ---
R='\033[1;31m'; G='\033[1;32m'; Y='\033[1;33m'; B='\033[1;34m'
P='\033[1;35m'; C='\033[1;36m'; W='\033[1;37m'; LG='\033[0;37m'
DG='\033[1;30m'; NC='\033[0m'
# Blink effect simulation via color codes
BLINK='\033[5m'

# --- [ ORIGINAL_ENGINE ] ---
_req() {
    local cmd_name=$1
    local pkg_name=$2
    if ! command -v "$cmd_name" >/dev/null 2>&1; then
        echo -e "${R}[!] Module requires '$cmd_name' but not found!${NC}"
        echo -e "${C}[*] Phantom Auto-Downloader Active... Please wait.${NC}"
        sleep 1
        if command -v pkg >/dev/null 2>&1; then
            pkg install "$pkg_name" -y
        elif command -v apt >/dev/null 2>&1; then
            apt update -y >/dev/null 2>&1
            apt install "$pkg_name" -y
        else
            echo -e "${R}[!] Package manager not found. Cannot auto-install.${NC}"
            return 1
        fi
        echo -e "${G}[+] Download Complete! Launching Module...${NC}"
        sleep 1
    fi
}

_execute() {
    echo -e "\n${C}[»] EXECUTING MODULE $1...${NC}"
    case $1 in
        1|01) echo -ne "${W}Domain/IP: ${NC}"; read t; ping -c 4 "$t" ;;
        2|02) _req traceroute traceroute; echo -ne "${W}Domain/IP: ${NC}"; read t; traceroute "$t" ;;
        3|03) _req whois whois; echo -ne "${W}Domain: ${NC}"; read d; whois "$d" ;;
        4|04) _req dig dnsutils; echo -ne "${W}Domain: ${NC}"; read d; dig +short A "$d" ;;
        5|05) _req dig dnsutils; echo -ne "${W}Domain: ${NC}"; read d; dig +short MX "$d" ;;
        6|06) _req curl curl; echo -e "${W}Public IP:${NC}"; curl -s ifconfig.me; echo "" ;;
        7|07) _req ifconfig net-tools; ifconfig || ip a ;;
        8|08) _req curl curl; echo -ne "${W}Target IP: ${NC}"; read ip; curl -s "http://ip-api.com/line/$ip" ;;
        9|09) _req curl curl; echo -ne "${W}URL: ${NC}"; read u; curl -I -s "$u" ;;
        10) _req curl curl; echo -ne "${W}URL: ${NC}"; read u; curl -s "$u" | head -n 20 ;;
        
        11) _req nmap nmap; nmap -sV localhost ;;
        12) _req nmap nmap; echo -ne "${W}Target IP: ${NC}"; read t; nmap -sS -T4 -F "$t" ;;
        13) _req netstat net-tools; netstat -antp 2>/dev/null || ss -antp ;;
        14) _req netstat net-tools; netstat -tulpn 2>/dev/null || ss -tulpn ;;
        15) _req openssl openssl; echo -ne "${W}Domain: ${NC}"; read d; echo | openssl s_client -servername "$d" -connect "$d":443 2>/dev/null | openssl x509 -noout -dates ;;
        16) echo -e "${G}Scanning...${NC}"; find / -perm -4000 -type f 2>/dev/null | head -n 10 ;;
        17) tail -n 10 /var/log/auth.log 2>/dev/null || echo -e "${R}Require Root/Log not found.${NC}" ;;
        18) w || who ;;
        19) systemctl status sshd 2>/dev/null || service ssh status 2>/dev/null || echo "Check SSH manually." ;;
        20) _req openssl openssl; echo -e "${W}Pass:${NC}"; openssl rand -base64 16 ;;

        21) echo -ne "${W}Text: ${NC}"; read t; echo -n "$t" | base64 ;;
        22) echo -ne "${W}Base64: ${NC}"; read b; echo -n "$b" | base64 -d; echo "" ;;
        23) echo -ne "${W}Text: ${NC}"; read t; echo -n "$t" | md5sum ;;
        24) echo -ne "${W}Text: ${NC}"; read t; echo -n "$t" | sha1sum ;;
        25) echo -ne "${W}Text: ${NC}"; read t; echo -n "$t" | sha256sum ;;
        26) echo -ne "${W}Text: ${NC}"; read t; echo -n "$t" | sha512sum ;;
        27) _req curl curl; echo -ne "${W}Text: ${NC}"; read t; curl -s -G --data-urlencode "q=$t" "http://localhost" >/dev/null 2>&1; echo "URL Encoded." ;;
        28) echo -ne "${W}File: ${NC}"; read f; hexdump -C "$f" | head -n 10 ;;
        29) _req openssl openssl; openssl genrsa -out key.pem 2048; echo -e "${G}key.pem Saved.${NC}" ;;
        30) _req file file; echo -ne "${W}File: ${NC}"; read f; file "$f" ;;

        31) uptime ;;
        32) free -h ;;
        33) df -h ;;
        34) lscpu || uname -m ;;
        35) cat /etc/os-release ;;
        36) uname -r ;;
        37) top -b -n 1 | head -n 15 ;;
        38) lsblk || fdisk -l 2>/dev/null ;;
        39) lshw -short 2>/dev/null || echo "Needs root/lshw." ;;
        40) systemd-resolve --flush-caches 2>/dev/null || echo "Cache flushed." ;;

        41) _req zip zip; echo -ne "${W}Folder: ${NC}"; read f; zip -r "${f}.zip" "$f" ;;
        42) _req unzip unzip; echo -ne "${W}Zip: ${NC}"; read z; unzip "$z" ;;
        43) find . -type f -size +50M -exec ls -lh {} \; | awk '{ print $9 ": " $5 }' ;;
        44) find . -type f -empty ;;
        45) echo -ne "${W}Word: ${NC}"; read w; echo -ne "${W}File: ${NC}"; read f; grep -n "$w" "$f" ;;
        46) _req wget wget; echo -ne "${W}URL: ${NC}"; read u; wget "$u" ;;
        47) echo -ne "${W}File name: ${NC}"; read f; touch "$f"; echo -e "${G}Created $f${NC}" ;;
        48) history -c && history -w; echo -e "${G}History Cleared.${NC}" ;;
        49) echo -e "${C}[*] Updating Packages...${NC}"; if command -v pkg >/dev/null; then pkg update -y; else apt update -y; fi ;;
        50|99) echo -e "${R}[!] EXITING PHANTOM CORE...${NC}"; pkill php; exit 0 ;;
        *) echo -e "${R}[!] Invalid Module!${NC}" ;;
    esac
    echo -ne "\n${W}Press [${G}ENTER${W}] to Return...${NC}"; read
}

# --- [ ULTIMATE CYBER UI ] ---
_banner() {
    clear
    local timestamp=$(date +%H:%M:%S)
    local battery=$(termux-battery-status 2>/dev/null | grep percentage | awk -F: '{print $2}' | tr -d ' ,')
    [[ -z $battery ]] && battery="N/A"
    
    echo -e "${DG}┌────────────────────────────────────────────────────────────┐"
    echo -e "│ ${W}AUTH: ${G}GRANTED ${W}│ CORE: ${P}V10.0-CYBER ${W}│ IP: ${C}HIDDEN ${W}│ ${W}BAT: ${G}$battery% ${DG}│"
    echo -e "└────────────────────────────────────────────────────────────┘${NC}"
    
    # โลโก้
    echo -e "${C}      :::::::::  :::    :::     :::     ::::    ::: ::::::::::: ::::::::  ::::     :::: "
    echo -e "     :+:    :+: :+:    :+:   :+: :+:   :+:+:   :+:     :+:    :+:    :+: +:+:+: :+:+:+ "
    echo -e "    +:+    +:+ +:+    +:+  +:+   +:+  :+:+:+  +:+     +:+    +:+    +:+ +:+ +:+:+ +:+  "
    echo -e "   +#++:++#+  +#++:++#++ +#++:++#++: +#+: +:+ +#+     +#+    +#+    +#+ +#+  +:+  +#+   "
    echo -e "  +#+        +#+    +#+ +#+     +#+ +#+  +#+#+#     +#+    +#+    +#+ +#+       +#+    "
    echo -e " #+#        #+#    #+# #+#     #+# #+#   #+#+#     #+#    #+#    #+# #+#       #+#     "
    echo -e "###        ###    ### ###     ### ###    ####     ###     ########  ###       ###      "
    echo -e "${R}      ::::::::: ::::::::::: ::::    ::: ::::::::::: ::::::::      :::     :::        "
    echo -e "     :+:    :+:    :+:     :+:+:   :+:     :+:    :+:    :+:   :+: :+:   :+:         "
    echo -e "    +:+    +:+    +:+     :+:+:+  +:+     +:+    +:+         +:+   +:+  +:+          "
    echo -e "   +#+    +:+    +#+     +#+: +:+ +#+     +#+    +#+        +#++:++#++: +#+           "
    echo -e "  +#+    +#+    +#+     +#+  +#+#+#     +#+    +#+        +#+     +#+ +#+            "
    echo -e " #+#    #+#    #+#     #+#   #+#+#     #+#    #+#    #+# #+#     #+# #+#             "
    echo -e "######### ########### ###    #### ########### ########  ###     ### ##########       "
    echo -e "${DG}─────────────────────────────────────────────────────────────────────────────────────${NC}"
    echo -e " ${W}DEV:${C} PHANTOM DINICAL ${W}| ${W}STATUS:${G} AUTHORIZED ACCESS ${W}| ${W}T:${C} $timestamp ${DG}[ ${BLINK}${G}•${NC} ${DG}]${NC}"
    echo -e "${DG}─────────────────────────────────────────────────────────────────────────────────────${NC}"
}

_menu() {
    echo -e " ${P}┌─[ NETWORK RECON ]──────────┐ ${P}┌─[ SECURITY AUDIT ]─────────┐${NC}"
    echo -e "  ${R}01.${G} Ping Analyzer           ${R}11.${G} Port Scan (Local)"
    echo -e "  ${R}02.${G} Route Tracer            ${R}12.${G} Port Scan (Remote)"
    echo -e "  ${R}03.${G} Whois Database          ${R}13.${G} Active Connections"
    echo -e "  ${R}04.${G} DNS Dig (A Rec)         ${R}14.${G} Open Port List"
    echo -e "  ${R}05.${G} DNS Dig (MX Rec)        ${R}15.${G} SSL/TLS Audit"
    echo -e "  ${R}06.${G} Public IP Fetch         ${R}16.${G} SUID Vulnerability"
    echo -e "  ${R}07.${G} Local Network Info      ${R}17.${G} Auth-Log Monitor"
    echo -e "  ${R}08.${G} IP Geo-Location         ${R}18.${G} User Session List"
    echo -e "  ${R}09.${G} HTTP Header Grab        ${R}19.${G} SSH Status Check"
    echo -e "  ${R}10.${G} Site Source Code        ${R}20.${G} Cyber-Password Gen"
    echo -e ""
    echo -e " ${P}┌─[ CRYPTO & UTILS ]─────────┐ ${P}┌─[ SYS ADMIN PRO ]──────────┐${NC}"
    echo -e "  ${R}21.${G} Base64 Encoder          ${R}31.${G} Core Uptime"
    echo -e "  ${R}22.${G} Base64 Decoder          ${R}32.${G} Free Memory (RAM)"
    echo -e "  ${R}23.${G} MD5 Checksum Gen        ${R}33.${G} Disk Usage (DF)"
    echo -e "  ${R}24.${G} SHA1 Checksum Gen       ${R}34.${G} CPU Architecture"
    echo -e "  ${R}25.${G} SHA256 Checksum Gen     ${R}35.${G} OS Distribution"
    echo -e "  ${R}26.${G} SHA512 Checksum Gen     ${R}36.${G} Kernel Engine"
    echo -e "  ${R}27.${G} URL Encode (Auto)       ${R}37.${G} Active Process (Top)"
    echo -e "  ${R}28.${G} Hex-Editor View         ${R}38.${G} Block Device List"
    echo -e "  ${R}29.${G} RSA Key Generator       ${R}39.${G} Hardware Detailed"
    echo -e "  ${R}30.${G} Magic File ID           ${R}40.${G} DNS Cache Flush"
    echo -e ""
    echo -e " ${P}┌─[ ADVANCED MODULES ]───────┐ ${P}┌─[ SYSTEM CONTROL ]─────────┐${NC}"
    echo -e "  ${R}41.${G} Archive Compressor      ${R}46.${G} Wget Downloader"
    echo -e "  ${R}42.${G} Archive Extractor       ${R}47.${G} Dummy File Gen"
    echo -e "  ${R}43.${G} Deep Large File Find    ${R}48.${G} Ghost History Wipe"
    echo -e "  ${R}44.${G} Empty File Purge        ${R}49.${G} Sync Package List"
    echo -e "  ${R}45.${G} Advanced Grep Search    ${R}50.${G} TERMINATE CORE (EXIT)"
    echo -e "${DG}─────────────────────────────────────────────────────────────────────────────────────${NC}"
}

# --- [ RUNTIME LOOP ] ---
while true; do
    _banner; _menu
    echo -ne "${C}PhantomDinical${R}@${W}ProAudit${NC}:${C}~# ${NC}"
    read cmd
    [[ "$cmd" == "50" || "$cmd" == "99" ]] && { echo -e "${R}[!] DEACTIVATING PHANTOM CORE...${NC}"; pkill php; exit 0; }
    _execute "$cmd"
done
