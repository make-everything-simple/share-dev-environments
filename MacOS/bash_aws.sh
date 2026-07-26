# shellcheck shell=bash
# Utility commands for Amazon Web Services development.

#==============================================#
# AWS tools
#==============================================#
alias aws_docs="open 'https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html'"
alias aws_config_docs="open 'https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html'"

aws_tools() {
  beginf
  echo 'Amazon Web Services provides cloud infrastructure, compute, storage, and data services.'
  echo '① AWS CLI: command-line tools to manage AWS resources from the terminal'
  echo '② AWS profiles: separate named configurations for different accounts and roles'
  echo '③ AWS S3: manage objects and buckets with the AWS CLI'
  echo '④ AWS ECS / EKS helpers: work with container services and Kubernetes on AWS'
  endf
}

aws_show_config() {
  if command -v aws >/dev/null 2>&1; then
    aws configure list --profile default 2>/dev/null || aws configure list 2>/dev/null || true
  else
    echo 'AWS CLI is not installed yet. Run aws_setup or visit the docs.'
  fi
}

aws_show_profiles() {
  if command -v aws >/dev/null 2>&1; then
    aws configure list-profiles 2>/dev/null || true
  else
    echo 'AWS CLI is not installed yet. Run aws_setup or visit the docs.'
  fi
}

aws_switch_profile() {
  if command -v aws >/dev/null 2>&1; then
    if [[ -n "$1" ]]; then
      export AWS_PROFILE="$1"
      echo "Switched active AWS profile to $1"
    else
      echo 'Usage: aws_switch_profile PROFILE_NAME'
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
      aws_show_config
      ;;
    4)
      aws_show_profiles
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
  echo '$ aws_login: authenticate or configure AWS CLI access'
  echo '$ aws_show_config: show the current AWS CLI configuration context'
  echo '$ aws_show_profiles: list available AWS CLI profiles'
  echo '$ aws_switch_profile PROFILE_NAME: switch the active AWS profile'
  echo '$ aws_docs: open the AWS CLI installation docs'
  endf
}
