variable "project" {
		default = "trek-treckr-161600"
		}
		
variable "region" {
  type = "map"
  default = {
    central = "us-central"
    europa = "europe-west1"
  }
}
