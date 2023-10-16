#!/bin/zsh

if [[ ${ZSH_CUSTOM:-1} == "1" ]]; then
    echo "Could not find Oh My Zsh installation directory. Is it installed?"
    exit 1
fi

theme_name=magpie
theme_dir=$ZSH_CUSTOM/themes

echo "Downloading theme..."
curl -fsSLOo $theme_dir/

echo "Configuring theme in .zshrc...";
if [[ `grep -e '^ZSH_THEME' ~/.zshrc | wc -l` -ne "1" ]]; then
    echo ZSH_THEME="magpie" >> ~/.zshrc;
else
    sed ~/.zshrc -i -e 's/ZSH_THEME="[.a-z0-9\-]*"/ZSH_THEME="magpie"/g';
fi