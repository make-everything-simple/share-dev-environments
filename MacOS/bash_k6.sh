# shellcheck shell=bash
# Utility commands for Grafana k6 performance testing.

#==============================================#
# k6 tools
#==============================================#
alias k6_docs="open 'https://grafana.com/docs/k6/latest/'"
alias k6_cloud_docs="open 'https://grafana.com/docs/grafana-cloud/testing/k6/'"
alias k6_install_docs="open 'https://grafana.com/docs/k6/latest/set-up/install-k6/'"

k6_tools() {
  beginf
  echo 'Grafana k6 is an open-source load testing tool for testing application performance and reliability.'
  echo '① Local tests: write JavaScript test scripts and run them with k6 OSS'
  echo '② Cloud tests: run tests at scale with Grafana Cloud k6'
  echo '③ Test results: stream metrics to Grafana Cloud or another supported output'
  echo '④ Test workflow: create, inspect, archive, run, and version test scripts'
  endf
}

k6_require() {
  if ! command -v k6 >/dev/null 2>&1; then
    echo 'k6 is not installed yet. Run k6_install or visit k6_install_docs.' >&2
    return 1
  fi
}

k6_install() {
  if command -v k6 >/dev/null 2>&1; then
    echo "k6 is already installed: $(k6 version)"
  elif command -v brew >/dev/null 2>&1; then
    brew install k6
  else
    echo 'Homebrew is required for the automatic k6 installation on macOS.' >&2
    echo 'Visit k6_install_docs for other installation options.' >&2
    return 1
  fi
}

k6_version() {
  k6_require || return $?
  k6 version
}

k6_new() {
  k6_require || return $?
  if [[ -z "$1" || -n "$2" ]]; then
    echo 'Usage: k6_new FILE.js' >&2
    return 2
  fi
  k6 new "$1"
}

k6_run() {
  k6_require || return $?
  if [[ -z "$1" ]]; then
    echo 'Usage: k6_run SCRIPT.js [K6_OPTIONS...]' >&2
    return 2
  fi
  k6 run "$@"
}

k6_cloud_login() {
  k6_require || return $?
  k6 cloud login "$@"
}

k6_cloud_run() {
  k6_require || return $?
  if [[ -z "$1" ]]; then
    echo 'Usage: k6_cloud_run SCRIPT.js [K6_OPTIONS...]' >&2
    return 2
  fi
  k6 cloud run "$@"
}

k6_inspect() {
  k6_require || return $?
  if [[ -z "$1" ]]; then
    echo 'Usage: k6_inspect SCRIPT.js [K6_OPTIONS...]' >&2
    return 2
  fi
  k6 inspect "$@"
}

k6_archive() {
  k6_require || return $?
  if [[ -z "$1" ]]; then
    echo 'Usage: k6_archive SCRIPT.js [K6_OPTIONS...]' >&2
    return 2
  fi
  k6 archive "$@"
}

k6_setup() {
  beginf
  readonly supported_tools='(1) Install k6 with Homebrew, (2) Open k6 docs, (3) Open Grafana Cloud k6 docs, (0) Show help'
  echo "Which tool do you want to use: ${supported_tools}?"
  read -r -p ">> input your tool 1|2|3|0: " name

  case "${name}" in
    1)
      k6_install
      ;;
    2)
      k6_docs
      ;;
    3)
      k6_cloud_docs
      ;;
    0)
      k6_tools
      ;;
    *)
      echo "Your input must be ${supported_tools}"
      ;;
  esac
  endf
}

k6_help() {
  beginf
  echo '$ k6_tools: overview common Grafana k6 tools'
  echo '$ k6_setup: install k6 or open k6 documentation'
  echo '$ k6_install: install k6 with Homebrew on macOS'
  echo '$ k6_version: display the installed k6 version'
  echo '$ k6_new FILE.js: create a starter k6 test script'
  echo '$ k6_run SCRIPT.js [K6_OPTIONS...]: run a local k6 test'
  echo '$ k6_cloud_login: authenticate the k6 CLI with Grafana Cloud'
  echo '$ k6_cloud_run SCRIPT.js [K6_OPTIONS...]: run a test in Grafana Cloud k6'
  echo '$ k6_inspect SCRIPT.js [K6_OPTIONS...]: inspect a test script'
  echo '$ k6_archive SCRIPT.js [K6_OPTIONS...]: create a test archive'
  echo '$ k6_docs: open the k6 documentation'
  echo '$ k6_cloud_docs: open the Grafana Cloud k6 documentation'
  echo '$ k6_install_docs: open the k6 installation documentation'
  endf
}
