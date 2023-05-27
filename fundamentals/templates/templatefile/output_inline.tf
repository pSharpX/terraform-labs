output "template_inline" {
    value = <<EOT
# we are going to try and make use of string, list, map and set
Here's the value for mystring: ${local.mystring}

Now try to use a list
%{ for i in local.mylist ~}
Here's a item: ${i}
%{ endfor }

Now let's try to use a map
%{ for key,value in local.mymap ~}
key [${key}], value [${value}]
%{ endfor }

what about set ?
%{ for s in local.myset ~}
Set element: ${s}
%{ endfor }
    EOT
}