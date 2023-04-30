#!/usr/bin/env bash
set -euo pipefail
# Do nothing script inspired by a blog from Dan Slimmon
# https://blog.danslimmon.com/2019/07/15/do-nothing-scripting-the-key-to-gradual-automation/
# This prints out all the steps necessary to setup my local environment in the way I prefer with
# the intention of automating each step in the future.

echoerr() { echo "$@" 1>&2; }
fatal() { echoerr "$@"; exit 1; }
badopt() { echoerr "$@"; help='true'; }
opt() { if [[ -z ${2-} ]]; then badopt "$1 flag must be followed by an argument"; fi; export $1="$2"; }
required_args() { for arg in $@; do if [[ -z "${!arg-}" ]]; then badopt "$arg is a required argument"; fi; done; }

status() {
    if command -v git &> /dev/null
    then
        echo "  [X] Git Configured"
    else
        echo "  [ ] Git Configured"
    fi

    if command -v code &> /dev/null
    then
        echo "  [X] VSCode Configured"
    else
        echo "  [ ] VSCode Configured"
    fi

    if dpkg --verify fonts-firacode &>/dev/null
    then
        echo "  [X] Firacode Configured"
    else
        echo "  [ ] Firacode Configured"
    fi

    if command -v notepadqq &> /dev/null
    then
        echo "  [X] NotepadQQ Configured"
    else
        echo "  [ ] NotepadQQ Configured"
    fi

    if command -v go &> /dev/null
    then
        echo "  [X] Golang Configured"
    else
        echo "  [ ] Golang Configured"
    fi

    if command -v gh &> /dev/null
    then
        echo "  [X] GH CLI Configured"
    else
        echo "  [ ] GH CLI Configured"
    fi

    if command -v kubectl &> /dev/null
    then
        echo "  [X] Kubectl Configured"
    else
        echo "  [ ] Kubectl Configured"
    fi

    if command -v helm &> /dev/null
    then
        echo "  [X] Helm Configured"
    else
        echo "  [ ] Helm Configured"
    fi

    if command -v terraform &> /dev/null
    then
        echo "  [X] Terraform Configured"
    else
        echo "  [ ] Terraform Configured"
    fi

    if command -v docker &> /dev/null
    then
        echo "  [X] Docker Configured"
    else
        echo "  [ ] Docker Configured"
    fi

    if command -v age &> /dev/null
    then
        echo "  [X] Age Configured"
    else
        echo "  [ ] Age Configured"
    fi

    if command -v sops &> /dev/null
    then
        echo "  [X] SOPS Configured"
    else
        echo "  [ ] SOPS Configured"
    fi

    if command -v kind &> /dev/null
    then
        echo "  [X] Kind Configured"
    else
        echo "  [ ] Kind Configured"
    fi

    if command -v talosctl &> /dev/null
    then
        echo "  [X] Talos Configured"
    else
        echo "  [ ] Talos Configured"
    fi

    if command -v task &> /dev/null
    then
        echo "  [X] Task configured"
    else
        echo "  [ ] Task Configured"
    fi

    if [ -n "${BASH_HELPERS-}" ] &>/dev/null
    then
        echo "  [X] Bash configured"
    else
        echo "  [ ] Bash Configured"
    fi
}

ending() {
    echo "  Do-Nothing Script Finished"
}

while [[ $# -gt 0 ]]; do
    arg="$1"
    case $arg in
        --dryrun|-d) opt dryrun true; shift;;
        --skipapt|-s) opt skipapt true; shift;;
        --help|-h) opt help true; shift;;
        *) shift;;
    esac
done

if [[ -n ${help-} ]]; then
    echoerr "Usage: $0"
    echoerr "    -d | --dryrun     : Check existing configuration without doing any installs"
    echoerr "    -s | --skipapt    : Skip running apt/apt-get update/upgrades"
    echoerr "    -h | --help       : Script help"
    exit 1
fi

#echo "  Do-Nothing Script Started"
#status
#if ! status | grep -q "\[\s\]"; then
#  echo "  Nothing to do, all tools installed"
#  exit 1
#fi


if [[ -n ${dryrun-} ]]; then
    ending
    exit 1
fi

if [[ ! -n ${skipapt-} ]]; then
    echo ""
    echo "  Running apt update and apt upgrade"
    sudo apt -qq update
    sudo apt-get update
    sudo apt -qq install ca-certificates software-properties-common apt-transport-https
    sudo add-apt-repository universe
    sudo apt upgrade
    echo ""
    echo ""
fi

if ! command -v git &> /dev/null
then
    echo "  Git Installation"
    echo "  Documentation: https://git-scm.com/download/linux"
    echo "  Install git with the following commands"
    echo "      apt install git-all"
    echo "      git config --global url.ssh://git@github.com/.insteadOf https://github.com/"
    echo "      git config --global user.name \"\$GITHUB_USERNAME\" - Substitue \$GITHUB_USERNAME with actual username"
    echo "      git config --global user.email \"\$GITHUB_EMAIL\" - Substitue \$GITHUB_EMAIL with actual email"
    read -n 1 -s -r -p "  Press any key to continue"
    echo "  Add github SSH Key"
    echo "      Documentation: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account"
    echo "      Create Github SSH Key"
    echo "          ssh-keygen -t ed25519 -C \"\$GITHUB_EMAIL\" - Substitue \$GITHUB_EMAIL with actual email"
    echo "          eval \"\$(ssh-agent -s)\""
    echo "          ssh-add ~/.ssh/id_ed25519"
    echo "      Documentation: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account"
    echo "      Copy SSH Key to Github"
    echo "          cat ~/.ssh/id_ed25519.pub"
    echo "          Follow documentation to copy the key to Github"
    read -n 1 -s -r -p "  Press any key to continue"
    echo ""
fi

if ! command -v code &> /dev/null
then
    echo "  Install VSCode with the following commands"
    echo "      wget -O ~/Downloads/code.deb http://go.microsoft.com/fwlink/?LinkID=760868"
    echo "      sudo apt install ~/Downloads/code.deb"
    echo "      rm -rf ~/Downloads/code.deb"
    read -n 1 -s -r -p "  Press any key to continue"
    echo "  Add VSCode Extensions"
    echo "      Documentation: https://code.visualstudio.com/docs/editor/extension-marketplace#_command-line-extension-management"
    echo "      code --install-extension enkia.tokyo-night"
    echo "      code --install-extension golang.go"
    echo "      code --install-extension PKief.material-icon-theme"
    echo "      code --install-extension eamodio.gitlens"
    echo "      code --install-extension signageos.signageos-vscode-sops"
    read -n 1 -s -r -p "  Press any key to continue"
    echo "  Update VSCode User Settings"
    echo "      Documentation: https://code.visualstudio.com/docs/getstarted/settings#_changing-settingsjson"
    echo "      Update ~/.config/Code/User/settings.json"
    echo "          {"
    echo "             \"workbench.colorTheme\": \"Tokyo Night\","
    echo "             \"workbench.iconTheme\": \"material-icon-theme\","
    echo "             \"workbench.editor.untitled.hint\": \"hidden\","
    echo "             \"editor.fontFamily\": \"Fira Code\","
    echo "             \"editor.fontLigatures\": true,"
    echo "             \"editor.links\": false,"
    echo "             \"redhat.telemetry.enabled\": false,"
    echo "             \"security.workspace.trust.untrustedFiles\": \"open\","
    echo "             \"diffEditor.ignoreTrimWhitespace\": false,"
    echo "          }"
    read -n 1 -s -r -p "  Press any key to continue"
    echo ""
fi

if ! dpkg --verify fonts-firacode &>/dev/null
then
    echo "  FiraCode installation with the following commands"
    echo "      sudo apt install fonts-firacode"
    read -n 1 -s -r -p "  Press any key to continue"
    echo ""
fi

if ! command -v notepadqq &> /dev/null
then
    echo "  NotepadQQ Installation"
    echo "  Documentation: https://notepadqq.com/wp/download/"
    echo "  Install git with the following commands"
    echo "      sudo apt install notepadqq"
    read -n 1 -s -r -p "  Press any key to continue"
    echo ""
fi

if ! command -v go &> /dev/null
then
    echo "  Golang Installation"
    echo "  Documentation: https://go.dev/doc/install"
    echo "  Install Golang with the following commands"
    echo "      wget -O ~/Downloads/go1.19.4.linux-amd64.tar.gz https://go.dev/dl/go1.19.4.linux-amd64.tar.gz"
    echo "      sudo rm -rf /usr/local/go"
    echo "      sudo tar -C /usr/local -xzf ~/Downloads/go1.19.4.linux-amd64.tar.gz"
    echo "      rm -rf ~/Downloads/go1.19.4.linux-amd64.tar.gz"
    read -n 1 -s -r -p "  Press any key to continue"
    echo ""
fi

if ! command -v gh &> /dev/null
then
    echo "  Github CLI Installation"
    echo "  Documentation: https://github.com/cli/cli/blob/trunk/docs/install_linux.md"
    echo "  Install gh with the following commands"
    echo "      curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg"
    echo "      sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg"
    echo "      echo \"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main\" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null"
    echo "      sudo apt update"
    echo "      sudo apt install gh"
    read -n 1 -s -r -p "  Press any key to continue"
    echo ""
fi

if ! command -v kubectl &> /dev/null
then
    echo "  Kubectl Installation"
    echo "  Documentation: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-using-native-package-management"
    echo "  Install Kubectl with the following commands"
    echo "      sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg"
    echo "      echo \"deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main\" | sudo tee /etc/apt/sources.list.d/kubernetes.list"
    echo "      sudo apt-get update"
    echo "      sudo apt-get install -y kubectl"
    read -n 1 -s -r -p "  Press any key to continue"
    echo ""
fi

if ! command -v helm &> /dev/null
then
    echo "  Helm Installation"
    echo "  Documentation: https://helm.sh/docs/intro/install/#from-script"
    echo "  Install Helm with the following commands"
    echo "      curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null"
    echo "      sudo apt-get install apt-transport-https --yes"
    echo "      echo \"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main\" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list"
    echo "      sudo apt-get update"
    echo "      sudo apt-get install helm"
    read -n 1 -s -r -p "  Press any key to continue"
    echo ""
fi

if ! command -v terraform &> /dev/null
then
    echo "  Terraform Installation"
    echo "  Documentation: https://learn.hashicorp.com/tutorials/terraform/install-cli"
    echo "  Install Terraform with the following commands"
    echo "      sudo apt-get update && sudo apt-get install -y gnupg software-properties-common"
    echo "      wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg"
                # Note jammy is hardcoded here instead of the command in the instructions since my linux version is mint and not base ubuntu, jammy is ubuntu base image
    echo "      echo \"deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com jammy main\" | sudo tee /etc/apt/sources.list.d/hashicorp.list"
    echo "      sudo apt-get update && sudo apt-get install terraform"
    read -n 1 -s -r -p "  Press any key to continue"
    echo ""
fi

if ! command -v docker &> /dev/null
then
    echo "  Docker Installation"
    echo "  Documentation: https://docs.docker.com/engine/install/debian/#install-docker-engine"
    echo "  Install Docker with the following commands"
    echo "      sudo apt update"
    echo "      sudo apt -y remove docker docker-engine docker.io containerd runc"
    echo "      sudo apt -y install apt-transport-https ca-certificates curl software-properties-common"
    echo "      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg"
                # Note jammy is hardcoded here instead of the command in the instructions since my linux version is mint and not base ubuntu, jammy is ubuntu base image
    echo "      echo \"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu jammy stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null"
    echo "      sudo apt-get update"
    echo "      sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin"
    read -n 1 -s -r -p "  Press any key to continue"
    echo "  Enable docker as non-root user"
    echo "      sudo groupadd docker"
    echo "      sudo usermod -aG docker $USER"
    echo "      Note: To run docker as non-root, you must restart machine"
    read -n 1 -s -r -p "  Press any key to continue"
    echo ""
fi

if ! command -v age &> /dev/null
then
    echo "  Age Installation"
    echo "  Documentation: https://github.com/FiloSottile/age#installation"
    echo "  Install Age with the following commands"
    echo "      curl -Lo ~/Downloads/age-v1.0.0-linux-amd64.tar.gz https://github.com/FiloSottile/age/releases/download/v1.0.0/age-v1.0.0-linux-amd64.tar.gz"
    echo "      tar -zxvf ~/Downloads/age-v1.0.0-linux-amd64.tar.gz --directory ~/Downloads"
    echo "      sudo mv ~/Downloads/age/age /usr/local/bin/age"
    echo "      sudo mv ~/Downloads/age/age-keygen /usr/local/bin/age-keygen"
    echo "      sudo chmod +x /usr/local/bin/age"
    echo "      sudo chmod +x /usr/local/bin/age-keygen"
    echo "      rm -rf ~/Downloads/age"
    echo "      rm -rf ~/Downloads/age-v1.0.0-linux-amd64.tar.gz"
    read -n 1 -s -r -p "  Press any key to continue"
    echo ""
fi

if ! command -v sops &> /dev/null
then
    echo "  SOPS Installation"
    echo "  Documentation: https://github.com/mozilla/sops#11stable-release"
    echo "  Install SOPS with the following commands"
    echo "      sudo curl -Lo /usr/local/bin/sops https://github.com/mozilla/sops/releases/download/v3.7.3/sops-v3.7.3.linux.amd64"
    echo "      sudo chmod +x /usr/local/bin/sops"
    read -n 1 -s -r -p "  Press any key to continue"
    echo ""
fi

if ! command -v kind &> /dev/null
then
    echo "  Kind Installation"
    echo "  Documentation: https://kind.sigs.k8s.io/docs/user/quick-start/#installing-from-release-binaries"
    echo "  Install Kind with the following commands"
    echo "      sudo curl -Lo /usr/local/bin/kind https://kind.sigs.k8s.io/dl/v0.18.0/kind-linux-amd64"
    echo "      sudo chmod +x /usr/local/bin/kind"
    read -n 1 -s -r -p "  Press any key to continue"
    echo ""
fi

if ! command -v talosctl &> /dev/null
then
    echo "  Talos Installation"
    echo "  Documentation: https://www.talos.dev/v1.0/introduction/getting-started/"
    echo "  Install Talos with the following commands"
    echo "      sudo curl -Lo /usr/local/bin/talosctl https://github.com/siderolabs/talos/releases/download/v1.4.1/talosctl-\$(uname -s | tr \"[:upper:]\" \"[:lower:]\")-amd64"
    echo "      sudo chmod +x /usr/local/bin/talosctl"
    read -n 1 -s -r -p "  Press any key to continue"
fi

if ! command -v task &> /dev/null
then
    echo "  Install Task with the following commands"
    echo "      wget -O ~/Downloads/task.deb https://github.com/go-task/task/releases/download/v3.24.0/task_linux_amd64.deb"
    echo "      sudo apt install ~/Downloads/task.deb"
    echo "      rm -rf ~/Downloads/task.deb"
    read -n 1 -s -r -p "  Press any key to continue"
fi

if [ -z "${BASH_HELPERS-}" ] &>/dev/null
then
    echo "  Custom Bash Configuration"
    echo "  Update .bashrc file to source the files in this repo's bash directory"
    echo "      export BASH_HELPERS=\$DIR_TO_THIS_REPO/bash/*"
    echo "      for file in \$BASH_HELPERS; do . \$file; done"
    read -n 1 -s -r -p "  Press any key to continue"
fi

echo ""
status
ending
