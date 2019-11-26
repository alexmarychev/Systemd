#Установка и запуск watchlog
sudo mv /home/vagrant/watchlog.sh /opt/
sudo mv /home/vagrant/watchlog.log /var/log/
sudo mv /home/vagrant/watchlog.service /etc/systemd/system/
sudo mv /home/vagrant/watchlog.timer /etc/systemd/system/
sudo mv /home/vagrant/watchlog /etc/sysconfig/
sudo systemctl start watchlog.timer
sudo systemctl start watchlog.service

#Установка и запуск spawn-fcgi
sudo yum install epel-release -y && yum install spawn-fcgi php php-cli mod_fcgid httpd -y
sudo mv /home/vagrant/spawn-fcgi.service /etc/systemd/system/
sudo sed -i "s%#SOCKET=/var/run/php-fcgi.sock%SOCKET=/var/run/php-fcgi.sock%" /etc/sysconfig/spawn-fcgi
sudo sed -i 's%#OPTIONS="-u apache -g apache -s $SOCKET -S -M 0600 -C 32 -F 1 -P /var/run/spawn-fcgi.pid -- /usr/bin/php-cgi"%OPTIONS="-u apache -g apache -s $SOCKET -S -M 0600 -C 32 -F 1 -- /usr/bin/php-cgi"%' /etc/sysconfig/spawn-fcgi
sudo systemctl start spawn-fcgi

#Настройка Apache
sudo cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/first.conf
sudo cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/second.conf
sudo mv /home/vagrant/httpd-* /etc/sysconfig/
sudo sed -i "s%Listen 80%Listen 8080\nPidFile /var/run/httpd-first.pid%" /etc/httpd/conf/first.conf
sudo sed -i "s%Listen 80%Listen 80\nPidFile /var/run/httpd-second.pid%" /etc/httpd/conf/second.conf
sudo mv /home/vagrant/httpd@.service /etc/systemd/system/
sudo systemctl start httpd@first
sudo systemctl start httpd@second

#!/bin/bash
#Устанавливаем java
sudo yum install java -y

#Создаем директории для jira
sudo mkdir -p /opt/atlassian/jira
sudo mkdir -p /var/atlassian/application-data/jira
cd /opt/atlassian/jira

#Разархивируем архив с приложением
sudo tar zxf /home/vagrant/current.tar.gz

#Создаем симлинк для удобства работы с приложением
sudo ln -s atlassian-jira-software-8.5.1-standalone/ current

#Прописываем в конфиге jira путь до домашнего каталога
sudo sed -i "s%jira.home =%jira.home=/var/atlassian/application-data/JIRA%" current/atlassian-jira/WEB-INF/classes/jira-application.properties

#Переносим готовый юнит файл в нужную директорию
sudo mv /home/vagrant/jira.service /etc/systemd/system/

#Запускаем приложение
systemctl start jira

