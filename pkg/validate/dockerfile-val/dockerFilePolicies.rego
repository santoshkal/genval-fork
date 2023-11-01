package dockerfile_validation

# default check_base_image = "is a not a trusted base image. We reccomend using Chainguard images"

check_base_image[msg] {
    input[i].cmd == "from"
    val := split(input[i].value, "/")
    val[0] != "cgr.dev"
    msg := sprintf("*** %s is a not a trusted base image. We reccomend using Chainguard images", [val[0]])
    
}

check_base_image[msg] {
    input[j].cmd == "from"
    val := split(input[j].value, "/")
    val[0] == "cgr.dev"
    msg := sprintf("--- %s is a trusted image", [val[0]])
}


# # Do not use root user
deny_root_user[msg] {
    input[i].cmd == "user"
    val2:= input[i].value
    val2 != "root"
    val2 != "0"
    msg:= ("Image uses non root user") 
}

deny_root_user[msg] {
    input[i].cmd == "user"
    val2:= input[i].value
    val2 == "root"
    val2 == "0"
    msg:= ("Image usesing root discouraged, validation failed") 
}

# # Do not sudo
deny_sudo[msg]{
    input[i].cmd == "run"
    val3:= input[i].value
    not contains(val3, "sudo")
    msg:= sprintf("Image does not use sudo in RUN instruction",[])
}

deny_sudo[msg]{
    input[i].cmd == "run"
    val3:= input[i].value
    # contains does not work with string. use some... in for check
    contains(val3, "sudo")
    msg:= sprintf("Using sudo in RUN declaritive is prohibited",[])
}

# # Avoid using cached layers CIS 4.7
# deny_caching{
#     input[i].cmd == "run"
#     val4:= input[i].value
#     matches := regex.match(".*?(apk|yum|dnf|apt|pip).+?(install|[dist-|check-|group]?up[grade|date]).*", val4)
#     matches == true
#     contains(val4, "--no-cache")
# }	

# # Ensure that COPY is used instead of ADD CIS 4.9
# deny_add{
#     input[i].cmd != "add"
# }

# # Ensure ADD does not include unpack archives or download files 
# # deny_image_expansion{
# # 	input[_].cmd == "add"
# # 	val5 := input[_].value
# # 	words := regex.match(".*?(curl|wget|.tar|.tar.).*", val5)
# # 	words != true
# # }