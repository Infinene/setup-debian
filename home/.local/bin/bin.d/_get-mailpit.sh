printf '%s\n'
printf '%s\n' "Updating mailpit..."

repo="axllent/mailpit"


# new_version=$(github_latest_release $repo)
# if command -v mailpit &> /dev/null; then
#   cur_version="$(mailpit version | grep -Eo "v[0-9]+\.[0-9]+(\.[0-9]+)?")"
# else
#   cur_version="0.0"
# fi
# if [ "${cur_version}" = "${new_version}" ]; then
#     printf '%s\n' "Already at latest version: mailpit $cur_version"
# else
  ${SUDO} eget --to=/usr/local/bin --upgrade-only $repo
# fi

printf "Press enter to continue "
read key
