#!/bin/bash

# Airflow Ansible Deployment Script
set -e

echo "🚀 Starting Airflow deployment..."

# Check if Ansible is installed
if ! command -v ansible-playbook &> /dev/null; then
    echo "❌ Ansible is not installed. Please install Ansible first."
    exit 1
fi

# Check if inventory file exists
if [ ! -f "inventory.yml" ]; then
    echo "❌ inventory.yml not found. Please create it first."
    exit 1
fi

# Install required collections
echo "📦 Installing Ansible collections..."
ansible-galaxy collection install -r requirements.yml

# Check playbook syntax
echo "🔍 Checking playbook syntax..."
ansible-playbook --syntax-check playbook.yml

# Run the playbook
echo "🎯 Running Ansible playbook..."
ansible-playbook playbook.yml

echo "✅ Deployment completed successfully!"
echo ""
echo "🌐 Access Airflow at: http://YOUR_VM_IP:8080"
echo "🔧 Access via Nginx at: http://YOUR_VM_IP"
echo "🌸 Access Flower at: http://YOUR_VM_IP:5555"
echo ""
echo "📋 To check status, SSH to your server and run:"
echo "   cd /opt/airflow && docker-compose ps" 