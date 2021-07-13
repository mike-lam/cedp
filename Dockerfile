FROM grafana/grafana
COPY grafana.ini /etc/grafana/grafana.ini
COPY datasources /etc/grafana/provisioning/datasources
COPY dashboards /etc/grafana/provisioning/dashboards
