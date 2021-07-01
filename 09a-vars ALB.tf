variable "app-type" {
  type = list(string)
  default = [ "app1", "principal", "app2"]
}

variable "app-routes" {
  type = list(string)
  default = [ "/app1/index.html", 
              "/",
              "/app2/index.html",
            ]
}

variable "app-simple-routes" {
  type = list(string)
  default = [ "/app1/", 
              "/",
              "/app2/",
            ]
}
