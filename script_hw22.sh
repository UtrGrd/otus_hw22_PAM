# Добавляем пользователей и группы, разрешаем заходить через ssh по паролю
useradd admin
usermod -aG admin admin
useradd user1
echo "admin:admin" | chpasswd
echo "user1:user1" | chpasswd
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart sshd

# Добавляем epel репозиторий и устанавливаем pam_script
yum update -y
yum install epel-release -y
yum install pam_script -y

# Добавляем запись о необходимости проверки из скрипта при аутентификации по ssh
sed '2i\account       required     pam_script.so' /etc/pam.d/sshd > /etc/pam.d/temporary.txt
rm -f /etc/pam.d/sshd
mv /etc/pam.d/temporary.txt /etc/pam.d/sshd

# Копируем скрипт проверки и делаем его исполняемым. 
rm /etc/pam_script
cp /vagrant/pam_script_ssh_auth.sh /etc/pam_script 
chmod +x /etc/pam_script

# дать конкретному пользователю права работать с докером и возможность рестартить докер сервис

# Устанавливаем docker
yum update -y
yum install docker -y 
systemctl start docker

# Добавляем пользователя dockerUser, назначаем ему группу docker и устанавилаем пароль
useradd dockerUser
groupadd docker
usermod -aG docker dockerUser
echo "dockerUser:dockeruser" | chpasswd

# Копируем правило PolicyKit
cp /vagrant/01-systemd-docker-dockerUser.rules /etc/polkit-1/rules.d/