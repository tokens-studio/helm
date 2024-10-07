# Goalert Helm Chart

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/tokens-studio)](https://artifacthub.io/packages/search?repo=tokens-studio)

This is an unofficial Helm chart for Goalert.

## Prerequisites

- Kubernetes 1.12+
- Helm 3.0+

## Parameters

### Global parameters

### Image parameters

| Name               | Description                                                  | Value             |
| ------------------ | ------------------------------------------------------------ | ----------------- |
| `image.repository` | Docker image repository for GoAlert                          | `goalert/goalert` |
| `image.pullPolicy` | Image pull policy for Kubernetes                             | `IfNotPresent`    |
| `image.tag`        | Overrides the image tag. If empty, uses the chart appVersion | `""`              |
| `imagePullSecrets` | List of image pull secrets                                   | `[]`              |
| `nameOverride`     | Override the name of the chart                               | `""`              |
| `fullnameOverride` | Override the full name of the chart                          | `""`              |

### GoAlert parameters

| Name                                                      | Description                                   | Value                         |
| --------------------------------------------------------- | --------------------------------------------- | ----------------------------- |
| `goalert.existingSecret.name`                             | Name of an existing Kubernetes secret to use  | `""`                          |
| `goalert.existingSecret.keys.GOALERT_DB_URL`              | Key in the secret for the database URL        | `GOALERT_DB_URL`              |
| `goalert.existingSecret.keys.GOALERT_DATA_ENCRYPTION_KEY` | Key in the secret for the data encryption key | `GOALERT_DATA_ENCRYPTION_KEY` |
| `goalert.environment.GOALERT_DB_URL`                      | Database URL for GoAlert                      | `""`                          |
| `goalert.environment.GOALERT_DATA_ENCRYPTION_KEY`         | Data encryption key for GoAlert               | `""`                          |

### PostgreSQL parameters

| Name                       | Description                                       | Value     |
| -------------------------- | ------------------------------------------------- | --------- |
| `postgresql.enabled`       | Whether to enable the bundled PostgreSQL database | `true`    |
| `postgresql.auth.database` | Name of the database to create                    | `goalert` |
| `postgresql.auth.username` | Username for the database                         | `goalert` |
| `postgresql.auth.password` | Password for the database user                    | `example` |
| `postgresql.auth.sslmode`  | SSL mode for database connection                  | `require` |
| `postgresql.service.port`  | Port on which PostgreSQL service is exposed       | `5432`    |

### Service Account parameters

| Name                         | Description                                                                                                            | Value  |
| ---------------------------- | ---------------------------------------------------------------------------------------------------------------------- | ------ |
| `serviceAccount.create`      | Whether to create a service account                                                                                    | `true` |
| `serviceAccount.annotations` | Annotations to add to the service account                                                                              | `{}`   |
| `serviceAccount.name`        | The name of the service account to use. If not set and create is true, a name is generated using the fullname template | `""`   |

### Service parameters

| Name           | Description                          | Value       |
| -------------- | ------------------------------------ | ----------- |
| `service.type` | Type of Kubernetes service to create | `ClusterIP` |
| `service.port` | Port on which the service is exposed | `8081`      |

### Ingress parameters

| Name                  | Description                           | Value   |
| --------------------- | ------------------------------------- | ------- |
| `ingress.enabled`     | Whether to create an Ingress resource | `false` |
| `ingress.className`   | Ingress class name                    | `""`    |
| `ingress.annotations` | Annotations for the Ingress resource  | `{}`    |
| `ingress.hosts`       | List of hosts for the Ingress         | `[]`    |
| `ingress.tls`         | TLS configuration for the Ingress     | `[]`    |

### Autoscaling parameters

| Name                                         | Description                                       | Value   |
| -------------------------------------------- | ------------------------------------------------- | ------- |
| `autoscaling.enabled`                        | Whether to enable autoscaling                     | `false` |
| `autoscaling.minReplicas`                    | Minimum number of replicas when autoscaling       | `1`     |
| `autoscaling.maxReplicas`                    | Maximum number of replicas when autoscaling       | `100`   |
| `autoscaling.targetCPUUtilizationPercentage` | Target CPU utilization percentage for autoscaling | `80`    |

### Pod Values

| Name                 | Description                                    | Value |
| -------------------- | ---------------------------------------------- | ----- |
| `nodeSelector`       | Node selector for pod assignment               | `{}`  |
| `tolerations`        | for pod assignment                             | `[]`  |
| `affinity`           | settings for a pod assignment                  | `{}`  |
| `resources`          | Resource requests and limits for the container | `{}`  |
| `podAnnotations`     | Annotations to add to the pod                  | `{}`  |
| `podSecurityContext` | Security context for the pod                   | `{}`  |
| `securityContext`    | Security context for the container             | `{}`  |
| `replicaCount`       | Number of replica pods to run                  | `1`   |

## Provenance

All Helm releases are signed with out PGP key

## Notes

As per the current documentation, you will need to manually create the initial admin users post-install.
