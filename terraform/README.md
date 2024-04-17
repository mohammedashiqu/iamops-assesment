# Betaflux

## Current terraform state file

```bash
.
└── terraform
    ├── child_modules
    │   ├── main.tf
    │   └── variable.tf
    ├── output.md
    ├── readme.md
    └── root
        ├── all-output.txt
        ├── main.tf
        ├── output.md
        ├── provider.tf
        ├── terraform.lock.hcl
        └── terraform.tfstate

4 directories, 10 files
~/De/devsecops-infra/c/(BTF)-BETAFLUX   main ⇣1 ❯
```

## Current Infra Looks

```python

AWS virtual network
- BTF-NYN-PRD-MUM-VPC-01
Introducing the VPC resource map

Subnets (9)
Subnets within this VPC
ap-south-1a
BTF-NYN-PRD-MUM-PUB-SUB-01
BTF-NYN-PRD-MUM-PVT-NAT-SUB-01
BTF-NYN-PRD-MUM-PVT-SUB-01
ap-south-1b
BTF-NYN-PRD-MUM-PUB-SUB-02
BTF-NYN-PRD-MUM-PVT-NAT-SUB-02
BTF-NYN-PRD-MUM-PVT-SUB-02
ap-south-1c
BTF-NYN-PRD-MUM-PUB-SUB-03
BTF-NYN-PRD-MUM-PVT-SUB-03
BTF-NYN-PRD-MUM-PVT-NAT-SUB-03

Route Tables (3)

BTF-NYN-PRD-MUM-PVR-NAT-01
BTF-NYN-PRD-MUM-PVT-ROU-01
rtb-0ea9d219e51e02223 (default route table - not in use)
BTF-NYN-PRD-MUM-PUB-ROU-01

Network Source (2)
BTF-NYN-PRD-MUM-IGW-01
BTF-NYN-PRD-MUM-NAT-01
