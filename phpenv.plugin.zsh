FOUND_PHPENV=0
phpenvdirs=("$HOME/.phpenv" "$HOME/.local/phpenv" "/usr/local/opt/phpenv" "/usr/local/phpenv" "/opt/phpenv")

for phpenvdir in "${phpenvdirs[@]}" ; do
  if [ -d $phpenvdir/bin -a $FOUND_PHPENV -eq 0 ] ; then
    FOUND_PHPENV=1
    if [[ $PHPENV_ROOT = '' ]]; then
      PHPENV_ROOT=$phpenvdir
    fi
    export PHPENV_ROOT
    export PATH=${phpenvdir}/bin:$PATH
    eval "$(phpenv init --no-rehash -)"

    function current_php() {
      echo "$(phpenv version-name)"
    }

    function phpenv_prompt_info() {
      echo "$(current_php)"
    }
  fi
done
unset phpenvdir

if [ $FOUND_PHPENV -eq 0 ] ; then
  function phpenv_prompt_info() { echo "system: $(php --version)" }
fi
