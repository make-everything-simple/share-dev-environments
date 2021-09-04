#!/bin/bash 
#
# Add customized Command Line tools run inside any terminal as system.

###############################################################################
# Describe the guideline to execute the function cli_register
###############################################################################
cli_register_info() {
  echo "###############################################################################"
  echo "# Register Command Line tools with the system"
  echo "#"
  echo "# Step by Step:"
  echo "# 1. Create a directory CommandLine to contain all of your custom CLI"
  echo "# 2. Move other contain commandline tools to created directory to centralize"
  echo "# 3. Execute the function cli_register to let it does the work for you"
  echo "# 4: Write export PATH to the file environment_custom_cli"
  echo "# 5. Refresh the environment to take effect immediately $ refresh"
  echo "# 6: Verify your environment for configured CLI Tools"
  # Show an concrete example for more detail
  echo " e.g. A directory at /Applications/CommandLine as I used and use it as default in case your skip input"
  echo "
  ├── apache-maven-3.6.3
  ├── google-cloud-sdk
  ├── kafka_2.13-2.8.0
  ├── kotlin-native-macos-1.3.31
  ├── kotlinc
  ├── mongodb-enterprise-4.4.6
  └── terraform
  "
  echo "After executing. Just verify your environment e.g $ terraform, mongo..."
  echo "🔔 NOTE: Everytime you update or add new cli tools just re-execute the function $ cli_register 🔔"
  echo "###############################################################################"
}

###############################################################################
# Register Command Line tools with the system.
#
# Step by Step:
# 1. Create local Environment variables
# 2. Create custom file to expose environment variables: custom_cli_file_name
# 3. Register reload for the custom_cli_file_name to bash_active_dev
# 4. Read all directories of custom commandline
# 5: Write export PATH to the file custom_cli_file_name
# 6: Display the command to refresh the environment to take effect immediately
###############################################################################
cli_register() {
  beginf
  # 1. Create local Environment variables
  local custom_cli_file_name=environment_custom_cli
  local SHARE_DIR_NAME=".share-dev-environments"
  local SHARE_DEV_HOME=$HOME/$SHARE_DIR_NAME
  local CLI_HOME="/Applications/CommandLine"
  echo -n '>> Enter your custom commandline path: '
  read cli_path
  if [[ -n "${cli_path}" ]]; then
    CLI_HOME="${cli_path}"
  fi
  echo "Your CLI_HOME: ${CLI_HOME}"

  # 2. Create 1 file content this custom module: $custom_cli_file_name
  touch $SHARE_DEV_HOME/$custom_cli_file_name
  echo "export CLI_HOME=$CLI_HOME" > $SHARE_DEV_HOME/$custom_cli_file_name
  echo 'export PATH=$PATH:$CLI_HOME' >> $SHARE_DEV_HOME/$custom_cli_file_name
  # 3. Register reload for the $custom_cli_file_name to bash_active_dev
  if [[ -r ~/$SHARE_DIR_NAME/bash_active_dev ]]; then
    local register_entry="test -r ~/$SHARE_DIR_NAME/$custom_cli_file_name && source ~/$SHARE_DIR_NAME/$custom_cli_file_name"
    local content_base_active_dev=$(cat $SHARE_DEV_HOME/bash_active_dev)
    if [[ ! "${content_base_active_dev}" =~ "${register_entry}" ]]; then
      # Write append head to the file if need
      echo -e "$register_entry\n$(cat ~/$SHARE_DIR_NAME/bash_active_dev)" > ~/$SHARE_DIR_NAME/bash_active_dev
    fi
  fi
  # 4. Read all directories of custom commandline
  # local item_list=
  # echo $item_list
  declare -a features=($(ls $CLI_HOME))
  echo $features
  count=0
  # Add parameter expansion to let system handle evaluation when running
  # https://www.gnu.org/software/bash/manual/bash.html#Shell-Parameter-Expansion
  local parameter_expansion="$"
  for item in "${features[@]}"; do 
      # 5: Write export PATH to the file $custom_cli_file_name
      ((count += 1))
      echo "...$count $item"
      if [[ -d "$CLI_HOME/$item/bin" ]]; then
          group $item  >> $SHARE_DEV_HOME/$custom_cli_file_name
          echo "export PATH=${parameter_expansion}PATH:${parameter_expansion}CLI_HOME/$item/bin" >> $SHARE_DEV_HOME/$custom_cli_file_name
      elif [[ -d "$CLI_HOME/$item" ]]; then
        group $item  >> $SHARE_DEV_HOME/$custom_cli_file_name
        echo "export PATH=${parameter_expansion}PATH:${parameter_expansion}CLI_HOME/$item" >> $SHARE_DEV_HOME/$custom_cli_file_name
      fi
  done
  # 6: Display the command to refresh the environment to take effect immediately
  remind_refresh
  endf
}

cli_tools() {
  beginf
  echo 'Use built-in shell commands to register customized environment variables with the system'
  endf
}

cli_help() {
  beginf
  echo '$ cli_register_info: Describe the guideline to execute the function cli_register'
  echo '$ cli_register: Register Command Line tools with the system'
  endf
}