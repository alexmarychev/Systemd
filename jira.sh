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

