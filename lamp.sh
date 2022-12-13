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
    echo "[+] Installing apache2"
    sudo apt-get update
    sudo apt-get install apache2
    echo "[+] apache2 Installed"
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

lnmp_stack()
{
    echo "[+] Installing ngix"
    sudo apt-get update
    sudo apt-get install nginx -y
    echo "[+] apache2 Installed"
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
    echo "[*] Nginx"
    echo "[*] PHP 8.1,PHP 8.0,PHP 7.4,PHP 7.3,PHP 7.2"
    echo "[*] MYSQL"
}

mysql_server()
{
    echo "[+] Mysql Server installation stared"
    sudo apt install mysql-server
    echo "[+] Mysql Server installation completed"
    echo "[+] Configuring MySQL"
    sudo mysql_secure_installation
    echo "[+] Configuring MySQL Completed"
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
    echo "[+] PHP 8.1 Installation Started"
    sudo apt-get install php8.1 php8.1-fpm
    sudo apt-get install php8.1-mysql php8.1-mbstring php8.1-xml php8.1-gd php8.1-curl
    echo "[+] PHP 8.1 Installation Completed"
}

php_8.0()
{
    #php 8.0
    echo "[+] PHP 8.0 Installation Started"
    sudo apt-get install php8.0 php8.0-fpm
    sudo apt-get install php8.0-mysql php8.0-mbstring php8.0-xml php8.0-gd php8.0-curl
    echo "[+] PHP 8.1 Installation Completed"
}

php_7.4()
{
    #php 7.4
    echo "[+] PHP 7.4 Installation Started"
    sudo apt-get install php7.4 php7.4-fpm
    sudo apt-get install php7.4-mysql php7.4-mbstring php7.4-xml php7.4-gd php7.4-curl
    echo "[+] PHP 7.4 Installation Completed"
}

php_7.3()
{
    #php 7.3
    echo "[+] PHP 7.3 Installation Started"
    sudo apt-get install php7.3 php7.3-fpm
    sudo apt-get install php7.3-mysql php7.3-mbstring php7.3-xml php7.3-gd php7.3-curl
    echo "[+] PHP 7.3 Installation Completed"
}

php_7.2()
{
    #php 7.2
    echo "[+] PHP 7.2 Installation Started"
    sudo apt-get install php7.2 php7.2-fpm
    sudo apt-get install php7.2-mysql php7.2-mbstring php7.2-xml php7.2-gd php7.2-curl
    echo "[+] PHP 7.2 Installation Completed"
}

php_7.1()
{
    #php 7.1
    echo "[+] PHP 7.1 Installation Started"
    sudo apt-get install php7.1 php7.1-fpm
    sudo apt-get install php7.1-mysql php7.1-mbstring php7.1-xml php7.1-gd php7.1-curl
    echo "[+] PHP 7.1 Installation Completed"
}

php_5.6()
{
    #php 5.6
    echo "[+] PHP 5.6 Installation Started"
    sudo apt-get install php5.6 php5.6-fpm
    sudo apt-get install php5.6-mysql php5.6-mbstring php5.6-xml php5.6-gd php5.6-curl
    echo "[+] PHP 5.6 Installation Completed"
}

change_php()
{
    #to change the php version
    sudo update-alternatives --config php

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
    echo '  _____  _    _ _____        ____           _____ _    _ '
    echo ' |  __ \| |  | |  __ \      |  _ \   /\    / ____| |  | |'
    echo ' | |__) | |__| | |__) |_____| |_) | /  \  | (___ | |__| |'
    echo ' |  ___/|  __  |  ___/______|  _ < / /\ \  \___ \|  __  |'
    echo ' | |    | |  | | |          | |_) / ____ \ ____) | |  | |'
    echo ' |_|    |_|  |_|_|          |____/_/    \_\_____/|_|  |_|'
    echo ''
    echo -e "$NC"
    echo ''
}

main()
{
    label
    IYellow='\033[0;93m'
    NC='\033[0m'
    echo -e "$IYellow"
    echo "Current PHP Version"
    php -r "echo substr(phpversion(),0,3);"
    echo -e "$NC"
    echo ""
    echo "[1]   Add PHP repository"
    echo "[2]   Install PHP 8.1"
    echo "[3]   Install PHP 8.0"
    echo "[4]   Install PHP 7.4"
    echo "[5]   Install PHP 7.3"
    echo "[6]   Install PHP 7.2"
    echo "[7]   Install PHP 7.1"
    echo "[8]   Install PHP 5.6"
    echo "[9]   Set the php version"
    echo "[10]  PHP Installed Modules"
    echo "[11]  Create LAMP Stack"
    echo "[12]  Enable Apache2 Module re write"
    echo "[13]  Create LNMP Stack"
    echo "[100]     Update packages"
    echo ""
    option_manager  
        
}
main
