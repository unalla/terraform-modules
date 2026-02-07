# Inside modules/database/main.tf
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}


# --- Database Security Group ---

resource "aws_security_group" "db_sg" {
  name        = "rds-private-sg"
  vpc_id      = var.vpc_id

  # Only allow MySQL/Postgres access from the App Security Group
  ingress {
    from_port       = 5432 # Change to 3306 if using MySQL
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.allowed_ingress_sg]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# --- DB Subnet Group (Required for Multi-AZ) ---

resource "aws_db_subnet_group" "main" {
  name       = "main-db-subnet-group"
  subnet_ids = var.db_subnets

  tags = {
    Name = "Main DB Subnet Group"
  }
}

# --- RDS Instance ---

resource "aws_db_instance" "postgres" {
  allocated_storage      = 20
  db_name                = "myappdb"
  engine                 = "postgres"
  engine_version         = "15.3"
  instance_class         = "db.t3.micro"
  username               = "dbadmin"
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  
  # RESILIENCY: Enables synchronous standby in another AZ
  multi_az               = true
  
  # Backup & Maintenance
  backup_retention_period = 7
  skip_final_snapshot     = true
  
  tags = {
    Name = "Resilient-Postgres"
  }
}