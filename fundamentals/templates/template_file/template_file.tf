# Render and test template using template_file datasource
# Template_file datasource does not support list, map, set. It only supports primitive types
data "template_file" "test" {
    template = file("test.tmpl")
    vars = {
        mystring = local.mystring
        mylist = join(",", local.mylist)
        mapkeys = join(",", keys(local.mymap))
        mapvalues = join(",", values(local.mymap))
        myset = join(",", local.myset)
    }  
}