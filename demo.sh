#/bin/bash
read -p "Hubble Metrics are available as soon you configure a L7 Cilium Network Policy"
kubectl get ciliumnetworkpolicy -n tenant-jobs -o yaml
read -p "Press [Enter] to increase the request volume by configuring crawler to generate more resumes and by running more than 1 replica of the crawler:"
helm upgrade jobs-app ./helm/jobs-app --namespace tenant-jobs --reuse-values -f helm/jobs-app-increased-request-rate.yaml
read -p "Check both loader and coreapi Destination Workloads and press [Enter] to continue"
read -p "Also check coreapi Destination Workload and check if request rate increase for coreapi"
read -p "Press [Enter] to deploy a new configuration of our app and use our metrics to see the change in the request error rate."
helm upgrade jobs-app ./helm/jobs-app --namespace tenant-jobs --reuse-values -f helm/jobs-app-increased-error-rate.yaml
read -p "Now we should see the error rate increase as a result of coreapi configuration changing."
read -p "Press [Enter] to deploy a new configuration of our app and use our metrics to see the change in the request duration."
helm upgrade jobs-app ./helm/jobs-app --namespace tenant-jobs --reuse-values -f helm/jobs-app-increased-request-duration.yaml
read -p "Check Grafana and check the request durations increase as a result of coreapi configuration changing."
read -p "If your application exports tracing headers, Hubble can be configured to extract these trace IDs from http headers and export them with the Hubble HTTP metrics as Exemplars which allow us to link from metrics to traces in Grafana."
read -p "The jobs-app has support for creating traces using OpenTelemetry."
read -p "Press [Enter] to deploy the jobs-app with tracing enabled."
helm upgrade jobs-app ./helm/jobs-app --namespace tenant-jobs --reuse-values -f helm/jobs-app-enable-tracing.yaml
read -p "Checkout Grafana. In the HTTP Request Duration by Source/Destination panels, we should see the exemplars showing up as dots alongside the line graph visualizations. Each one of these exemplars represents the duration of a single request and links to a trace ID."
read -p "In summary, by using Cilium's L7 network policies you can get insight into how your application is behaving without any changes to the application, and without any sidecars. Additionally, if your application already supports distributed tracing, Cilium enhances it by integrating traces with Hubble flows."
read -p "This concludes the demo."
