#!/bin/bash 
#
# Simple CI helper for local runs (CI Local)
# - list jobs from GitHub Actions workflows and .gitlab-ci.yml
# - run a specific job via `act` (GitHub) or `gitlab-ci-local` (GitLab)
# - show versions

ci_local_list() {
  beginf
  repo_root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
  found=0

  # GitHub Actions workflows
  # Prefer using `act` to list GitHub Actions jobs
  github_workflows_found=0
  for workflow in "${repo_root}"/.github/workflows/*.yml "${repo_root}"/.github/workflows/*.yaml; do
    if [[ -f "${workflow}" ]]; then
      github_workflows_found=1
      break
    fi
  done

  if [[ ${github_workflows_found} -eq 1 ]]; then
    if command -v act >/dev/null 2>&1; then
      found=1
      echo "Using 'act' to list workflows/jobs:"
      # Try common list flags; some act versions support --list or -l
      act --list 2>/dev/null
    else
      # No act installed; we don't fallback to brittle parsing — instruct the user
      found=1
      echo "GitHub Actions workflows detected, but 'act' is not installed. Install nektos/act to list/run jobs locally: https://github.com/nektos/act"
    fi
  fi

  # GitLab CI
  if [[ -f "${repo_root}/.gitlab-ci.yml" ]]; then
    if command -v gitlab-ci-local >/dev/null 2>&1; then
      found=1
      echo "Using 'gitlab-ci-local' to inspect .gitlab-ci.yml:"
      # Try a list/show variant if supported, else show version and hint
      gitlab-ci-local --list 2>/dev/null
    else
      found=1
      echo "Found .gitlab-ci.yml but 'gitlab-ci-local' is not installed. Install it to run/list GitLab CI jobs locally: https://github.com/firecow/gitlab-ci-local"
    fi
  fi

  [[ ${found} -eq 1 ]] || echo "No CI workflows found."
  endf
}

ci_local_jobs_by_event() {
  beginf
  if [[ $# -lt 1 ]]; then
    echo "Usage: $0 jobs_by_event <event>" >&2
    endf
    return 2
  fi

  event="$1"
  repo_root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
  found=0

  github_workflows_found=0
  for workflow in "${repo_root}"/.github/workflows/*.yml "${repo_root}"/.github/workflows/*.yaml; do
    if [[ -f "${workflow}" ]]; then
      github_workflows_found=1
      break
    fi
  done

  if [[ ${github_workflows_found} -eq 1 ]]; then
    found=1
    if command -v act >/dev/null 2>&1; then
      echo "GitHub Actions jobs triggered by ${event}:"
      act "${event}" -l
    else
      echo "GitHub Actions workflows detected, but 'act' is not installed. Install nektos/act to list jobs locally: https://github.com/nektos/act"
    fi
  fi

  if [[ -f "${repo_root}/.gitlab-ci.yml" ]]; then
    found=1
    if command -v gitlab-ci-local >/dev/null 2>&1; then
      echo "GitLab CI jobs triggered by ${event}:"
      CI_PIPELINE_SOURCE="${event}" gitlab-ci-local --list
    else
      echo "Found .gitlab-ci.yml but 'gitlab-ci-local' is not installed. Install it to list jobs locally: https://github.com/firecow/gitlab-ci-local"
    fi
  fi

  [[ ${found} -eq 1 ]] || echo "No CI workflows found."
  endf
}

ci_local_run() {
  beginf
  if [[ $# -lt 1 ]]; then
    echo "Usage: $0 run <job-name> [-- <extra act/gitlab args>]" >&2
    endf
    return 2
  fi
  job="$1"; shift || true
  repo_root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
  # If repository uses GitLab CI, prefer gitlab-ci-local
  if [[ -f "${repo_root}/.gitlab-ci.yml" ]]; then
    if command -v gitlab-ci-local >/dev/null 2>&1; then
      echo "Running GitLab job ${job} with gitlab-ci-local..."
      gitlab-ci-local run -f "${repo_root}/.gitlab-ci.yml" "${job}" "$@"
      local result=$?
      endf
      return "${result}"
    else
      echo "Found .gitlab-ci.yml but 'gitlab-ci-local' is not installed. Install it to run GitLab CI jobs locally: https://github.com/firecow/gitlab-ci-local" >&2
      endf
      return 3
    fi
  fi

  # Otherwise assume GitHub Actions and use act
  if command -v act >/dev/null 2>&1; then
    echo "Running GitHub Actions job ${job} with act..."
    # Try running by job name directly first
    if act -j "${job}" "$@"; then
      endf
      return 0
    fi
    # If direct run failed, try running with each workflow explicitly
    for wf in "${repo_root}"/.github/workflows/*.yml; do
      [[ -f "${wf}" ]] || continue
      echo "Trying workflow $(basename "${wf}")..."
      if act -W "${wf}" -j "${job}" "$@"; then
        endf
        return 0
      fi
    done
    echo "act failed to run job ${job}." >&2
    endf
    return 4
  else
    echo "No supported CI local tool installed. Install 'act' (GitHub) or 'gitlab-ci-local' (GitLab) to run CI jobs locally." >&2
    endf
    return 3
  fi
}

ci_local_version() {
  beginf
  if command -v gitlab-ci-local >/dev/null 2>&1; then
    echo "gitlab-ci-local version: $(gitlab-ci-local --version || true)"
  else
    echo "gitlab-ci-local: not installed"
  fi
  if command -v act >/dev/null 2>&1; then
    act --version || true
  else
    echo "act: not installed"
  fi
  endf
}

ci_local_explore() {
  beginf
  repo_root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
  docs_url=''
  tool_name=''

  if [[ -f "${repo_root}/.gitlab-ci.yml" ]] && command -v gitlab-ci-local >/dev/null 2>&1; then
    docs_url='https://github.com/firecow/gitlab-ci-local'
    tool_name='gitlab-ci-local'
  elif [[ -d "${repo_root}/.github/workflows" ]] && command -v act >/dev/null 2>&1; then
    docs_url='https://nektosact.com/usage/index.html'
    tool_name='act'
  elif command -v gitlab-ci-local >/dev/null 2>&1; then
    docs_url='https://github.com/firecow/gitlab-ci-local'
    tool_name='gitlab-ci-local'
  elif command -v act >/dev/null 2>&1; then
    docs_url='https://nektosact.com/usage/index.html'
    tool_name='act'
  else
    echo "No supported CI local tool installed. Install 'act' or 'gitlab-ci-local' first." >&2
    endf
    return 3
  fi

  echo "Opening the official ${tool_name}'s documentation... ${docs_url} to explore customized testing"
  open "${docs_url}"
  local result=$?
  endf
  return "${result}"
}

# Compatibility with module-style usage when sourced (follow existing module format)
ci_local_tools() {
  beginf
  echo '$ ci_local_tools: list available CI tools and their status'
  if command -v act >/dev/null 2>&1; then
    echo "  act: installed -> $(act --version 2>/dev/null || echo 'version unknown' || true)"
  else
    echo '  act: not installed'
  fi
  if command -v gitlab-ci-local >/dev/null 2>&1; then
    echo "  gitlab-ci-local: installed -> $(gitlab-ci-local --version 2>/dev/null || echo 'version unknown' || true)"
  else
    echo '  gitlab-ci-local: not installed'
  fi
  endf
}

ci_local_help() {
  beginf
  echo '$ ci_local_tools: show installed CI helper tools and versions'
  echo '$ ci_local_list: list CI jobs from .github/workflows and .gitlab-ci.yml'
  echo '$ ci_local_jobs_by_event [EVENT]: list CI jobs triggered by EVENT'
  echo '$ ci_local_run [JOB] [-- <extra args>]: run JOB locally using gitlab-ci-local or act'
  echo '$ ci_local_version: show tool versions'
  echo '$ ci_local_explore: open documentation for more customized testing commands from native tool'
  endf
}
