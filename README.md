# Infraestructura Modular en AWS con Terraform

Infraestructura como Código (IaC) modular para desplegar una aplicación web de **tres capas** en AWS usando Terraform:

- **Red** (`modules/vpc`): VPC con subred pública y dos subredes privadas en zonas de disponibilidad distintas.
- **Cómputo** (`modules/compute`): Instancia EC2 (Amazon Linux 2023) con Apache instalado automáticamente mediante *User Data*.
- **Base de datos** (`modules/database`): RDS MySQL en la subred privada, accesible únicamente desde el Security Group del servidor web.

## Arquitectura

```text
[ AWS Cloud (us-east-1) ]
 └── VPC: 10.0.0.0/16  (modules/vpc)
      ├── Subred Pública: 10.0.1.0/24
      │    └── EC2: Servidor Web (modules/compute)  → Puerto 80 abierto
      │          - Security Group: trafico HTTP entrante
      │          - User Data: instala y arranca Apache
      │
      └── Subredes Privadas: 10.0.2.0/24 y 10.0.3.0/24 (AZs distintas)
           └── RDS MySQL (modules/database)
                 - Solo recibe conexiones del Security Group web (puerto 3306)
```

## Estructura del proyecto

```text
.
├── main.tf               # Orquestador de módulos
├── variables.tf          # Variables globales
├── outputs.tf            # Valores de salida (IP web, endpoint RDS)
├── versions.tf           # Versiones de Terraform y provider AWS
├── dev.tfvars.example    # Variables de ejemplo para desarrollo
├── prod.tfvars.example   # Variables de ejemplo para producción
└── modules/
    ├── vpc/              # VPC, subredes, IGW y ruteo
    ├── compute/          # EC2 + Security Group + User Data
    └── database/         # RDS MySQL + DB Subnet Group + Security Group
```

## Requisitos previos

- [Terraform](https://developer.hashicorp.com/terraform/install) `>= 1.5`
- Cuenta de AWS con credenciales configuradas (ej. variable `AWS_ACCESS_KEY_ID` / `AWS_SECRET_ACCESS_KEY`, o `aws configure`)

## Uso

```bash
# 1. Prepara tus variables (copia el ejemplo y rellena con tus valores)
cp dev.tfvars.example dev.tfvars

# 2. Inicializa los módulos y descarga el provider
terraform init

# 3. Previsualiza los cambios
terraform plan -var-file="dev.tfvars"

# 4. Despliega la infraestructura
terraform apply -var-file="dev.tfvars"

# 5. Al terminar te muestra las salidas:
#    - web_public_ip     → abre esta IP en el navegador para ver la página
#    - database_endpoint → endpoint privado de MySQL

# 6. Para eliminar todo y evitar costos
terraform destroy -var-file="dev.tfvars"
```

## Seguridad

- Los archivos `*.tfvars` están en `.gitignore`: **nunca** subas contraseñas ni secretos al repositorio.
- La contraseña de la base de datos está marcada como `sensitive` y no se muestra en pantalla.
- La base de datos solo acepta conexiones provenientes del Security Group del servidor web (nada de IPs vagas).

## Entornos

Se soporta múltiples entornos mediante archivos de variables:

- **Desarrollo:** `terraform apply -var-file="dev.tfvars"`
- **Producción:** `terraform apply -var-file="prod.tfvars"`