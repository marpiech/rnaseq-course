process ECHO {
  script: "echo Hello"
}

workflow {
  ECHO()
}
