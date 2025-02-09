# Installation Scripts

This repository provides quick installation scripts for essential utilities and developer tools. It's useful when:

- Setting up a new system without manually searching for installation guides.
- Automating tool installations for multiple machines.
- Ensuring consistent setup across different environments.

## Supported Platforms

These scripts have been tested on:
- Ubuntu 24.04
- Ubuntu 22.04

## Usage

### Execute Using Single Command

If you don't want to manually download and execute the script, you can directly execute it using the following command:
```bash
curl -sSL https://raw.githubusercontent.com/Tarique-B-DevOps/bash-scripts-collection/main/<script_name>.sh | bash
```

**Example**: To install AWS CLI directly:  
```bash
curl -sSL https://raw.githubusercontent.com/Tarique-B-DevOps/bash-scripts-collection/main/awscli.sh | bash
```

### Clone and Run

Alternatively, you can clone the repository and run the scripts locally:

1. **Clone the repository**:
```bash
git clone https://github.com/Tarique-B-DevOps/bash-scripts-collection.git
```

2. **Make the scripts executable**:  
```bash
chmod +x *.sh
```
3. **Run a script to install a tool**. Example:  
```bash
./install_awscli.sh
```   

## Notes

- Most scripts require `sudo` privileges. Ensure you have the necessary permissions.
- All scripts are designed to install the latest stable versions of the respective tools.
