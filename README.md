# OTUS ДЗ №22. Пользователи и группы. Авторизация и аутентификация . #
-----------------------------------------------------------------------
## Домашнее задание ##

1. Запретить всем пользователям, кроме группы admin логин в выходные (суббота и воскресенье), без учета праздников
2. Дать конкретному пользователю права работать с докером и возможность рестартить докер сервис

## Результат ##
### 1  задание ###
1. Запустить стенд командой  ```vagrant up```
2. Подключиться к стенду командой ```vagrant ssh```
3. Попробовать подключиться к локальной машине по ssh в выходные дни пользователями admin (пароль admin) и user1 (пароль user1). Для изменения даты можно воспользоваться командой ```date -s "12 NOV 2022"```


### 2 задание ###
1. Сменить пользователя на dockerUser командой ```su - dockerUser``` (пароль dockeruser) 
2. Перезапустить docker командой ```systemctl restart docker```
