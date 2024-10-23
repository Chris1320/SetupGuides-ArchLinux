#!/usr/bin/env bash

rofimoji_emoji_command="rofimoji \
    --action copy \
    --clipboarder wl-copy"

rofimoji_math_command="$rofimoji_emoji_command --files math"
rofimoji_math_ops_command="$rofimoji_emoji_command --files mathematical_operators"
rofimoji_nums_command="$rofimoji_emoji_command --files number_forms"
rofimoji_currency_command="$rofimoji_emoji_command --files currency_symbols"
rofimoji_supnsub_command="$rofimoji_emoji_command --files superscripts_and_subscripts"
rofimoji_arrows_command="$rofimoji_emoji_command --files arrows"
rofimoji_blocks_command="$rofimoji_emoji_command --files block_elements"
rofimoji_box_command="$rofimoji_emoji_command --files box_drawing"
rofimoji_misc_command="$rofimoji_emoji_command --files miscellaneous_symbols"

# modes
m1="emoji:$rofimoji_emoji_command"
m2="math:$rofimoji_math_command"
m3="mathops:$rofimoji_math_ops_command"
m4="nums:$rofimoji_nums_command"
m5="currency:$rofimoji_currency_command"
m6="supnsub:$rofimoji_supnsub_command"
m7="arrows:$rofimoji_arrows_command"
m8="blocks:$rofimoji_blocks_command"
m9="box:$rofimoji_box_command"
m10="misc:$rofimoji_misc_command"

rofi \
    -modes "$m1,$m2,$m3,$m4,$m5,$m6,$m7,$m8,$m9,$m10" \
    -show "emoji" \
    -scroll-method 1 \
    -i \
    -theme "$HOME/.config/rofi/config/rofimoji.rasi"
