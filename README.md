Building a resilient, three-tier architecture in Terraform is less about writing one giant file and more about building a Lego set. By using modules, you ensure that your networking, logic, and data layers are isolated, reusable, and easy to maintain.

1. The Networking Module (The Foundation)
    To be resilient, you must deploy across at least two Availability Zones (AZs).

    VPC: Your isolated network.

    Public Subnets: For your Application Load Balancer (ALB).

    Private Subnets: For your API and Database (never expose these to the raw internet).

    NAT Gateway: Allows private instances to download updates without being reachable from the outside.

2. The Compute Module (Web & API)
    For the Web and API layers, we use Auto Scaling Groups (ASG). If a server dies or traffic spikes, the infrastructure heals itself.

    Load Balancer (ALB): Routes traffic to the Web layer.

    Web Layer: A fleet of instances in private subnets.

    Internal ALB: (Optional but recommended) Sits between the Web and API layers to balance internal requests.

    API Layer: Another fleet of instances behind the internal load balancer.

3. The Database Module (The Data)
    Resiliency here means Multi-AZ deployment.

    Primary Instance: Handles reads/writes.

    Standby Instance: A synchronous replica in a different AZ. If the primary fails, the standby takes over automatically.

    Security Groups: Strictly configured to only allow traffic from the API layer's security group.