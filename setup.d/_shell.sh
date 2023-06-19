${SUDO} apt update
${SUDO} apt install lsb-release

### backports ###
grep -e "^deb.*backports" /etc/apt/sources.list >/dev/null || \
  printf "\ndeb http://deb.debian.org/debian ${debian_release}-backports main contrib non-free\n" \
    | ${SUDO} tee -a /etc/apt/sources.list
printf "Package: *\nPin: release a=${debian_release}-backports\nPin-Priority: 500\n" \
    | ${SUDO} tee /etc/apt/preferences.d/backports

${SUDO} apt update
${SUDO} apt full-upgrade
### required by php-mysql-nginx ###
${SUDO} apt install apt-transport-https ca-certificates curl wget software-properties-common dirmngr gnupg2 debian-archive-keyring sudo rsync
### extras ###
${SUDO} apt install zstd unzip ncdu htop mmv neofetch git autojump tmux ncal

### bash setup ###
printf "EDITOR=micro\nVISUAL=micro\n" | ${SUDO} tee -a /etc/environment
[[ $is_wsl ]] && ${SUDO} cp $setup_dir/etc/wsl.conf /etc/

cat $setup_dir/home/.config/bash/prompt | sed 's/34/35/g' | ${SUDO} tee -a /root/.bashrc
if [ ! $UID = 0 ]; then
    # cp -rTv $setup_dir/home $HOME
    cp -rv $setup_dir/home/. $HOME
    cat ~/.config/bash/prompt | tee -a $HOME/.bashrc
    printf ". ~/.config/bash/utils_env\n" | tee -a $HOME/.bashrc
    printf ". /usr/share/autojump/autojump.bash\n" | tee -a $HOME/.bashrc
    printf "if [ -f /usr/bin/neofetch ]; then\n  neofetch;\nfi\n" | tee -a $HOME/.bashrc
    cd $HOME
    ln -s .config/bash/aliases .bash_aliases
    printf "Defaults:${USER} timestamp_timeout=90\n" | ${SUDO} tee -a /etc/sudoers
    [[ $is_wsl ]] && printf "${USER} ALL=(ALL) NOPASSWD:/usr/sbin/service\n" | ${SUDO} tee -a /etc/sudoers
fi

printf "\nInstalling utils...\n" 
$HOME/.local/bin/update_utils
${SUDO} cp -rbv $setup_dir/etc/lf /etc/
