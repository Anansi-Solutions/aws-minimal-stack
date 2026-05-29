# Template for a minimal AWS stack

## Disclaimer

This is a minimal template which we've found useful for MVP-level projects
at [Anansi Solutions](https://anansi-solutions.net).

It offers little in the way of high-availability or monitoring,
and further optimizations are highly recommended for heavy workloads.

## How to use this template

The following variables should be replaced across the whole codebase

### `__PROJECT_NAME__`

A shorthand or codename for the project itself, ASCII and no spaces allowed

### `__AWS_REGION__`

The AWS region in which the solution is to be deployed.

### `__DEFAULT_BRANCH__`

This is the name of the default branch in your GitHub repository

### TFLint error suppressions

Some errors are ignored within the template, as they are an artifact of the templating.
You should remove all `# tflint-ignore:` lines before usage.

## Infrastructure Deployment

### Dependencies
- AWS
- OpenTofu
- Scalr (or equivalent service)

### Setup steps
1. Create Scalr Account

2. Setup `dev` and `prod` environment

3. Follow the instructions [here](https://docs.scalr.io/docs/aws#oidc) to setup the AWS<=>Scalr integration.
   Please setup the role with a policy that only has the necessary privileges.
   `SystemAdministrator` should not be used past initial prototyping stages, and only in a dedicated tenant.

4. Follow the instructions [here](https://docs.scalr.io/docs/custom-providers)
   and [here](https://docs.scalr.io/docs/github) to setup the GitHub<=>Scalr integration,
   both as a Terraform provider and as a VCS provider.
   > ⚠ **_WARNING:_** The Terraform provider for GitHub should have type as `integrations/github`,
   as the default `GitHub` provider may lead to the following run error:
   > > │ Error: Inconsistent dependency lock file  
   > > │  
   > > │ The following dependency selections recorded in the lock file are  
   > > │ inconsistent with the current configuration:  
   > > │   - provider registry.opentofu.org/hashicorp/github: required by this configuration but no version is selected


5. tofu apply

6. Obtain any further API keys you may need and configure the GitHub action variable/secrets
   accordingly in the GitHub repository

## Maintenance and Operations

### Requirements

Make sure both the [AWS CLI](https://aws.amazon.com/cli/) and its
[Session Manager Plugin](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager.html)
are installed, on Windows this can be done with:
```bash
winget install -e --id Amazon.AWSCLI
winget install -e --id Amazon.SessionManagerPlugin
```

### Connecting to the deployed database

Ensure you're logged in, by running
```bash
aws login
```

An SSH tunnel can then be established by running the following:

```bash
task infrastructure:ssh:dev
# or in production:
# task infrastructure:ssh:prod
```

The user can then connect to the database on `localhost:5555/__PROJECT_NAME__` (port `5556` for production) with the user `__PROJECT_NAME__`.
The password can be retrieved through the AWS interface for the AWS Secrets Manager.
