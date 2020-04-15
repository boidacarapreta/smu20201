variable "gcp_sakey" {}
variable "gce_project" {}
variable "gce_region" {}
variable "gce_zone" {}
variable "gce_ssh_user" {}
variable "gce_ssh_pub_key" {}

// https://www.terraform.io/docs/providers/google/index.html
provider "google" {
  credentials = file(var.gcp_sakey)
  project     = var.gce_project
  region      = var.gce_region
}

// https://www.terraform.io/docs/providers/google/r/compute_firewall.html
resource "google_compute_firewall" "smu-0" {
  name        = "smu-0"
  network     = "default"
  target_tags = ["smu", "sip", "stun", "voip"]

  allow {
    protocol = "udp"
    ports    = ["3478", "5060"]
  }

  allow {
    protocol = "tcp"
    ports    = ["3478", "5060"]
  }
}

// https://www.terraform.io/docs/providers/google/d/datasource_compute_address.html
resource "google_compute_address" "smu-0" {
  name = "smu-0"
}

// https://www.terraform.io/docs/providers/google/d/datasource_compute_instance.html
resource "google_compute_instance" "smu-0" {
  name         = "smu-0"
  machine_type = "g1-small"
  zone         = var.gce_zone
  tags         = ["smu", "sip", "stun", "voip"]

  // http://apt.opensips.org/packages.php?v=2.4
  metadata_startup_script = "sudo apt update; sudo apt -y install tcpdump dirmngr; sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 049AD65B; echo 'deb http://apt.opensips.org stretch 2.4-releases' | sudo tee -a /etc/apt/sources.list.d/opensips.list > /dev/null; sudo apt update; sudo apt -y install opensips coturn"


  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  metadata = {
    ssh-keys = "${var.gce_ssh_user}:${var.gce_ssh_pub_key}"
  }

  network_interface {
    network = "default"

    access_config {
      nat_ip = google_compute_address.smu-0.address
    }
  }
}

output "ip" {
  value = google_compute_instance.smu-0.network_interface.0.access_config.0.nat_ip
}
