resource "aws_lb" "alb" {
    name        = "app-lb"
    internal    = false
    load_balancer_type  = "application"
    security_groups     = [aws_security_group.allow_tls.id] 
    subnets             = "${aws_subnet.pub-subnets[*].id}"
}

resource "aws_lb_target_group" "tg-groups" {
  count     = 3
  name      = "tg-group-${element(var.app-type, count.index)}"
  port      = 80
  protocol  = "HTTP"
  vpc_id    = "${aws_vpc.vpc.id}"

  health_check {
    enabled             = true
    interval            = 30
    path                = "${element(var.app-routes, count.index)}"
    port                = "traffic-port"
    protocol            = "HTTP"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 6
    matcher             = "200-399"
  }
}

resource "aws_lb_target_group_attachment" "tg-attach-app1" {
  count                 = "${length(var.priv-subnets)}"
  target_group_arn      = "${aws_lb_target_group.tg-groups[0].id}"
  target_id             = "${aws_instance.app1-instances[count.index].id}"
  port                  = 80
}

resource "aws_lb_target_group_attachment" "tg-attach-init" {
  count                 = "${length(var.priv-subnets)}"
  target_group_arn      = "${aws_lb_target_group.tg-groups[1].id}"
  target_id             = "${aws_instance.init-instances[count.index].id}"
  port                  = 80
}

resource "aws_lb_target_group_attachment" "tg-attach-app2" {
  count                 = "${length(var.priv-subnets)}"
  target_group_arn      = "${aws_lb_target_group.tg-groups[2].id}"
  target_id             = "${aws_instance.app2-instances[count.index].id}"
  port                  = 80
}

resource "aws_lb_listener" "apps-listener" {
  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"

    forward {
      target_group {
        arn = aws_lb_target_group.tg-groups[1].arn
      }
      stickiness {
        duration = 1
      }
    }
  }
}

resource "aws_lb_listener_rule" "app-rules" {
  count             = 3
  listener_arn      = "${aws_lb_listener.apps-listener.arn}"

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg-groups[count.index].arn
  }
  
  condition {
    path_pattern {
      values = ["${element(var.app-simple-routes, count.index)}"]
    }
  }
}
