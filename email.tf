resource "linode_domain_record" "mx1" {
  domain_id   = linode_domain.newport_solutions.id
  priority    = 10
  record_type = "MX"
  target      = "in1-smtp.messagingengine.com"
  ttl_sec     = 28800
}

resource "linode_domain_record" "mx2" {
  domain_id   = linode_domain.newport_solutions.id
  priority    = 20
  record_type = "MX"
  target      = "in2-smtp.messagingengine.com"
  ttl_sec     = 28800
}

resource "linode_domain_record" "spf" {
  domain_id   = linode_domain.newport_solutions.id
  record_type = "TXT"
  target      = "v=spf1 include:spf.messagingengine.com ?all"
  ttl_sec     = 28800
}

resource "linode_domain_record" "dkim_fm1" {
  domain_id   = linode_domain.newport_solutions.id
  name        = "fm1._domainkey"
  record_type = "CNAME"
  target      = "fm1.newport.solutions.dkim.fmhosted.com"
  ttl_sec     = 28800
}

resource "linode_domain_record" "dkim_fm2" {
  domain_id   = linode_domain.newport_solutions.id
  name        = "fm2._domainkey"
  record_type = "CNAME"
  target      = "fm2.newport.solutions.dkim.fmhosted.com"
  ttl_sec     = 28800
}

resource "linode_domain_record" "dkim_fm3" {
  domain_id   = linode_domain.newport_solutions.id
  name        = "fm3._domainkey"
  record_type = "CNAME"
  target      = "fm3.newport.solutions.dkim.fmhosted.com"
  ttl_sec     = 28800
}

resource "linode_domain_record" "dkim_mesmtp" {
  domain_id   = linode_domain.newport_solutions.id
  name        = "mesmtp._domainkey"
  record_type = "CNAME"
  target      = "mesmtp.newport.solutions.dkim.fmhosted.com"
  ttl_sec     = 28800
}

resource "linode_domain_record" "imap" {
  domain_id   = linode_domain.newport_solutions.id
  port        = 0
  priority    = 0
  protocol    = "tcp"
  record_type = "SRV"
  service     = "imap"
  target      = "."
  ttl_sec     = 28800
  weight      = 0
}

resource "linode_domain_record" "imaps" {
  domain_id   = linode_domain.newport_solutions.id
  port        = 993
  priority    = 0
  protocol    = "tcp"
  record_type = "SRV"
  service     = "imaps"
  target      = "imap.fastmail.com"
  ttl_sec     = 28800
  weight      = 1
}

resource "linode_domain_record" "jmap" {
  domain_id   = linode_domain.newport_solutions.id
  port        = 443
  priority    = 0
  protocol    = "tcp"
  record_type = "SRV"
  service     = "jmap"
  target      = "jmap.fastmail.com"
  ttl_sec     = 28800
  weight      = 1
}

resource "linode_domain_record" "pop3" {
  domain_id   = linode_domain.newport_solutions.id
  port        = 0
  priority    = 0
  protocol    = "tcp"
  record_type = "SRV"
  service     = "pop3"
  target      = "."
  ttl_sec     = 28800
  weight      = 0
}

resource "linode_domain_record" "pop3s" {
  domain_id   = linode_domain.newport_solutions.id
  port        = 995
  priority    = 10
  protocol    = "tcp"
  record_type = "SRV"
  service     = "pop3s"
  target      = "pop.fastmail.com"
  ttl_sec     = 28800
  weight      = 1
}

resource "linode_domain_record" "submission" {
  domain_id   = linode_domain.newport_solutions.id
  port        = 587
  priority    = 0
  protocol    = "tcp"
  record_type = "SRV"
  service     = "submission"
  target      = "smtp.fastmail.com"
  ttl_sec     = 28800
  weight      = 1
}

resource "linode_domain_record" "carddav" {
  domain_id   = linode_domain.newport_solutions.id
  port        = 0
  priority    = 0
  protocol    = "tcp"
  record_type = "SRV"
  service     = "carddav"
  target      = "."
  ttl_sec     = 28800
  weight      = 0
}

resource "linode_domain_record" "carddavs" {
  domain_id   = linode_domain.newport_solutions.id
  port        = 443
  priority    = 0
  protocol    = "tcp"
  record_type = "SRV"
  service     = "carddavs"
  target      = "carddav.fastmail.com"
  ttl_sec     = 28800
  weight      = 1
}

resource "linode_domain_record" "caldav" {
  domain_id   = linode_domain.newport_solutions.id
  port        = 0
  priority    = 0
  protocol    = "tcp"
  record_type = "SRV"
  service     = "caldav"
  target      = "."
  ttl_sec     = 28800
  weight      = 0
}

resource "linode_domain_record" "caldavs" {
  domain_id   = linode_domain.newport_solutions.id
  port        = 443
  priority    = 0
  protocol    = "tcp"
  record_type = "SRV"
  service     = "caldavs"
  target      = "caldav.fastmail.com"
  ttl_sec     = 28800
  weight      = 1
}
