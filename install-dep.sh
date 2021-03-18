#!/bin/bash
# Install dependencies

function copy_binary() {
  if [[ ":$PATH:" == *":$HOME/.local/bin:"* ]]; then
      if [ ! -d "$HOME/.local/bin" ]; then
        mkdir -p "$HOME/.local/bin"
      fi
      mv tilt "$HOME/.local/bin/tilt"
  else
      echo "Installing Tilt to /usr/local/bin which is write protected"
      echo "If you'd prefer to install Tilt without sudo permissions, add \$HOME/.local/bin to your \$PATH and rerun the installer"
      sudo mv tilt /usr/local/bin/tilt
  fi
}


function kubermachines_install() {
  if [[ "$OSTYPE" == "linux"* ]]; then
          set -x
	  echo "****** Installing Docker  *******"
	  curl -fsSL https://get.docker.com -o get-docker.sh
          sh get-docker.sh
          rm -r get-docker.sh
          echo "****** Installing Kubectl ******"
          curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
	  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
          echo "****** Installing Tilt ******"
          curl -fsSL https://github.com/tilt-dev/tilt/releases/download/v$VERSION/tilt.$VERSION.linux.x86_64.tar.gz | tar -xzv tilt
          copy_binary

  elif [[ "$OSTYPE" == "darwin"* ]]; then
          set -x
	  echo "****** Installing Docker ******"
	  set -e
          EXIT_CODE=0
          brew install docker || EXIT_CODE=$?
          echo $EXIT_CODE
          echo "****** Installing Kubectl ******"
          curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/darwin/amd64/kubectl
          chmod +x ./kubectl
          sudo mv ./kubectl /usr/local/bin/kubectl
          echo "Installing Tilt *******"
          curl -fsSL https://github.com/tilt-dev/tilt/releases/download/v$VERSION/tilt.$VERSION.mac.x86_64.tar.gz | tar -xzv tilt
          copy_binary

  else

      set +x
      echo "The Kubermachines installer does not work for your platform: $OSTYPE"
      echo "For other installation options, check the following page:"
      echo "https://docs.tilt.dev/install.html#alternative-installations"
      echo "Thank you!"
      exit 1
  fi

  set +x
}

# so that we can skip installation in CI and just test the version check
if [[ -z $NO_INSTALL ]]; then
  kubermachines_install
fi
version_check
tilt verify-install
