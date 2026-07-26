# shellcheck shell=bash
# Utility commands for Google Cloud Platform development.

#==============================================#
# Google Cloud tools
#==============================================#
alias gcloud_docs="open 'https://cloud.google.com/sdk/docs/install'"
alias gcloud_auth_docs="open 'https://cloud.google.com/sdk/docs/authorizing'"
alias gcloud_gke_docs="open 'https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-access-for-kubectl'"

# shellcheck disable=SC2312
gcloud_tools() {
  beginf
  echo 'Google Cloud Platform provides cloud infrastructure, data, and AI services.'
  echo '① Google Cloud SDK: command-line tools to manage GCP resources from the terminal'
  echo '② gcloud CLI: manage projects, compute, storage, IAM, and other services'
  echo '③ gcloud storage: recommended Cloud Storage CLI; use this instead of gsutil'
  echo '④ kubectl + gcloud kubectl: work with GKE clusters'
  echo 'Note: gsutil is a legacy, minimally maintained tool and is no longer the recommended choice.'
  endf
}

gcloud_storage() {
  if command -v gcloud >/dev/null 2>&1; then
    gcloud storage "$@"
  else
    echo 'gcloud CLI is not installed yet. Run gcloud_setup or visit the docs.'
  fi
}

gcloud_auth() {
  if command -v gcloud >/dev/null 2>&1; then
    gcloud auth login
  else
    echo 'gcloud CLI is not installed yet. Run gcloud_setup or visit the docs.'
  fi
}

gcloud_show_config() {
  if command -v gcloud >/dev/null 2>&1; then
    gcloud config configurations list
  else
    echo 'gcloud CLI is not installed yet. Run gcloud_setup or visit the docs.'
  fi
}

gcloud_switch_project() {
  if command -v gcloud >/dev/null 2>&1; then
    if [[ -n "$1" ]]; then
      gcloud config set project "$1"
      echo "Switched active project to $1"
    else
      echo 'Usage: gcloud_switch_project PROJECT_ID'
    fi
  else
    echo 'gcloud CLI is not installed yet. Run gcloud_setup or visit the docs.'
  fi
}

gcloud_activate_config() {
  if command -v gcloud >/dev/null 2>&1; then
    if [[ -n "$1" ]]; then
      gcloud config configurations activate "$1"
      echo "Activated gcloud configuration: $1"
    else
      echo 'Usage: gcloud_activate_config CONFIG_NAME'
    fi
  else
    echo 'gcloud CLI is not installed yet. Run gcloud_setup or visit the docs.'
  fi
}

gcloud_kubectl() {
  if command -v gcloud >/dev/null 2>&1; then
    gcloud components install kubectl
  else
    echo 'gcloud CLI is not installed yet. Run gcloud_setup or visit the docs.'
  fi
}

gcloud_setup() {
  beginf
  readonly supported_tools='(1) Open Google Cloud SDK docs, (2) Install kubectl, (3) Login to gcloud, (0) Show help'
  echo "Which tool do you want to use: ${supported_tools}?"
  read -r -p ">> input your tool 1|2|3|0: " name

  case "${name}" in
    1)
      gcloud_docs
      ;;
    2)
      gcloud_kubectl
      ;;
    3)
      gcloud_auth
      ;;
    0)
      gcloud_tools
      ;;
    *)
      echo "Your input must be ${supported_tools}"
      ;;
  esac
  endf
}

gcloud_help() {
  beginf
  echo '$ gcloud_tools: overview common Google Cloud tools'
  echo '$ gcloud_setup: guide to install or configure Google Cloud tools'
  echo '$ gcloud_auth: authenticate with the gcloud CLI'
  echo '$ gcloud_show_config: list all named gcloud configurations'
  echo '$ gcloud_switch_project PROJECT_ID: switch the active GCP project'
  echo '$ gcloud_activate_config CONFIG_NAME: activate a named gcloud configuration that can hold both project and account'
  echo '$ gcloud_kubectl: install kubectl support through gcloud'
  echo '$ gcloud_storage [ARGS]: run gcloud storage commands (recommended over gsutil)'
  echo '$ gcloud_docs: open the Google Cloud SDK installation docs'
  endf
}
