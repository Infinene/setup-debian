printf '%s\n'
printf '%s\n' "Updating yazi..."

if command -v lf &> /dev/null
then
  cur_version="$(yazi -V | grep -Eo '[0-9]+\.[0-9]+(\.[0-9]+)?')"
else
  cur_version="0.0"
fi

repo="sxyazi/yazi"
file="yazi-x86_64-unknown-linux-gnu.zip"
new_version="$(github_latest_release $repo | grep -Eo '[0-9]+\.[0-9]+(\.[0-9]+)?')"

if [ "$cur_version" = "${new_version}" ]; then
    printf '%s\n' "Already at latest version: lf $cur_version"
else
		printf '%s\n' "Updating yazi to version ${new_version}"
    # get the package
    wget https://github.com/${repo}/releases/download/v${new_version}/$file
    unzip $file
    ydir="$(basename $file .zip)"
    sudo cp $ydir/ya* /usr/local/bin/
    sudo cp $ydir/completions/*.bash /etc/bash_completion.d/
    rm -r ${ydir}*
fi
