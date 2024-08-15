#!/bin/bash
set -e

MAX_PODS_CALCULATOR_URL="https://raw.githubusercontent.com/awslabs/amazon-eks-ami/master/templates/al2/runtime/max-pods-calculator.sh"

# Function to install jq on macOS using Homebrew
install_jq_mac() {
  if ! command -v brew &>/dev/null; then
    echo "Homebrew not found. Installing Homebrew..." >&2
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" >&2
  fi
  echo "Installing jq using Homebrew..." >&2
  brew install jq >&2
}

# Function to install jq on Debian-based Linux using apt-get
install_jq_linux() {
  echo "Updating package list and installing jq..." >&2
  sudo apt-get update -y >&2
  sudo apt-get install -y jq >&2
}

# Function to check for jq and install if not present
install_jq() {
  if ! command -v jq &>/dev/null; then
    echo "jq not found. Installing jq..." >&2
    if [[ "$OSTYPE" == "darwin"* ]]; then
      install_jq_mac
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
      if command -v apt-get &>/dev/null; then
        install_jq_linux
      else
        echo "Unsupported package manager. Please install jq manually." >&2
        exit 1
      fi
    else
      echo "Unsupported OS. Please install jq manually." >&2
      exit 1
    fi
  else
    echo "jq is already installed." >&2
  fi
}

# Function to download max-pods-calculator script
download_max_pods_calculator() {
  curl -O "${MAX_PODS_CALCULATOR_URL}" >&2
}

# Ensure jq is installed
install_jq

# Download max-pods-calculator script
download_max_pods_calculator

# Main script logic using jq
INSTANCE_TYPE=$(cat | jq -r .instance_type)
chmod +x max-pods-calculator.sh
RESULT=$(./max-pods-calculator.sh --instance-type "${INSTANCE_TYPE}" --cni-version 1.9.0-eksbuild.1)
# Send JSON output as the final output
jq -n --arg instance_type "$INSTANCE_TYPE" --arg result "$RESULT" '{"max_pods": $result}'