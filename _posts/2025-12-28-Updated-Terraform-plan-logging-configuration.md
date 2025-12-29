--- 
layout: post 
title: Updated Terraform plan logging configuration.
date: 2025-12-28T22:57:14.981-05:00
tags: [homelab, github, actions, terragrunt, logging, workflow]
categories: [Homelab]
author: ai
---
### Change Summary
This git diff modifies the `plan.yml` GitHub Actions workflow file, specifically updating the `tg_command` and `tg_comment` parameters used in the Terragrunt action. The changes enhance logging and adjust comment behavior.

### Technical Details
- **File**: `.github/workflows/plan.yml`
- **Change**: Updated `tg_command` and `tg_comment` parameters within the Terragrunt action.
- **Before**:
  ```yaml
  tg_command: 'run --all --non-interactive --summary-per-unit -- plan'
  tg_comment: true
  ```
- **After**:
  ```yaml
  tg_command: 'run --all --non-interactive --summary-per-unit --log-level stdout --log-format bare -- plan'
  tg_comment: 1
  ```

### Key Learnings & Insights
- **Enhanced Logging**: The addition of `--log-level stdout` and `--log-format bare` improves the visibility of logs during the plan execution. This makes it easier to debug issues by providing more detailed output directly to the standard output.
- **Comment Behavior**: Changing `tg_comment` from `true` to `1` suggests a more explicit control over comment generation. This could imply a change in how comments are handled or formatted within the workflow, though the exact impact would depend on the Terragrunt action's implementation details.
- **Problem-Solving**: These changes likely address issues related to insufficient logging and unclear comment generation, enhancing the workflow's reliability and maintainability.

### Impact Assessment
- **Performance**: There should be no significant performance impact since these changes primarily affect logging and comment generation.
- **Maintainability**: Improved logging makes the workflow easier to debug and maintain, reducing the time required to identify and resolve issues.
- **Breaking Changes**: There are no breaking changes introduced by this update. However, developers should be aware of the more verbose logging output.

### Developer Notes
- **Logging Verbosity**: Be prepared for increased verbosity in the workflow logs due to the `--log-level stdout` and `--log-format bare` flags.
- **Comment Handling**: Ensure that the change in `tg_comment` from `true` to `1` aligns with the expected behavior for comment generation in your workflow.
- **Future Improvements**: Consider adding additional logging flags or refining comment generation further to enhance workflow clarity and efficiency.