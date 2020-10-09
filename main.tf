provider "google" {
 credentials = file("~/Documentos/terraform-tcc/terraform-cloud-282518-a832d5d911bb.json")
 project     = "terraform-cloud-282518"
 region      = "us-east4-c"
}

resource "google_compute_instance" "ece-04" {
 name         = "elastictcc-01"
 machine_type = "n1-standard-2"
 zone         = "us-east4-a"
 hostname     = "elastictcc-01.srv"

 boot_disk {
   initialize_params {
     image = "centos-cloud/centos-7"
     size  = "30"
   }
 }

 network_interface {
   network    = "default"
   network_ip = "10.150.0.20"
   access_config {
   
   }
 }
 metadata = {
   ssh-keys = "luisfilho:${file("/home/luisfilho/.ssh/id_rsa.pub")}"
 }
}

resource "google_compute_instance" "ece-05" {
 name         = "elastictcc-02"
 machine_type = "n1-standard-2"
 zone         = "us-east4-b"
 hostname     = "elastictcc-02.srv"

 boot_disk {
   initialize_params {
     image = "centos-cloud/centos-7"
     size  = "30"
   }
 }

 network_interface {
   network    = "default"
   network_ip = "10.150.0.21"
   access_config {     
   }
 }
 metadata = {
   ssh-keys = "luisfilho:${file("/home/luisfilho/.ssh/id_rsa.pub")}"
 }
}

resource "google_compute_instance" "ece-06" {
 name         = "elastictcc-03"
 machine_type = "n1-standard-2"
 zone         = "us-east4-c"
 hostname     = "elastictcc-03.srv"

 boot_disk {
   initialize_params {
     image = "centos-cloud/centos-7"
     size  = "30"
   }
 }

 network_interface {
   network    = "default"
   network_ip = "10.150.0.22"
   access_config {     
   }
 }
 metadata = {
   ssh-keys = "luisfilho:${file("/home/luisfilho/.ssh/id_rsa.pub")}"
 }
}

resource "null_resource" "hosts" {
 triggers = {
   anything1 = google_compute_instance.ece-04.network_interface.0.access_config.0.nat_ip
   anything2 = google_compute_instance.ece-05.network_interface.0.access_config.0.nat_ip
   anything3 = google_compute_instance.ece-06.network_interface.0.access_config.0.nat_ip
 }
 provisioner "remote-exec" {
   connection {
     type = "ssh"
     user = "luisfilho"
     host = google_compute_instance.ece-04.network_interface.0.access_config.0.nat_ip
     private_key = file("/home/luisfilho/.ssh/id_rsa")
   }
   inline = [
     "echo OK",

   ]
 }
 provisioner "remote-exec" {
   connection {
     type = "ssh"
     user = "luisfilho"
     host = google_compute_instance.ece-05.network_interface.0.access_config.0.nat_ip
     private_key = file("/home/luisfilho/.ssh/id_rsa")
   }
   inline = [
     "echo OK",
   ]
 }
 provisioner "remote-exec" {
   connection {
     type = "ssh"
     user = "luisfilho"
     host = google_compute_instance.ece-06.network_interface.0.access_config.0.nat_ip
     private_key = file("/home/luisfilho/.ssh/id_rsa")
   }
   inline = [
     "echo OK",
   ]
 }
 provisioner "remote-exec" {
   connection {
     type = "ssh"
     user = "luisfilho"
     host = "34.73.132.108"
     private_key = file("/home/luisfilho/.ssh/id_rsa")
   }   
   inline = [
     "cd /home/luisfilho/elastic-terraform/ansible",
     "ansible-playbook -i hosts elastic.yml",
     
   ]
 }
}
