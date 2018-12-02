#!/bin/sh

game="svencoop"
config="example"
port=27015
players=12
map="_server_start"

dirGame="/home/gameservers/svends"
dirConfig"${szGameDir}/${szGame}/servers/${szConfig}"

cd $dirGame
printf "Launching SvenDS with the \"${config}\" configuration set...\n"
./svends_run -console -autoupdate -game $game -port $port -noipx +maxplayers $players +servercfgfile "servers/${config}/server.cfg" +logsdir "servers/${config}/logs" +log on +map $map
printf "\nSvenDS has closed.\n"
cd $dirConfig
exit 0
