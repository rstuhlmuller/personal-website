--- 
layout: post 
title: "Devcontainer and Terraform config updates."
date: 2025-08-10T03:08:38.049-04:00
tags: [homelab]
author: ai
---
### Change Summary
This update involves several modifications across different components of the project. Key changes include adjustments to the development container configuration, updates to the ArgoCD module for image updates, and the addition of a new AWS documentation MCP server in the Open WebUI module.

### Technical Details
- **Development Container Configuration (`devcontainer.json`):**
  - Removed the following VS Code extensions:
    - `hashicorp.terraform`
    - `GitHub.copilot`
    - `GitHub.copilot-chat`
    - `eamodio.gitlens`
  - Retained the `hashicorp.hcl` extension.

- **ArgoCD Module (`IaC/modules/argocd/main.tf`):**
  - Modified the `helm_release` resource for `argocd_image_updater`.
  - Changed the interval for image updates from `6h` to `1h`.

- **Open WebUI Module (`IaC/modules/open-webui/main.tf`):**
  - Added a new configuration for `awslabs.aws-documentation-mcp-server`.
  - Specified command `uvx` and arguments `["awslabs.aws-documentation-mcp-server@latest"]`.
  - Set environment variables:
    - `FASTMCP_LOG_LEVEL` to `ERROR`
    - `AWS_DOCUMENTATION_PARTITION` to `aws`
  - Marked the configuration as `disabled` with `autoApprove` set to an empty list.

### Key Learnings & Insights
- **Streamlining Development Environment:**
  - The removal of several VS Code extensions aims to streamline the development environment, focusing only on essential tools. This reduces clutter and potential conflicts.
  
- **Frequent Image Updates:**
  - Reducing the interval for ArgoCD image updates from `6h` to `1h` ensures more frequent checks for new images, potentially leading to quicker adoption of updates and improved system reliability.

- **Integration of AWS Documentation Server:**
  - The addition of the `awslabs.aws-documentation-mcp-server` demonstrates an effort to integrate AWS documentation directly into the WebUI, enhancing developer accessibility to AWS resources.

### Impact Assessment
- **Performance:**
  - More frequent image updates may slightly increase the load on the system but are expected to enhance reliability by ensuring the use of the latest images.
  
- **Maintainability:**
  - Streamlining the development environment should make it easier for new developers to set up and start contributing, reducing onboarding time.
  
- **Functionality:**
  - The integration of the AWS documentation server adds a valuable resource directly within the WebUI, improving developer efficiency.

### Developer Notes
- **Gotchas:**
  - Ensure that the new interval for image updates does not conflict with other scheduled tasks.
  - Verify that the environment variables for the AWS documentation server are correctly set and do not interfere with other configurations.
  
- **Future Improvements:**
  - Consider adding monitoring for the frequency of image updates to ensure it aligns with system performance.
  - Explore enabling the `awslabs.aws-documentation-mcp-server` configuration once testing is complete and assess its impact on the WebUI performance.