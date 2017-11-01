{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "piapp.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "piapp.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}



{{- define "mysqldb.fqdn" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s.%s.%s" .Release.Name "mysql" .Release.Namespace "svc.cluster.local" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
