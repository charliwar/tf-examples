output "server_address" {
    value = "${google_compute_instance.gcloud-cluster.0.network_interface.0.address}"
}