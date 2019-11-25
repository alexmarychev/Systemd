###HW5

#Написание сервиса для мониторинга лога

1. Все шаги залоггированы в файле watchlog.txt

#Переписать init-скрипт на unit-файл

1. Все шаги залоггированы в файле spawn-fcgi.txt

#Дополнить юнит apache возможностью запустить несколько инстансов сервера с разными конфигами

1. Все шаги залоггированы в файле httpd.txt

#Переписать скрипт запуска Atlassian Jira на unit-файл

1. Скачал архив с Atlassian Jira и переименовал его для удобства в ```current.tar.gz```

2. Создал юнит файл для запуска приложения jira.service

3. Написал скрипт для разворачивания приложения jira.sh. В скрипте есть комментарии по всем командам.

4. В Vagrantfile добавил следующие строки:

Копируем юнит файл и архив с приложением в домашнюю папку /home/vagrant:
```
box.vm.provision "file", source: "/home/alexmar/Systemd/jira.service", destination: "/home/vagrant/" 
box.vm.provision "file", source: "/home/alexmar/current.tar.gz", destination: "/home/vagrant/"
```

Выполняем скрипт для разворачивания приложения и запуска jira:
```
box.vm.provision "shell", path: "jira.sh"
```

5. Вывод команды на VM ```systemctl status jira``` после разворачивания VM вагрантом:
```
[vagrant@lvm ~]$ sudo systemctl status jira
● jira.service - JIRA Service
   Loaded: loaded (/etc/systemd/system/jira.service; disabled; vendor preset: disabled)
   Active: active (running) since Mon 2019-11-25 12:38:39 UTC; 19s ago
  Process: 4476 ExecStart=/opt/atlassian/jira/current/bin/start-jira.sh (code=exited, status=0/SUCCESS)
 Main PID: 4513 (java)
   CGroup: /system.slice/jira.service
           └─4513 /usr/bin/java -Djava.util.logging.config.file=/opt/atlassian/jira/current/conf/logging.properties -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Xms384m -Xmx2048m ...

Nov 25 12:38:39 lvm start-jira.sh[4476]: MMMMMM
Nov 25 12:38:39 lvm start-jira.sh[4476]: +MMMMM
Nov 25 12:38:39 lvm start-jira.sh[4476]: MMMMM
Nov 25 12:38:39 lvm start-jira.sh[4476]: `UOJ
Nov 25 12:38:39 lvm start-jira.sh[4476]: Atlassian Jira
Nov 25 12:38:39 lvm start-jira.sh[4476]: Version : 8.5.1
Nov 25 12:38:39 lvm start-jira.sh[4476]: If you encounter issues starting or stopping JIRA, please see the Troubleshooting guide at https://docs.atlassian.com/jira/jadm-docs-085/Troublesh...g+installation
Nov 25 12:38:39 lvm start-jira.sh[4476]: Server startup logs are located in /opt/atlassian/jira/current/logs/catalina.out
Nov 25 12:38:39 lvm start-jira.sh[4476]: Tomcat started.
Nov 25 12:38:39 lvm systemd[1]: Started JIRA Service.
Hint: Some lines were ellipsized, use -l to show in full.
```
