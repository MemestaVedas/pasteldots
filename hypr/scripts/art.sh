#!/usr/bin/zsh
url=$(playerctl metadata mpris:artUrl)
artist=$(playerctl metadata xesam:artist)
title=$(playerctl metadata xesam:title)
metadata=$(printf "$artist - $title")

if [ $url = "No player found" ]
then
  exit
elif [ -f /home/mv/.cache/albumart/"$metadata".png ]
then
  echo /home/mv/.cache/albumart/"$metadata".png
else
  curl -s $url -o /home/mv/.cache/albumart/"$metadata"
  magick /home/mv/.cache/albumart/"$metadata" /home/mv/.cache/albumart/"$metadata".png
  rm /home/mv/.cache/albumart/"$metadata"
  echo /home/mv/.cache/albumart/"$metadata".png
fi
