env "local" {
  src = "file://schema.sql"
  url = "mysql://root:password@localhost:3307/joint_work"
  dev = "docker://mysql/8/dev"
}
