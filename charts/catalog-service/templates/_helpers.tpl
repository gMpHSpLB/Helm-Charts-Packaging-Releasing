{{/*
Expand the name of the chart.
Usage: {{ include "myapp.name" . }}
*/}}
{{- define "myapp.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a fully qualified app name.
Combines release name with chart name unless nameOverride is set.
Truncated to 63 chars — Kubernetes label value limit.
Usage: {{ include "myapp.fullname" . }}
*/}}
{{- define "myapp.fullname" -}}
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
Chart label: "myapp-1.0.0" — identifies which chart version created this resource.
Usage: {{ include "myapp.chart" . }}
*/}}
{{- define "myapp.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Standard labels applied to EVERY resource this chart creates.
These are the labels Helm uses to track ownership.
Usage: {{ include "myapp.labels" . | nindent 4 }}
*/}}
{{- define "myapp.labels" -}}
helm.sh/chart: {{ include "myapp.chart" . }}
{{ include "myapp.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels — used by Deployment selector and Service selector.
These MUST be stable. Changing them requires deleting and recreating the Deployment.
Usage: {{ include "myapp.selectorLabels" . | nindent 6 }}
*/}}
{{- define "myapp.selectorLabels" -}}
app.kubernetes.io/name: {{ include "myapp.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
ServiceAccount name.
Usage: {{ include "myapp.serviceAccountName" . }}
*/}}
{{- define "myapp.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "myapp.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
If .Values.image.tag is empty, this falls back to .Chart.AppVersion (1.0.0).
Image string: combines repository, name, and tag.
Allows overriding each part independently.
Usage: {{ include "myapp.image" . }}
*/}}
{{- define "myapp.image" -}}
{{- printf "%s:%s" .Values.image.repository (default .Chart.AppVersion .Values.image.tag) }}
{{- end }}

{{/*
Environment-specific resource name prefix.
Used to differentiate dev/staging/prod resources in shared clusters.
Usage: {{ include "myapp.envPrefix" . }}
*/}}
{{- define "myapp.envPrefix" -}}
{{- printf "%s-%s" (include "myapp.fullname" .) .Values.environment }}
{{- end }}

{{- define "myapp.configmapChecksum" -}}
{{ toYaml .Values.config | sha256sum }}
{{- end -}}

{{- define "myapp.secretChecksum" -}}
{{ toYaml .Values.secrets | sha256sum }}
{{- end -}}

{{/*
Notes header.
*/}}
{{- define "myapp.notes.header" -}}
myapp {{ .Chart.AppVersion }} deployed

Release     : {{ .Release.Name }}
Namespace   : {{ .Release.Namespace }}
Environment : {{ .Values.environment }}
{{- end }}

{{/*
Notes access URL section.
*/}}
{{- define "myapp.notes.access" -}}
{{- if .Values.ingress.enabled }}
Access URL:
{{- range .Values.ingress.hosts }}
  - http{{ if $.Values.ingress.tls }}s{{ end }}://{{ .host }}
{{- end }}

{{- else if eq .Values.service.type "NodePort" }}
Access URL:
  export NODE_IP=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[0].address}')
  export NODE_PORT=$(kubectl get svc {{ include "myapp.fullname" . }} -n {{ .Release.Namespace }} -o jsonpath='{.spec.ports[0].nodePort}')
  echo "URL: http://$NODE_IP:$NODE_PORT"

{{- else }}
Access URL:
  kubectl port-forward svc/{{ include "myapp.fullname" . }} 8080:{{ .Values.service.port }} -n {{ .Release.Namespace }}
  echo "URL: http://127.0.0.1:8080"
{{- end }}
{{- end }}

{{/*
Notes next steps.
*/}}
{{- define "myapp.notes.nextSteps" -}}
Next steps:
  1. Check rollout:
     kubectl rollout status deployment/{{ include "myapp.fullname" . }} -n {{ .Release.Namespace }}

  2. View logs:
     kubectl logs -l app.kubernetes.io/name={{ include "myapp.name" . }} -n {{ .Release.Namespace }} --tail=100

  3. Check pods:
     kubectl get pods -l app.kubernetes.io/name={{ include "myapp.name" . }} -n {{ .Release.Namespace }}
{{- end }}

{{/*
Notes PDB block.
*/}}
{{- define "myapp.notes.pdb" -}}
{{- if .Values.podDisruptionBudget.enabled }}
PodDisruptionBudget:
  Minimum {{ .Values.podDisruptionBudget.minAvailable }} pod(s) remain available during node drain operations.
{{- end }}
{{- end }}

{{/*
Notes autoscaling block.
*/}}
{{- define "myapp.notes.autoscaling" -}}
{{- if .Values.autoscaling.enabled }}
Autoscaling:
  Scales between {{ .Values.autoscaling.minReplicas }} and {{ .Values.autoscaling.maxReplicas }} replicas.
{{- end }}
{{- end }}

{{/*
Notes warning block.
*/}}
{{- define "myapp.notes.warning" -}}
{{- if not .Values.externalSecretName }}
Warning:
  Using chart-managed Secret. For production, set externalSecretName to use an externally managed secret.
{{- end }}
{{- end }}