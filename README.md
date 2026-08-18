# Azure Hub & Spoke Architecture

![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white) <br>
![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white) <br>
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge) <br>
![CI](https://img.shields.io/badge/CI-passing-brightgreen.svg?style=for-the-badge)

## Table of Contents
- [Architecture Overview](#architecture-overview)
- [Quick Start](#quick-start)
- [Environments](#environments)
- [Modules](#modules)

## Architecture Overview
Here is my hub and spoke architecture setup for Azure. I built this to help separate our core networking components from application workloads.

## Quick Start
To get started quickly, check out my examples in the `examples/basic` directory.

## Environments
I've split the configurations into these environments:
- dev
- uat
- prod

## Modules
- hub
- spoke
