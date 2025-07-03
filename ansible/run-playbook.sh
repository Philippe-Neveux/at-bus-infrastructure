#!/bin/bash

# Ansible Playbook Runner Script
# Usage: ./run-playbook.sh <playbook-name>
#
# This script runs Ansible playbooks with the new airflow/ directory structure.
# Airflow files are now organized under the airflow/ directory at the project root.

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Default values
INVENTORY="inventory/production.yml"
VERBOSE=""

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to show usage
show_usage() {
    echo "Usage: $0 <playbook-name> [options]"
    echo ""
    echo "Available playbooks:"
    echo "  deploy/airflow          - Deploy Airflow (copies from ../airflow/)"
    echo "  operations/stop-airflow - Stop Airflow services"
    echo "  operations/restart-airflow - Restart Airflow services"
    echo "  operations/status-airflow - Check Airflow status"
    echo ""
    echo "Options:"
    echo "  -v, --verbose          - Enable verbose output"
    echo "  -h, --help             - Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 deploy/airflow"
    echo "  $0 operations/status-airflow -v"
    echo ""
    echo "Note: Airflow files are now organized under ../airflow/ directory"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -v|--verbose)
            VERBOSE="-v"
            shift
            ;;
        -h|--help)
            show_usage
            exit 0
            ;;
        *)
            PLAYBOOK="$1"
            shift
            ;;
    esac
done

# Check if playbook name is provided
if [[ -z "$PLAYBOOK" ]]; then
    print_error "No playbook specified"
    show_usage
    exit 1
fi

# Check if inventory file exists
if [[ ! -f "$INVENTORY" ]]; then
    print_error "Inventory file not found: $INVENTORY"
    exit 1
fi

# Check if playbook file exists
PLAYBOOK_PATH="playbooks/$PLAYBOOK.yml"
if [[ ! -f "$PLAYBOOK_PATH" ]]; then
    print_error "Playbook not found: $PLAYBOOK_PATH"
    echo ""
    echo "Available playbooks:"
    find playbooks -name "*.yml" | sed 's|playbooks/||' | sed 's|.yml||' | sort
    exit 1
fi

# Check if airflow directory exists (for deploy playbook)
if [[ "$PLAYBOOK" == "deploy/airflow" ]]; then
    if [[ ! -d "../airflow" ]]; then
        print_warning "Airflow directory not found at ../airflow/"
        print_warning "Make sure you have the airflow/ directory with dags/, plugins/, and config/ subdirectories"
    fi
fi

# Run the playbook
print_status "Running playbook: $PLAYBOOK"
print_status "Inventory: $INVENTORY"
if [[ "$PLAYBOOK" == "deploy/airflow" ]]; then
    print_status "Source: ../airflow/ → /opt/airflow/"
fi
echo ""

ansible-playbook -i "$INVENTORY" "$PLAYBOOK_PATH" $VERBOSE

if [[ $? -eq 0 ]]; then
    print_status "Playbook completed successfully!"
else
    print_error "Playbook failed!"
    exit 1
fi 