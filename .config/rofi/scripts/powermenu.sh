#!/bin/bash
# Iconos Nerd Font generados con printf (no se corrompen al pegar)
i_lock=$(printf '\uf023')
i_sleep=$(printf '\uf186')
i_logout=$(printf '\uf08b')
i_reboot=$(printf '\uf021')
i_power=$(printf '\uf011')
i_yes=$(printf '\uf00c')
i_no=$(printf '\uf00d')

estilo='window { width: 320px; } listview { columns: 1; lines: 5; } element-icon { enabled: false; }'

confirmar() {
  respuesta=$(printf '%s  No\n%s  Sí\n' "$i_no" "$i_yes" | rofi -dmenu -i -p "$1" -theme-str "$estilo listview { lines: 2; }")
  [[ "$respuesta" == *Sí* ]]
}

eleccion=$(printf '%s  Bloquear\n%s  Suspender\n%s  Cerrar sesión\n%s  Reiniciar\n%s  Apagar\n' \
  "$i_lock" "$i_sleep" "$i_logout" "$i_reboot" "$i_power" \
  | rofi -dmenu -i -p "Energía" -theme-str "$estilo")

case "$eleccion" in
  *Bloquear*)        hyprlock ;;
  *Suspender*)       systemctl suspend ;;
  *"Cerrar sesión"*) confirmar "¿Cerrar sesión?" && loginctl terminate-user "$USER" ;;
  *Reiniciar*)       confirmar "¿Reiniciar?" && systemctl reboot ;;
  *Apagar*)          confirmar "¿Apagar?" && systemctl poweroff ;;
esac
