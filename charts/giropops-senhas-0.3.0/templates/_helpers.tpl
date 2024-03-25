{{/* 
Criar as nossas tags
*/}}

{{- define "app.labels" -}}
app: {{ .labels.app | quote }}
env: {{ .labels.env | default "notenv" | quote }}
live: {{ .labels.live | default "false" | quote }}
{{- end }}

{{/* 
Definir limites de recursos
*/}}

{{- define "app.resources" -}}
requests:
    memory: {{ .resources.requests.memory}}
    cpu: {{ .resources.requests.cpu}}
limits:
    memory: {{ .resources.limits.memory}}
    cpu: {{ .resources.limits.cpu}}
{{- end }}

{{/* 
Definir as portas do containers
*/}}

{{- define "app.ports" -}}
{{ range .ports }}
- containerPort: {{ .port }}
{{- end }}
{{- end }}


{{/* 
Definir os nossos configmaps
*/}}

{{- define "db.configmaps" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .component }}-db-config
data:
  app-config.yaml: |
    {{- toYaml .config | nindent 4 }}
{{- end }}


{{- define "obs.configmaps" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .component }}-observavility-config
data:
  app-config.json: |
    {{ toJson .config }}
{{- end }}