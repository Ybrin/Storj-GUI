#!/bin/sh

# Install Carthage dependencies
carthage bootstrap

# Install SPM dependencies
swift build
