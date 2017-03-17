// Configure the Google Cloud provider
provider "google" {
  credentials = "${file("account.json")}"
  project     = "${var.project}"
  region      = "${var.region.["europa"]}"
}

// Create a new instance
resource "google_compute_instance" "maquina1" {
  name         = "test1"
  machine_type = "n1-standard-1"
  zone         = "europe-west1-c"

  tags = ["foo", "bar"]

  disk {
    image = "centos-7"
  }

  // Local SSD disk
  disk {
    type    = "local-ssd"
    scratch = true
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }

  metadata {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    scopes = ["userinfo-email", "compute-rw", "storage-rw"]
  }

  connection {
            type = "ssh"
            user = "charliwar"
            private_key = "${file("~/.ssh/google_compute_engine")}"
        }

   provisioner "file" {
        source = "script.sh"
        destination = "script.sh"
        
    }

    provisioner "remote-exec" {
        inline = [
          "chmod +x ~/script.sh",
          "cd ~",
          "./script.sh"
        ]

    }

}


output "address" {
  value = "${google_compute_instance.maquina1.name}"
}




resource "google_compute_instance" "maquina2" {
  name         = "test2"
  machine_type = "n1-standard-1"
  zone         = "europe-west1-c"
  depends_on = ["google_compute_instance.maquina1"]
  
  disk {
    image = "centos-7"
  }


  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }

  metadata {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    scopes = ["userinfo-email", "compute-rw", "storage-rw"]
  }
}