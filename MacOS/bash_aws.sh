# shellcheck shell=bash
# Utility commands for Amazon Web Services development.

#==============================================#
# AWS tools
#==============================================#
alias aws_docs="open 'https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html'"
alias aws_config_docs="open 'https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html'"
alias aws_auth_docs="open 'https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-authentication.html'"

aws_tools() {
  beginf
  echo 'Amazon Web Services provides cloud infrastructure, compute, storage, and data services.'
  echo '① AWS CLI: command-line tools to manage AWS resources from the terminal'
  echo '② AWS profiles: separate named configurations for different accounts and roles'
  echo '③ AWS S3: manage objects and buckets with the AWS CLI'
  echo '④ AWS ECS / EKS helpers: work with container services and Kubernetes on AWS'
  endf
}

aws_profile_view() {
  if command -v aws >/dev/null 2>&1; then
    if [[ -n "$1" ]]; then
        echo "Here is the info of profile $1"
        aws configure list --profile "$1" 2>/dev/null
      else
        echo 'Usage: aws_profile_show PROFILE_NAME'
      fi
  else
    echo 'AWS CLI is not installed yet. Run aws_setup or visit the docs.'
  fi
}

aws_profile_active() {
  if command -v aws >/dev/null 2>&1; then
    # prefer explicit AWS_PROFILE env var, fall back to 'default'
    local profile
    profile="${AWS_PROFILE:-default}"
    echo "${profile}"
  else
    echo 'AWS CLI is not installed yet. Run aws_setup or visit the docs.'
  fi
}

aws_profile_list() {
  if command -v aws >/dev/null 2>&1; then
    aws configure list-profiles 2>/dev/null || true
  else
    echo 'AWS CLI is not installed yet. Run aws_setup or visit the docs.'
  fi
}

aws_profile_switch() {
  if command -v aws >/dev/null 2>&1; then
    if [[ -n "$1" ]]; then
      export AWS_PROFILE="$1"
      echo "Switched active AWS profile to $1"
    else
      echo 'Usage: aws_profile_switch PROFILE_NAME'
    fi
  else
    echo 'AWS CLI is not installed yet. Run aws_setup or visit the docs.'
  fi
}

aws_login() {
  if command -v aws >/dev/null 2>&1; then
    aws sso login 2>/dev/null || aws configure
  else
    echo 'AWS CLI is not installed yet. Run aws_setup or visit the docs.'
  fi
}

aws_sso_config() {
  if command -v aws >/dev/null 2>&1; then
    aws configure sso "$@"
  else
    echo 'AWS CLI is not installed yet. Run aws_setup or visit the docs.'
    return 1
  fi
}

aws_sso_login() {
  if [[ -z "$1" || -n "$2" ]]; then
    echo 'Usage: aws_sso_login PROFILE_NAME' >&2
    return 2
  fi

  if command -v aws >/dev/null 2>&1; then
    aws_profile_switch "$1" || return $?
    aws sso login --profile "$1"
  else
    echo 'AWS CLI is not installed yet. Run aws_setup or visit the docs.'
    return 1
  fi
}

aws_sso_logout() {
  if [[ -n "$2" ]]; then
    echo 'Usage: aws_sso_logout [PROFILE_NAME]' >&2
    return 2
  fi

  if command -v aws >/dev/null 2>&1; then
    if [[ -n "$1" ]]; then
      aws sso logout --profile "$1"
    else
      aws sso logout
    fi
  else
    echo 'AWS CLI is not installed yet. Run aws_setup or visit the docs.'
    return 1
  fi
}

aws_whoami() {
  if [[ -n "$2" ]]; then
    echo 'Usage: aws_whoami [PROFILE_NAME]' >&2
    return 2
  fi

  if command -v aws >/dev/null 2>&1; then
    if [[ -n "$1" ]]; then
      aws sts get-caller-identity --profile "$1"
    else
      aws sts get-caller-identity
    fi
  else
    echo 'AWS CLI is not installed yet. Run aws_setup or visit the docs.'
    return 1
  fi
}

aws_setup() {
  beginf
  readonly supported_tools='(1) Open AWS CLI docs, (2) Login to AWS, (3) Show current AWS config, (4) Show AWS profiles, (0) Show help'
  echo "Which tool do you want to use: ${supported_tools}?"
  read -r -p ">> input your tool 1|2|3|4|0: " name

  case "${name}" in
    1)
      aws_docs
      ;;
    2)
      aws_login
      ;;
    3)
      aws_profile_active
      ;;
    4)
      aws_profile_list
      ;;
    0)
      aws_tools
      ;;
    *)
      echo "Your input must be ${supported_tools}"
      ;;
  esac
  endf
}

aws_help() {
  beginf
  echo '$ aws_tools: overview common AWS tools'
  echo '$ aws_setup: guide to install or configure AWS tools'
  echo '$ aws_whoami [PROFILE_NAME]: displays information about the IAM identity used to authenticate the request of a specific profile. Default is current active'
  echo '$ aws_login: authenticate or configure AWS CLI access with your console credentials'
  echo '$ aws_sso_config: configure an AWS IAM Identity Center profile'
  echo '$ aws_sso_login PROFILE_NAME: switch to and log in to an SSO profile'
  echo '$ aws_sso_logout [PROFILE_NAME]: log out of one or all SSO profiles'
  echo '$ aws_profile_active: show the current active AWS profile'
  echo '$ aws_profile_list: list available AWS CLI profiles'
  echo '$ aws_profile_switch PROFILE_NAME: switch the active AWS profile'
  echo '$ aws_profile_view PROFILE_NAME: view the profile info'
  echo '$ aws_docs: open the AWS CLI installation docs'
  echo '$ aws_config_docs: open the configuration and credential file settings in the AWS CLI docs'
  echo '$ aws_auth_docs: open the authentication and access credentials for the AWS CLI docs'
  endf
}
