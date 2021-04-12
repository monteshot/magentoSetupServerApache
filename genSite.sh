#!/bin/bash
DOMENNAME=$1
PREVIOUS_USERNAME=$2
sudo cat << EOF
<VirtualHost *:80>
    ServerName $DOMENNAME
    ServerAlias www.$DOMENNAME
    ServerAdmin webmaster@$DOMENNAME
    DocumentRoot /home/$PREVIOUS_USERNAME/ApacheSites/$DOMENNAME/content/
    ErrorLog /home/$PREVIOUS_USERNAME/ApacheSites/$DOMENNAME/log/$DOMENNAME.error.log
    CustomLog /home/$PREVIOUS_USERNAME/ApacheSites/$DOMENNAME/log/$DOMENNAME.access.log combined
    
#     RewriteEngine On
#     RewriteCond %{HTTPS} off
#     RewriteRule (.*) https://%{HTTP_HOST}%{REQUEST_URI}
    
    LogLevel warn
    <Directory /home/$PREVIOUS_USERNAME/ApacheSites/$DOMENNAME/content/>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>

<IfModule mod_ssl.c>
    <VirtualHost *:443>
        ServerName $DOMENNAME
        ServerAlias www.$DOMENNAME
        ServerAdmin webmaster@$DOMENNAME
        
        SSLEngine on
        SSLCertificateFile	/etc/ssl/certs/$DOMENNAME.crt
		SSLCertificateKeyFile /etc/ssl/private/$DOMENNAME.key
		<FilesMatch "\.(cgi|shtml|phtml|php)$">
				SSLOptions +StdEnvVars
		</FilesMatch>
		<Directory /usr/lib/cgi-bin>
				SSLOptions +StdEnvVars
		</Directory>
		
		
        DocumentRoot /home/$PREVIOUS_USERNAME/ApacheSites/$DOMENNAME/content/
        ErrorLog /home/$PREVIOUS_USERNAME/ApacheSites/$DOMENNAME/log/$DOMENNAME.error.log
        CustomLog /home/$PREVIOUS_USERNAME/ApacheSites/$DOMENNAME/log/$DOMENNAME.access.log combined
        <Directory /home/$PREVIOUS_USERNAME/ApacheSites/$DOMENNAME/content/>
            Options Indexes FollowSymLinks
            AllowOverride All
            Require all granted
        </Directory>
        
    </VirtualHost>
</IfModule>



EOF
