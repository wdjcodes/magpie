#!/bin/zsh

if [[ ${ZSH_CUSTOM:-1} == "1" ]]; then
    echo "Could not find Oh My Zsh installation directory. Is it installed?"
    exit 1
fi

theme_dir=$ZSH_CUSTOM/themes
theme_url=https://raw.githubusercontent.com/wdjcodes/magpie/master/magpie.zsh-theme

echo "Downloading theme..."
curl -fsSLo $theme_dir/magpie.zsh-theme $theme_url && chmod 660 $theme_dir/magpie.zsh-theme

echo "Configuring theme in .zshrc...";
if [[ `grep -e '^ZSH_THEME' ~/.zshrc | wc -l` -ne "1" ]]; then
    echo ZSH_THEME="magpie" >> ~/.zshrc;
else
    sed ~/.zshrc -i -e 's/ZSH_THEME="[.a-z0-9\-]*"/ZSH_THEME="magpie"/g';
fi