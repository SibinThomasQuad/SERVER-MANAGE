clear_color()
{
    NC='\033[0m'
    echo -e "$NC"
}

get_os_info()
{
    cat /etc/os-release
}

install_postgress()
{
    GREEN='\033[0;32m'
    echo "[+] Installing postgress SQL"
    sudo apt install postgresql postgresql-contrib
    sudo systemctl start postgresql.service
    echo -e "$GREEN [+] postgress SQL Installed"
    clear_color

}

install_nginx()
{
    GREEN='\033[0;32m'
    echo "[+] Installing ngix"
    sudo apt-get update
    sudo apt-get install nginx -y
    echo -e "$GREEN [+] nginx Installed"
    clear_color
}

install_apache()
{
    GREEN='\033[0;32m'
    echo "[+] Installing apache2"
    sudo apt-get update
    sudo apt-get install apache2
    echo -e "$GREEN [+] apache2 Installed"
    clear_color
}

list_running_services()
{
    service  --status-all
}

list_installed_packages()
{
    apt list --installed
}

ssh_install()
{
    echo "[+] Installing OPEN SSH"
    sudo apt-get install openssh-server
    sudo systemctl enable ssh
    sudo ufw allow ssh
    sudo systemctl enable ssh --now
    sudo systemctl start ssh
    GREEN='\033[0;32m'
    echo -e "$GREEN [+] SSH Server installation completed"
    clear_color
}

vsfpt_install()
{
    sudo apt update
    echo "[+] Installing VSFTP"
    sudo apt install vsftpd
    sudo systemctl start vsftpd
    sudo systemctl enable vsftpd
    sudo ufw allow 20/tcp
    sudo ufw allow 21/tcp
    GREEN='\033[0;32m'
    echo -e "$GREEN [+] FTP Server installation completed"
    clear_color
}

git_install()
{
    GREEN='\033[0;32m'
    echo "[+] Installing Git"
    sudo apt update
    sudo apt install git
    echo -e "$GREEN [+] Git installation completed"
    clear_color
}

mod_rewrite()
{
    sudo a2enmod rewrite
    sudo service apache2 restart
    echo "[+] mod_rewrite enabled"
    GREEN='\033[0;32m'
    NC='\033[0m'
    
    echo -e "$GREEN If you plan on using mod_rewrite in .htaccess files, you also need to enable the use of .htaccess files by changing AllowOverride None to AllowOverride FileInfo. For the default website, edit /etc/apache2/sites-available/default:

            <Directory /var/www/>
                Options Indexes FollowSymLinks MultiViews
                # changed from None to FileInfo
                AllowOverride FileInfo
                Order allow,deny
                allow from all
            </Directory>

        After such a change, you need to restart Apache again.$NC"
}

lamp_stack()
{
    install_apache
    update_packages
    php_repository
    php_8.1
    php_8.0
    php_7.4
    php_7.3
    php_7.2
    mysql_server
    clear
    echo "Installed Programs"
    echo "-------------------------------------------------"
    echo "[*] Apache2"
    echo "[*] PHP 8.1,PHP 8.0,PHP 7.4,PHP 7.3,PHP 7.2"
    echo "[*] MYSQL"
}
link_php_nginx()
{
    GREEN='\033[0;32m'
    sudo mkdir /var/www/html/php_webs
    sudo cp conf/php /etc/nginx/sites-available
    sudo ln -s /etc/nginx/sites-available/php /etc/nginx/sites-enabled/
    sudo service nginx restart
    echo -e "$GREEN [+] Nginx Linked with PHP"
    clear_color
}

lnmp_stack()
{
    install_nginx
    update_packages
    php_repository
    php_8.1
    php_8.0
    php_7.4
    php_7.3
    php_7.2
    link_php_nginx
    mysql_server
    clear
    echo "Installed Programs"
    echo "-------------------------------------------------"
    echo "[*] Nginx"
    echo "[*] PHP 8.1,PHP 8.0,PHP 7.4,PHP 7.3,PHP 7.2"
    echo "[*] MYSQL"
    echo "[*] URL : http://127.0.0.1:71"
}

mysql_server()
{
    GREEN='\033[0;32m'
    echo "[+] Mysql Server installation stared"
    sudo apt install mysql-server
    echo -e "$GREEN [+] Mysql Server installation completed"
    clear_color
    echo "[+] Configuring MySQL"
    sudo mysql_secure_installation
    echo -e "$GREEN [+] Configuring MySQL Completed"
    clear_color
}

update_packages()
{
    #upgrading the packages 
    sudo apt-get update
    sudo apt-get upgrade 
}

php_repository()
{
    #adding the php repository
    sudo apt install software-properties-common
    sudo add-apt-repository ppa:ondrej/php
    sudo apt update
}

php_current_modules()
{

    GREEN='\033[0;32m'
    NC='\033[0m'
    php_version=$(php -r "echo substr(phpversion(),0,3);")
    echo "Modules enabled in PHP $php_version"
    echo "-------------------------------------------------"
    php_dir="/etc/php/$php_version/mods-available"
    echo -e "$GREEN"
    ls -1 "$php_dir"
    echo -e "$NC"
}

php_8.1()
{
    #php 8.1
    GREEN='\033[0;32m'
    echo "[+] PHP 8.1 Installation Started"
    sudo apt-get install php8.1 php8.1-fpm
    sudo apt-get install php8.1-mysql php8.1-mbstring php8.1-xml php8.1-gd php8.1-curl
    echo -e "$GREEN [+] PHP 8.1 Installation Completed"
    clear_color
}

php_8.0()
{
    #php 8.0
    GREEN='\033[0;32m'
    echo "[+] PHP 8.0 Installation Started"
    sudo apt-get install php8.0 php8.0-fpm
    sudo apt-get install php8.0-mysql php8.0-mbstring php8.0-xml php8.0-gd php8.0-curl
    echo -e "$GREEN [+] PHP 8.0 Installation Completed"
    clear_color
}

php_7.4()
{
    #php 7.4
    GREEN='\033[0;32m'
    echo "[+] PHP 7.4 Installation Started"
    sudo apt-get install php7.4 php7.4-fpm
    sudo apt-get install php7.4-mysql php7.4-mbstring php7.4-xml php7.4-gd php7.4-curl
    echo -e "$GREEN [+] PHP 7.4 Installation Completed"
    clear_color
}

php_7.3()
{
    #php 7.3
    GREEN='\033[0;32m'
    echo "[+] PHP 7.3 Installation Started"
    sudo apt-get install php7.3 php7.3-fpm
    sudo apt-get install php7.3-mysql php7.3-mbstring php7.3-xml php7.3-gd php7.3-curl
    echo -e "$GREEN [+] PHP 7.3 Installation Completed"
    clear_color
}

php_7.2()
{
    #php 7.2
    GREEN='\033[0;32m'
    echo "[+] PHP 7.2 Installation Started"
    sudo apt-get install php7.2 php7.2-fpm
    sudo apt-get install php7.2-mysql php7.2-mbstring php7.2-xml php7.2-gd php7.2-curl
    echo -e "$GREEN [+] PHP 7.2 Installation Completed"
    clear_color
}

php_7.1()
{
    #php 7.1
    GREEN='\033[0;32m'
    echo "[+] PHP 7.1 Installation Started"
    sudo apt-get install php7.1 php7.1-fpm
    sudo apt-get install php7.1-mysql php7.1-mbstring php7.1-xml php7.1-gd php7.1-curl
    echo -e "$GREEN [+] PHP 7.1 Installation Completed"
    clear_color
}

php_5.6()
{
    #php 5.6
    GREEN='\033[0;32m'
    echo "[+] PHP 5.6 Installation Started"
    sudo apt-get install php5.6 php5.6-fpm
    sudo apt-get install php5.6-mysql php5.6-mbstring php5.6-xml php5.6-gd php5.6-curl
    echo -e "$GREEN [+] PHP 5.6 Installation Completed"
    clear_color
}

change_php()
{
    #to change the php version
    sudo update-alternatives --config php

}

apache_error_log()
{
    nano /var/log/apache2/error.log
}

apache_access_log()
{
    nano /var/log/apache2/access.log
}

nginx_error_log()
{
    nano /var/log/nginx/error.log
}

nginx_access_log()
{
    nano /var/log/nginx/access.log
}

visited_ips_nginx()
{
    GREEN='\033[0;32m'
    echo -e "$GREEN [+] List of visited IPS in NGINX"
    clear_color
    sudo awk '{print $1}' /var/log/nginx/access.log | sort | uniq -c | sort -nr
}

most_visited_url()
{
    GREEN='\033[0;32m'
    echo -e "$GREEN [+] List of visited URLS in NGINX"
    clear_color
    awk -F\" '{print $2}' /var/log/nginx/access.log | awk '{print $2}' | sort | uniq -c | sort -r
}

option_manager()
{
    #manage options
    IRed='\033[0;91m'
    NC='\033[0m'
    echo -e "$IRed"
    echo "[*] Select Option : "
    echo -e "$NC"
    read option_name
    
    if [ $option_name == 29 ]; then

               most_visited_url
        fi
    if [ $option_name == 28 ]; then

               visited_ips_nginx
        fi
    if [ $option_name == 24 ]; then

               nginx_access_log
        fi
    if [ $option_name == 25 ]; then

                nginx_error_log
        fi
    if [ $option_name == 26 ]; then

               apache_access_log
        fi
    if [ $option_name == 27 ]; then

                apache_error_log
        fi
    if [ $option_name == 23 ]; then

                install_postgress
        fi
    if [ $option_name == 22 ]; then

                link_php_nginx
        fi
    if [ $option_name == 21 ]; then

                mysql_server
        fi
    if [ $option_name == 20 ]; then

                install_nginx
        fi
    if [ $option_name == 19 ]; then

                install_apache
        fi
    if [ $option_name == 18 ]; then

                list_running_services
        fi
    if [ $option_name == 17 ]; then

                list_installed_packages
        fi
    if [ $option_name == 16 ]; then

                ssh_install
        fi
    if [ $option_name == 15 ]; then

                vsfpt_install
        fi
    if [ $option_name == 14 ]; then

                git_install
        fi
    if [ $option_name == 13 ]; then

                lnmp_stack
        fi
    if [ $option_name == 12 ]; then

                mod_rewrite
        fi
    if [ $option_name == 11 ]; then

                lamp_stack
        fi
    if [ $option_name == 10 ]; then

                php_current_modules
        fi
    if [ $option_name == 100 ]; then

                update_packages
        fi
    if [ $option_name == 1 ]; then

                php_repository
        fi
    if [ $option_name == 2 ]; then
               php_8.1
        fi
    if [ $option_name == 3 ]; then

                php_8.0
        fi
    if [ $option_name == 4 ]; then

                php_7.4
        fi
    if [ $option_name == 5 ]; then

                php_7.3
        fi
    if [ $option_name == 6 ]; then

                php_7.2
        fi
    if [ $option_name == 7 ]; then

                php_7.1
        fi
    if [ $option_name == 8 ]; then

                php_5.6
        fi
    if [ $option_name == 9 ]; then

                change_php
        fi
    echo "[*] Continue ( Y/N )"
        read  continue_option
    if [ $continue_option == 'Y' ]; then

                main
        fi
    
}
label()
{

    clear
    ICyan='\033[0;96m'
    NC='\033[0m'
    echo -e "$ICyan"
    echo ''
    echo '  ███████ ████████  █████   ██████ ██   ██      ██████   █████  ███████ ██   ██'
    echo '  ██         ██    ██   ██ ██      ██  ██       ██   ██ ██   ██ ██      ██   ██'
    echo '  ███████    ██    ███████ ██      █████  █████ ██████  ███████ ███████ ███████'
    echo '       ██    ██    ██   ██ ██      ██  ██       ██   ██ ██   ██      ██ ██   ██' 
    echo '  ███████    ██    ██   ██  ██████ ██   ██      ██████  ██   ██ ███████ ██   ██' 
    echo ''
    echo -e "$NC"
    echo ''
}

main()
{
    label
    BPurple='\033[1;36m'
    Purple='\033[0;35m'
    IRed='\033[0;91m'
    IYellow='\033[0;93m'
    NC='\033[0m'
    echo -e "$IYellow"
    echo "Current PHP Version"
    php -r "echo substr(phpversion(),0,3);"
    echo ""
    echo ""
    BBlue='\033[1;34m' 
    echo -e "$BBlue"
    echo "OS Information"
    get_os_info
    echo -e "$NC"
    BBlue='\033[0;32m'
    echo ""
    echo -e "[1]    [Add PHP repository $IYellow(Add php repositary to linux system to install diffrent php versions)$NC $IRed[*important]$NC"
    echo -e "[2]    Install PHP 8.1 $BBlue[PHP]$NC"
    echo -e "[3]    Install PHP 8.0 $BBlue[PHP]$NC"
    echo -e "[4]    Install PHP 7.4 $BBlue[PHP]$NC"
    echo -e "[5]    Install PHP 7.3 $BBlue[PHP]$NC"
    echo -e "[6]    Install PHP 7.2 $BBlue[PHP]$NC"
    echo -e "[7]    Install PHP 7.1 $BBlue[PHP]$NC"
    echo -e "[8]    Install PHP 5.6 $BBlue[PHP]$NC"
    echo -e "[9]    Set the php version $IYellow(You Can change default php version by clicking this)$NC" 
    echo -e "[10]   PHP Installed Modules $BBlue[PHP]$NC"
    echo -e "[11]   Create LAMP Stack $IYellow(You Can Install Apache,PHP,Mysql In sigle click)$NC"
    echo -e "[12]   Enable Apache2 Module re write $BPurple[APACHE]$NC"
    echo -e "[13]   Create LEMP Stack $IYellow(You Can Install Nginx,PHP,Mysql In sigle click)$NC"
    echo "[14]  Install Git"
    echo "[15]  Install FTP Server"
    echo "[16]  Install SSH Server"
    echo "[17]  List Installed Packages"
    echo "[18]  List Running Services"
    echo -e "[19]   Install Apache2 $BPurple[APACHE]$NC"
    echo -e "[20]   Install NGINX $Purple[NGINX]$NC"
    echo "[21]  Install MYSQL Server"
    echo -e "[22]   Connect PHP with NGIX $IYellow(Link PHP and Nginx in a single click)$NC $Purple[NGINX]$NC"
    echo "[23]  Install PostgreSQL"
    echo -e "[24]   View NGINX Access Log $Purple[NGINX]$NC"
    echo -e "[25]   View NGINX Error Log $Purple[NGINX]$NC"
    echo -e "[26]   View APACHE Access Log $BPurple[APACHE]$NC"
    echo -e "[27]   View APACHE Error Log $BPurple[APACHE]$NC"
    echo -e "[28]   List Visited Ip address NGINX $Purple[NGINX]$NC"
    echo -e "[29]   List Most Visited URLS NGINX $Purple[NGINX]$NC"
    echo "[100]     Update packages"
    echo ""
    option_manager  
        
}
main
