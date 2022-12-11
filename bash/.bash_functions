# Helper function to go to my personal working directory
function work() {
  cd $GOPATH/src/github.com/wheelerjl/${1-}
}
function __work {
  dirs=$(ls $GOPATH/src/github.com/wheelerjl)
  COMPREPLY=($(compgen -W "$dirs" "${COMP_WORDS[1]}"))
}
complete -F __work work

function prune() {
    git remote prune origin
    git branch --v | grep "\[gone\]" | awk '{print $1}' | xargs git branch -D
}

function gopher() {
  cyan=`tput setaf 14`
  beige=`tput setaf 215`
  white=`tput setaf 15`
  black=`tput setaf 0`
  reset=`tput sgr0`
  echo $"${cyan}      ´.-::::::-.´"
  echo $"${cyan}  .:-::::::::::::::-:."
  echo $"${cyan}  ´_::${white}:    ::    :${cyan}::_´"
  echo $"${cyan}   .:${white}( ^   :: ^   )${cyan}:."
  echo $"${cyan}   ´::${white}:   ${beige}(${black}..${beige})${white}   :${cyan}::."
  echo $"${cyan}   ´:::::::${white}UU${cyan}:::::::´"
  echo $"${cyan}   .::::::::::::::::."
  echo $"${beige}   O${cyan}::::::::::::::::${beige}O"
  echo $"${cyan}   -::::::::::::::::-"
  echo $"${cyan}   ´::::::::::::::::´"
  echo $"${cyan}    .::::::::::::::."
  echo $"${beige}      oO${cyan}:::::::${beige}Oo"
  echo "${reset}"
}
