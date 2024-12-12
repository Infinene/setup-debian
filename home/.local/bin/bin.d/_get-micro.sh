echo
echo "Updating micro editor..."

repo="zyedidia/micro"

set_default_editor () {
  if command -v micro &> /dev/null; then
    micro_dir=$(dirname $(which micro))
    if ! update-alternatives --list editor | grep "micro" >/dev/null; then
      ${SUDO} update-alternatives --install /usr/bin/editor editor ${micro_dir}/micro 50
    else
      ${SUDO} update-alternatives --set editor ${micro_dir}/micro
    fi
  fi
}

${SUDO} eget --to=/usr/local/bin --upgrade-only zyedidia/micro
set_default_editor

printf "Press enter to continue "
read key
