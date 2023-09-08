#!/bin/bash

# Create kubernetes_support directory if not exists
mkdir -p kubernetes_support

# Array of URLs and their corresponding names
declare -A urls
urls=(
    ["kubernetes"]="https://endoflife.date/api/kubernetes"
    ["aks"]="https://endoflife.date/api/azure-kubernetes-service"
    ["gke"]="https://endoflife.date/api/google-kubernetes-engine"
    ["openshift"]="https://endoflife.date/api/red-hat-openshift"
    ["eks"]="https://endoflife.date/api/amazon-eks"
)

# Date of data collection
date=$(date +"%Y-%m-%d")

# Loop through the array and download the JSON
for name in "${!urls[@]}"; do
    url=${urls[$name]}
    # Query API and pretty print the JSON
    response=$(curl -sL "$url" | jq '.')
    # Check if the command was successful
    if [ $? -ne 0 ]; then
        echo "Failed to download $name information from $url"
        exit 1
    fi
    # Write the response to a file
    echo "/* Data collected on: $date */\n$response" > "kubernetes_support/$name.json"
done

echo "All files have been successfully downloaded."
