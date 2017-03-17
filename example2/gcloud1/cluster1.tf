provider "google" {
  credentials = "${file("${var.key_path}")}"
  project     = "${var.project}"
  region      = "${var.region}"
}

resource "google_compute_instance" "gcloud-cluster" {
    count = "${var.servers}"

    name = "gcloud1-${count.index}"
    zone = "${var.region_zone}"
    tags = ["${var.tag_name}"]

    machine_type = "${var.machine_type}"

    disk {
        image = "${var.machine_image["centos7"]}"
    }

    network_interface {
        network = "default"

        access_config {
            # Ephemeral
        }
    }

    service_account {
        scopes = ["https://www.googleapis.com/auth/compute.readonly"]
    }

    connection {
      user = "charliwar"
      private_key = "${file("~/.ssh/google_compute_engine")}"
    }

    provisioner "local-exec" {
        command = "echo ${google_compute_instance.gcloud-cluster.network_interface.0.access_config.0.assigned_nat_ip} >> private_ips.txt"


    }

    #provisioner "file" {
    #     source = "script.sh"
    #     destination = "script.sh"
    #}

    #provisioner "remote-exec" {
    #     inline = [
    #       "chmod +x ~/script.sh",
    #       "cd ~",
    #       "./script.sh"
    #     ]
    #}

    #provisioner "file" {
    #    source      = "${path.module}/nginx"
    #    destination = "/nginx"
    #}

}

resource "google_compute_firewall" "gcloud-firewall1" {
    name = "gcloud1-internal-access"
    network = "default"

    allow {
        protocol = "tcp"
        ports = [
            "8300", # Server RPC
            "8301", # Serf LAN
            "8302", # Serf WAN
            "8400", # RPC
        ]
    }

    source_tags = ["${var.tag_name}"]
    target_tags = ["${var.tag_name}"]
}
