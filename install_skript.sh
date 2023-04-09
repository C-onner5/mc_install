#!/bin/bash

echo "Minecraft Server installer Skript von C-onner -> https://c-onner.de"

read -p "Möchtest du die Installation starten? (ja/nein): " choice
case "$choice" in
  j|J|ja|Ja ) echo "Weiter geht's...";;
  * ) echo "Abbruch."; exit;;
esac

java -version > /dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "Java ist bereits installiert."
else
  echo "Java ist nicht installiert!"
  read -p "Welche Java-Version soll installiert werden? (11/17): " java_version
  sudo apt update
  sudo apt install openjdk-$java_version-jdk-headless -y
fi

read -p "Wie soll der Ordner heißen, in dem der Server installiert werden soll? " folder_name
mkdir $folder_name
cd $folder_name

read -p "Welche Minecraft Server-Version möchtest du installieren? (1.19.4, 1.18.2, 1.17.1, 1.16.5): " minecraft_version
case "$minecraft_version" in
  1.19.4 ) wget https://nc.c-onner.de/s/g7QS27TBB8pe947/download/paper.jar;;
  1.18.2 ) wget https://nc.c-onner.de/s/MZFxpYYwKGoxmj6/download/paper.jar;;
  1.17.1 ) wget https://nc.c-onner.de/s/2gBpz7ABRfKWfnA/download/paper.jar;;
  1.16.5 ) wget https://nc.c-onner.de/s/KKHJfsiqLwoRAq3/download/paper.jar;;
  * ) echo "Ungültige Eingabe. Abbruch."; exit;;
esac

echo "Die Server .jar wurde erfolgreich installiert."

read -p "Wie viel GB RAM soll der Server verwenden? (2/4/6/8/16 GB): " ram_amount
case "$ram_amount" in
  2|4|6|8|16 ) ;;
  * ) echo "Ungültige Eingabe. Abbruch."; exit;;
esac

echo "screen -S minecraftserver java -Xms${ram_amount}G -Xmx${ram_amount}G -jar paper.jar" > start.sh
sudo apt install screen -y
chmod +x start.sh

echo "Dein Server wurde erfolgreich eingerichtet!"
echo "Beachte, dass du die eula.txt noch akzeptieren musst!"
echo "Erledige dies einfach mit 'nano eula.txt'."
echo "Deinen Server kannst du übrigens mit './start.sh' starten!"
./start.sh
