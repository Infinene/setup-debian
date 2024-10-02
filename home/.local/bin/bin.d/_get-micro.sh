echo
echo "Updating micro editor..."

repo="zyedidia/micro"

setup_alternatives () {
  if command -v micro &> /dev/null; then
    micro_dir=$(dirname $(which micro))
    if ! update-alternatives --list editor | grep "micro" >/dev/null; then
      ${SUDO} update-alternatives --set editor ${micro_dir}/micro
    else
      ${SUDO} update-alternatives --install /usr/bin/editor editor ${micro_dir}/micro 50
    fi
  fi
}

${SUDO} eget --to=/usr/local/bin --upgrade-only zyedidia/micro
setup_alternatives

printf "Press enter to continue "
read key
