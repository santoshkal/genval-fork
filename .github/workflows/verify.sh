#!/bin/bash

set -ex

archs=(
    "darwin_amd64"
    "darwin_arm64"
    "linux_amd64"
    "linux_arm64"
    "windows_amd64"
    "windows_arm64"
)
COMMIT=$(git rev-list --tags --max-count=1)
version=$(git describe --tags ${COMMIT})
version="${version#v}"

for arch in "${archs[@]}"; do
    # Define the base URL for the release files
    base_url="https://github.com/santoshkal/genval-fork/releases/download/v${version}/genval_${version}_${arch}.tar.gz"
    
    # Download the main release file
    # echo "Downloading genval_${version}_${arch}.tar.gz..."
    curl -L -O "${base_url}" >/dev/null 2>&1
    
    # Download the signature file
    # echo "Downloading genval${version}_${arch}.tar.gz.sig..."
    curl -L -O "${base_url}.sig" >/dev/null 2>&1
    
    # Download the certificate file
    # echo "Downloading genval${version}_${arch}.tar.gz.crt..."
    curl -L -O "${base_url}.crt" >/dev/null 2>&1
    
    # Verify the downloaded file using cosign
    # echo "Verifying genval_${version}_${arch}.tar.gz..."
    cosign verify-blob \
        --signature "genval_${version}_${arch}.tar.gz.sig" \
        --certificate "genval_${version}_${arch}.tar.gz.crt" \
        --certificate-oidc-issuer "https://token.actions.githubusercontent.com" \
        --certificate-identity "https://github.com/santoshkal/genval-fork/.github/workflows/release.yaml@refs/tags/v${version}" \
        "genval_${version}_${arch}.tar.gz" >/dev/null 2>&1
    
    # Check if verification was successful
    if [ $? -eq 0 ]; then
        echo "Verification successful for genval${version}_${arch}.tar.gz." >/dev/null
    else
        echo "Error verifying genval ${version}_${arch}.tar.gz. Exiting."
        exit 1
    fi
done
    # echo "Verification for all OS's and Archs was successful."

# --cert=https://github.com/santoshkal/genval-fork/releases/download/v0.1.7/genval_0.1.7_darwin_amd64.tar.gz.crt
# https://github.com/santoshkal/genval-fork/releases/download/v0.1.7/genval_0.1.7_darwin_arm64.tar.gz