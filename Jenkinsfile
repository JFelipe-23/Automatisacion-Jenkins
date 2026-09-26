pipeline {
    agent any

    stages {
        stage('1. Auditoria de Código (Linting)') {
            steps {
                echo 'Validando Sintaxis de Terraform y Ansible...'
                dir('terraform') {
                    sh 'terraform init -backend=false'
                    sh 'terraform validate'
                }
                dir('ansible') {
                    sh 'ansible-playbook --syntax-check playbook.yml'
                }
            }
        }
        stage('2. Planificación (Terraform Plan)') {
            steps {
                echo 'Generating Terraform plan...'
                dir('terraform') {
                    sh 'terraform plan'
                }
            }
        }
        stage('3. Aprobación (Gatekeeper)') {
            steps {
                input message: 'El Terraform plan ha sido generado. ¿Desea continuar con la implementación?', ok: 'Si, deploy!'
            }
        }
        stage('4. Aprovisionamiento (Terraform Apply)') {
            steps {
                echo 'Applying Terraform changes...'
                dir('terraform') {
                    sh 'terraform apply -auto-approve'
                }
            }
        }
        stage('5. Configuración (Ansible Playbook)') {
            steps {
                echo 'Running Ansible playbook...'
                dir('ansible') {
                    echo 'Eperando a que se levante la instancia para ejecutar el playbook...'
                    sleep 5
                    sh 'ansible-playbook -i hosts.ini playbook.yml'
                }
            }
        }
    }
}