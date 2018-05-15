#!/usr/bin/env bash

set -e;

if [[ "$r2g_skip_postinstall" == "yes" ]]; then
  echo "skipping r2g postinstall routine.";
  exit 0;
fi

export r2g_skip_postinstall="yes";

ores_registry_exec="@oresoftware/registry";

if [[ "$ores_registry_exec" == "yes" ]]; then
     r2g_exec="/Users/alexamil/WebstormProjects/oresoftware/registry";
fi

npmr_gray='\033[1;30m'
npmr_magenta='\033[1;35m'
npmr_cyan='\033[1;36m'
npmr_orange='\033[1;33m'
npmr_green='\033[1;32m'
npmr_no_color='\033[0m'

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
      cd "$HOME/.oresoftware/nodejs" && npm install --silent "$ores_registry_exec" 2> /dev/null || {

        echo "could not install npm in user home.";

      }
    )

} || {

   echo "could not create a 'nodejs' dir in $HOME/oresoftware directory."
}

# wait for background processes to finish
wait;


echo -e "${npmr_green}npm bash function was installed successfully.${npmr_no_color}";
echo -e "Add the following line to your .bashrc/.bash_profile files:";
echo -e "${npmr_cyan} source \"\$HOME/.oresoftware/shell.sh\"${npmr_no_color}";
echo " ";



