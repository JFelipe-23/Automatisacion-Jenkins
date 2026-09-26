provider "local" {}

#1. Simular la creacion de un servidor (como si fuera EC2 AWS)

resource "local_file" "servidor_produccion" {
	content = "Servidor_Rocky 10 - IP:192.168.1.66"
	filename = "${path.module}/servidor_simulado.txt"
}

#2. PUENTE DE CCONEXION T A, crear el host.ini para ansible
resource "local_file" "generar_inventario_ansible" {
	content = <<EOF
[produccion]
localhost ansible_conecction=local

[produccion:vars]
entorno=produccion_critica
EOF
	filename = "../ansible/host.ini"
#Obligando a terraform a crear el servidor PRIMERO
depends_on = [local_file.servidor_produccion]
}
