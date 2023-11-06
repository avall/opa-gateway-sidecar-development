{{- define "service.labels" -}}
helm_release: {{ .Release.Name }}
helm_chart_name: {{ .Chart.Name }}
helm_app_version: {{ .Chart.Version }}
domain: {{ .Values.app.domain }}
domain_app: {{ .Values.app.name }}
{{- end -}}

{{- define "opa.labels" -}}
helm_release: {{ .Release.Name }}
helm_chart_name: {{ .Chart.Name }}
helm_app_version: {{ .Chart.Version }}
domain: {{ .Values.app.domain }}
domain_app: {{ .Values.app.name }}
{{- end -}}
