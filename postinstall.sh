#!/usr/bin/env bash

set -e;

if [[ "$r2g_skip_postinstall" == "yes" ]]; then
  echo "skipping r2g postinstall routine.";
  exit 0;
fi

export r2g_skip_postinstall="yes";

gmx_gray='\033[1;30m'
gmx_magenta='\033[1;35m'
gmx_cyan='\033[1;36m'
gmx_orange='\033[1;33m'
gmx_green='\033[1;32m'
gmx_no_color='\033[0m'

nm="$HOME/.oresoftware/nodejs/node_modules";

mkdir -p "$HOME/.oresoftware" && {

  (
    curl -H 'Cache-Control: no-cache' \
    "https://raw.githubusercontent.com/oresoftware/shell/master/shell.sh?$(date +%s)" \
    --output "$HOME/.oresoftware/shell.sh" 2> /dev/null || {
           echo "curl command failed to read shell.sh, now we should try wget..."
    }
  ) &

} || {

  echo "could not create '$HOME/.oresoftware'";
  exit 1;

}

mkdir -p "$HOME/.oresoftware/bash" && {
    cat npm.sh > "$HOME/.oresoftware/bash/npm.registry.sh" || {
      echo "could not copy npm shell file to user home.";
    }
}


mkdir -p "$nm" && {

    [ ! -f "$HOME/.oresoftware/nodejs/package.json" ]  && {
     (
        curl -H 'Cache-Control: no-cache' \
          "https://raw.githubusercontent.com/oresoftware/shell/master/assets/package.json?$(date +%s)" \
            --output "$HOME/.oresoftware/nodejs/package.json" 2> /dev/null || {
            echo "curl command failed to read package.json, now we should try wget..."
      }
     )
    }

    (
      cd "$HOME/.oresoftware/nodejs" && npm install --silent @oresoftware/registry 2> /dev/null || {

        echo "could not install npm in user home.";

      }
    )

} || {

   echo "could not create a 'nodejs' dir in $HOME/oresoftware directory."
}

# wait for background processes to finish
wait;


echo -e "${gmx_green}npm bash function was installed successfully.${gmx_no_color}";
echo -e "Add the following line to your .bashrc/.bash_profile files:";
echo -e "${gmx_cyan} source \"\$HOME/.oresoftware/shell.sh\"${gmx_no_color}";
echo " ";



