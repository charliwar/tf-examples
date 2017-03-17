provider "google" {
  credentials = "${file("${var.key_path}")}"
  project     = "${var.project}"
  region      = "${var.region}"
}

resource "google_compute_instance" "gcloud-cluster" {
    count = "${var.servers}"

    name = "gcloud2-${count.index}"
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
        user        = "${var.user}"
        private_key = "${file("${var.key_path}")}"
    }

   # provisioner "file" {
   #     source      = "${path.module}/../shared/scripts/${lookup(var.service_conf, var.platform)}"
   #     destination = "/tmp/${lookup(var.service_conf_dest, var.platform)}"
   # }

   # provisioner "remote-exec" {
   #     inline = [
   #         "echo ${var.servers} > /tmp/consul-server-count",
   #         "echo ${google_compute_instance.gcloud.0.network_interface.0.address} > /tmp/consul-server-addr",
   #     ]
   # }

   # provisioner "remote-exec" {
   #     scripts = [
   #         "${path.module}/../shared/scripts/install.sh",
   #         "${path.module}/../shared/scripts/service.sh",
   #         "${path.module}/../shared/scripts/ip_tables.sh",
   #     ]
   # }
}

resource "google_compute_firewall" "gcloud-firewall2" {
    name = "gcloud2-internal-access"
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