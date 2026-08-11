# shellcheck shell=bash
# Utility commands for Microsoft Azure development.

#==============================================#
# Azure tools
#==============================================#
alias az_docs="open 'https://learn.microsoft.com/cli/azure/install-azure-cli'"
alias az_config_docs="open 'https://learn.microsoft.com/cli/azure/manage-azure-cli-configuration'"

azure_tools() {
  beginf
  echo 'Microsoft Azure provides cloud infrastructure, platform, and data services.'
  echo '① Azure CLI: command-line tools to manage Azure resources from the terminal'
  echo '② Subscriptions: switch between subscriptions and tenants with the CLI'
  echo '③ Resource Groups & Storage: manage resources and storage accounts'
  echo '④ AKS / App Services: helpers for container and app hosting on Azure'
  endf
}

azure_profile_active() {
  if command -v az >/dev/null 2>&1; then
    az account show --output table 2>/dev/null || az configure --list-defaults 2>/dev/null || true
  else
    echo 'Azure CLI is not installed yet. Run azure_setup or visit the docs.'
  fi
}

azure_profile_list() {
  if command -v az >/dev/null 2>&1; then
    # List subscriptions (analogous to profiles in some workflows)
    az account list --output table 2>/dev/null || true
  else
    echo 'Azure CLI is not installed yet. Run azure_setup or visit the docs.'
  fi
}

azure_profile_view() {
  if command -v az >/dev/null 2>&1; then
    if [[ -n "$1" ]]; then
      echo "Here is the info of subscription $1"
      az account show --subscription "$1" --output table 2>/dev/null || true
    else
      echo 'Usage: azure_profile_view SUBSCRIPTION_NAME_OR_ID'
    fi
  else
    echo 'Azure CLI is not installed yet. Run azure_setup or visit the docs.'
  fi
}

azure_profile_switch() {
  if command -v az >/dev/null 2>&1; then
    if [[ -n "$1" ]]; then
      az account set --subscription "$1" 2>/dev/null && export AZURE_SUBSCRIPTION="$1"
      echo "Switched active Azure subscription to $1"
    else
      echo 'Usage: azure_profile_switch SUBSCRIPTION_ID_OR_NAME'
    fi
  else
    echo 'Azure CLI is not installed yet. Run azure_setup or visit the docs.'
  fi
}

azure_login() {
  if command -v az >/dev/null 2>&1; then
    az login 2>/dev/null || echo 'Interactive login failed; run az login manually to authenticate.'
  else
    echo 'Azure CLI is not installed yet. Run azure_setup or visit the docs.'
  fi
}

azure_setup() {
  beginf
  readonly supported_tools='(1) Open Azure CLI docs, (2) Login to Azure, (3) Show current Azure config, (4) List subscriptions, (0) Show help'
  echo "Which tool do you want to use: ${supported_tools}?"
  read -r -p ">> input your tool 1|2|3|4|0: " name

  case "${name}" in
    1)
      az_docs
      ;;
    2)
      azure_login
      ;;
    3)
      azure_profile_active
      ;;
    4)
      azure_profile_list
      ;;
    0)
      azure_tools
      ;;
    *)
      echo "Your input must be ${supported_tools}"
      ;;
  esac
  endf
}

azure_help() {
  beginf
  echo '$ azure_tools: overview common Azure tools'
  echo '$ azure_setup: guide to install or configure Azure CLI tools'
  echo '$ azure_login: authenticate or configure Azure CLI access'
  echo '$ azure_profile_active: show currently active Azure subscription'
  echo '$ azure_profile_list: list available Azure subscriptions (like profiles)'
  echo '$ azure_profile_view SUBSCRIPTION: view subscription info'
  echo '$ azure_profile_switch SUBSCRIPTION: switch the active Azure subscription'
  echo '$ az_docs: open the Azure CLI installation docs'
  endf
}
