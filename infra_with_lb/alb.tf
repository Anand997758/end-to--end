resource "aws_lb" "anand-test-alb" {
  name               = "anand-test-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = ["${aws_subnet.public_subnet1[0].id}", "${aws_subnet.public_subnet1[1].id}", "${aws_subnet.public_subnet1[2].id}"]

  #   enable_deletion_protection = true

  #   access_logs {
  #     bucket  = aws_s3_bucket.lb_logs.bucket
  #     prefix  = "test-lb"
  #     enabled = true
  #   }

  tags = {
    Environment = "anand-alb"
  }
}

resource "aws_lb_target_group" "anand-tg-jenkins" {
  name     = "tg-jenkins"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc1.id
}

resource "aws_lb_target_group_attachment" "anand-tg-attachment-jenkins" {
  target_group_arn = aws_lb_target_group.anand-tg-jenkins.arn
  target_id        = aws_instance.jeknins.id
  port             = 8080
}


resource "aws_lb_target_group" "anand-tg-tomcat" {
  name     = "tg-tomcat"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc1.id
}

resource "aws_lb_target_group_attachment" "anand-tg-attachment-tomcat" {
  target_group_arn = aws_lb_target_group.anand-tg-tomcat.arn
  target_id        = aws_instance.tomcat.id
  port             = 8080
}

resource "aws_lb_target_group" "anand-tg-apache" {
  name     = "tg-apache"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc1.id
}

resource "aws_lb_target_group_attachment" "anand-tg-attachment-apache" {
  target_group_arn = aws_lb_target_group.anand-tg-apache.arn
  target_id        = aws_instance.apache.id
  port             = 80
}

resource "aws_lb_target_group" "anand-tg-grafana" {
  name     = "tg-grafana"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc1.id
}

resource "aws_lb_target_group_attachment" "anand-tg-attachment-grafana" {
  target_group_arn = aws_lb_target_group.anand-tg-grafana.arn
  target_id        = aws_instance.grafana.id
  port             = 3000
}

resource "aws_lb_target_group" "anand-tg-prometheus" {
  name     = "tg-prometheus"
  port     = 9090
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc1.id
}

resource "aws_lb_target_group_attachment" "anand-tg-attachment-prometheus" {
  target_group_arn = aws_lb_target_group.anand-tg-prometheus.arn
  target_id        = aws_instance.prometheus.id
  port             = 9090
}


resource "aws_lb_target_group" "anand-tg-sonarqube" {
  name     = "tg-sonarqube"
  port     = 9000
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc1.id
}
resource "aws_lb_target_group_attachment" "anand-tg-attachment-sonarqube" {
  target_group_arn = aws_lb_target_group.anand-tg-sonarqube.arn
  target_id        = aws_instance.sonarqube.id
  port             = 9000
}

resource "aws_lb_target_group" "anand-tg-nexus" {
  name     = "tg-nexus"
  port     = 8081
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc1.id
}

resource "aws_lb_target_group_attachment" "anand-tg-attachment-nexus" {
  target_group_arn = aws_lb_target_group.anand-tg-nexus.arn
  target_id        = aws_instance.nexus.id
  port             = 8081
}


resource "aws_lb_target_group" "anand-tg-elk" {
  name     = "tg-elk"
  port     = 5601
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc1.id
}

resource "aws_lb_target_group_attachment" "anand-tg-attachment-elk" {
  target_group_arn = aws_lb_target_group.anand-tg-elk.arn
  target_id        = aws_instance.elk.id
  port             = 5601
}

resource "aws_lb_target_group" "anand-tg-node_exporter" {
  name     = "tg-node"
  port     = 9100
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc1.id
}

resource "aws_lb_target_group_attachment" "anand-tg-attachment-node_exporter" {
  target_group_arn = aws_lb_target_group.anand-tg-node_exporter.arn
  target_id        = aws_instance.node_exporter.id
  port             = 9100
}

resource "aws_lb_listener" "anand-alb-listener" {
  load_balancer_arn = aws_lb.anand-test-alb.arn
  port              = "80"
  protocol          = "HTTP"
  #   ssl_policy        = "ELBSecurityPolicy-2016-08"
  #   certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.anand-tg-jenkins.arn
  }
}

resource "aws_lb_listener_rule" "anand-jenkins-hostbased" {
  listener_arn = aws_lb_listener.anand-alb-listener.arn
  #   priority     = 99

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.anand-tg-jenkins.arn
  }

  condition {
    host_header {
      values = ["jenkins.anand.quest"]
    }
  }
}

resource "aws_lb_listener_rule" "anand-tomcat-hostbased" {
  listener_arn = aws_lb_listener.anand-alb-listener.arn
  #   priority     = 98

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.anand-tg-tomcat.arn
  }

  condition {
    host_header {
      values = ["tomcat.anand.quest"]
    }
  }
}

resource "aws_lb_listener_rule" "anand-apache-hostbased" {
  listener_arn = aws_lb_listener.anand-alb-listener.arn
  #   priority     = 98

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.anand-tg-apache.arn
  }

  condition {
    host_header {
      values = ["apache.anand.quest"]
    }
  }
}

resource "aws_lb_listener_rule" "anand-grafana-hostbased" {
  listener_arn = aws_lb_listener.anand-alb-listener.arn
  #   priority     = 98

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.anand-tg-grafana.arn
  }

  condition {
    host_header {
      values = ["grafana.anand.quest"]
    }
  }
}

resource "aws_lb_listener_rule" "anand-sonarqube-hostbased" {
  listener_arn = aws_lb_listener.anand-alb-listener.arn
  #   priority     = 98

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.anand-tg-sonarqube.arn
  }

  condition {
    host_header {
      values = ["sonarqube.anand.quest"]
    }
  }
}

resource "aws_lb_listener_rule" "anand-nexus-hostbased" {
  listener_arn = aws_lb_listener.anand-alb-listener.arn
  #   priority     = 99

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.anand-tg-nexus.arn
  }

  condition {
    host_header {
      values = ["nexus.anand.quest"]
    }
  }
}


resource "aws_lb_listener_rule" "anand-elk-hostbased" {
  listener_arn = aws_lb_listener.anand-alb-listener.arn
  #   priority     = 99

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.anand-tg-elk.arn
  }

  condition {
    host_header {
      values = ["elk.anand.quest"]
    }
  }
}

resource "aws_lb_listener_rule" "anand-node_exporter-hostbased" {
  listener_arn = aws_lb_listener.anand-alb-listener.arn
  #   priority     = 99

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.anand-tg-node_exporter.arn
  }

  condition {
    host_header {
      values = ["node_exporter.anand.quest"]
    }
  }
}

resource "aws_lb_listener_rule" "anand-prometheus-hostbased" {
  listener_arn = aws_lb_listener.anand-alb-listener.arn
  #   priority     = 99

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.anand-tg-prometheus.arn
  }

  condition {
    host_header {
      values = ["prometheus.anand.quest"]
    }
  }
}