data "template_file" "script" {
  template = file(var.PATH_SCRIPT)
  vars = {
    VERSION = var.VERSION
  }
}

data "template_cloudinit_config" "config" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.script.rendered
  }
}
