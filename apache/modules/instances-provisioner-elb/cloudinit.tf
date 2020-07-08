data "template_file" "script" {
  template = file(var.PATH_SCRIPT)
  vars = {
    VERSION = var.VERSION
  }
}

data "template_file" "config" {
  template = file(var.PATH_CONF/apache.cfg)
}

data "template_cloudinit_config" "config" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "apache.cfg"
    content_type = "text/cloud-config"
    content      = data.template_file.config.rendered
  }

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.script.rendered
  }
}
