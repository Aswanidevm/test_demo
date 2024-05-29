module "ec2" {
    source ="ec2 instance"
    for_each = var.instances
    component =  each.value["name"]
    instance_type = lookup(each.value, "instance_type", "t2.micro" )

}

variable instances{
    default = {
        frontend = {
             instance_type = "t3.micro"
             name = "frontend"
        }

        mongodb = {
             instance_type = "t3.micro"
              name = "mongodb"
        }

        

    }
}