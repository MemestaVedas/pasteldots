#!/usr/bin/zsh
url=$(playerctl metadata mpris:artUrl)
artist=$(playerctl metadata xesam:artist)
title=$(playerctl metadata xesam:title)
metadata=$(printf "$artist - $title")

if [ "$url" = "No player found" ]; then
  echo "No player found"
  exit
elif [ -f "/home/mv/.cache/albumart/$metadata.png" ]; then
  image_path="/home/mv/.cache/albumart/$metadata.png"
else
  curl -s "$url" -o "/home/mv/.cache/albumart/$metadata"
  magick "/home/mv/.cache/albumart/$metadata" "/home/mv/.cache/albumart/$metadata.png"
  rm "/home/mv/.cache/albumart/$metadata"
  image_path="/home/mv/.cache/albumart/$metadata.png"
fi

# Generate CSS file
cat <<EOF > ~/.config/waybar/music.css
#custom-music.Playing {
  background-image: url('$image_path');
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
}
EOF