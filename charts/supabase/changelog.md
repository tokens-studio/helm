## 0.1.1

Fixes incorrect hardcoding of the kong config for functions

https://github.com/supabase-community/supabase-kubernetes/pull/99/files

## 0.1.0

Added the ability to customize the kong declarative yml for the dashboard as well as the start up script to allow for use of plugins like oidc.

Also added the ability to use `envFrom` syntax for the kong deployment so that sensitive environment variables can be loaded from a secret.

## 0.0.9

Added support for automatically exposing the needed SAML metadata and ACS routes through kong if auth.environment.GOTRUE_SAML_ENABLED is set to "true"