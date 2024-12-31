instr()
{
    case "$2" in
       *"$1"*)
          return 0
       ;;
    esac
    return 1
}

readpwd()
{
    # Disable echo.
    stty -echo

    # Set up trap to ensure echo is enabled before exiting if the script
    # is terminated while echo is disabled.
    trap 'stty echo' EXIT

    # Read secret.
    read "$@"

    # Enable echo.
    stty echo
    trap - EXIT

    # Print a newline because the newline entered by the user after
    # entering the passcode is not echoed. This ensures that the
    # next line of output begins at a new line.
    echo
}


# <<- ignores initial tabs
append-path-in-profile()
{
cat <<- EOF | tee -a $HOME/.profile

# set PATH so it includes snap bin
if [ -d "$1" ]; then
 PATH="\$PATH:$1"
fi

EOF
}
