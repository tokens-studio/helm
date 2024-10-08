{{/*
Expand the name of the chart.
*/}}
{{- define "goalert.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "goalert.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "goalert.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "goalert.labels" -}}
helm.sh/chart: {{ include "goalert.chart" . }}
{{ include "goalert.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "goalert.selectorLabels" -}}
app.kubernetes.io/name: {{ include "goalert.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "goalert.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "goalert.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Generate the PostgreSQL connection string
*/}}
{{- define "goalert.databaseUrl" -}}
{{- if .Values.postgresql.enabled -}}
    {{- $postgresHost := printf "%s-postgresql" (include "goalert.fullname" .) -}}
    {{- $postgresPort := .Values.postgresql.service.port | toString -}}
    {{- $postgresUser := .Values.postgresql.auth.username -}}
    {{- $postgresPassword := .Values.postgresql.auth.password -}}
    {{- $postgresDatabase := .Values.postgresql.auth.database -}}
    {{- $postgresSslMode := .Values.postgresql.sslmode -}}
    {{- if or (not $postgresUser) (not $postgresPassword) (not $postgresDatabase) -}}
        {{- fail "PostgreSQL username, password, and database must be provided" -}}
    {{- end -}}
    {{- printf "postgres://%s:%s@%s:%s/%s?sslmode=%s" $postgresUser $postgresPassword $postgresHost $postgresPort $postgresDatabase $postgresSslMode -}}
{{- else -}}
    {{- .Values.goalert.environment.GOALERT_DB_URL -}}
{{- end -}}
{{- end -}}
