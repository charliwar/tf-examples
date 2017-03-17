variable "platform" {
    default = "ubuntu"
    description = "The OS Platform"
}

variable "user" {
    default = {
        ubuntu  = "ubuntu"
        rhel6   = "root"
        rhel7   = "root"
        centos6 = "root"
        centos7 = "root"
    }
}

variable "machine_image" {
  type = "map"
    default = {
        ubuntu  = "ubuntu-os-cloud/ubuntu-1404-trusty-v20160314"
        rhel6   = "rhel-cloud/rhel-6-v20160303"
        rhel7   = "rhel-cloud/rhel-7-v20160303"
        centos6 = "centos-cloud/centos-6-v20160301"
        centos7 = "centos-cloud/centos-7"
    }
}


variable "project" {
        default = "trek-treckr-161600"
        description = "Name of project in gcloud"

}

variable "key_path" {
    default = "account.json"
    description = "Path to the private key used to access the cloud servers"
}

variable "region" {
    default     = "europe-west1"
    description = "The region of Google Cloud where to launch the cluster"
}

variable "region_zone" {
    default     = "europe-west1-c"
    description = "The zone of Google Cloud in which to launch the cluster"
}

variable "servers" {
    default     = "3"
    description = "The number of gcloud servers to launch"
}

variable "machine_type" {
    default     = "f1-micro"
    description = "Google Cloud Compute machine type"
}

variable "tag_name" {
    default     = "gcloud1"
    description = "Name tag for the servers"
}