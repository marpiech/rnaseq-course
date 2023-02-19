files = Channel.fromPath("../../../filtered/*.fastq.gz")

process ECHO {
  container "ubuntu:22.04"
  script: "echo Hello"
}

process HEAD {
  publishDir "head"
  container "ubuntu:22.04  "
  input:
    path fq
  output:
    path "${fq}.head"
  script:
  """
    zcat ${fq} | head -4 > "${fq}.head"
  """
}

process QCHECK {
  publishDir "qc"
  container "biocontainers/fastqc:v0.11.9_cv8"
  input:
    path fq
  output:
    path "${fq.getSimpleName()}_fastqc.zip" 
  script:
  """
    fastqc ${fq}
    echo "----"
    ls ${fq}
    ls *.zip
    echo ${fq.getSimpleName()}
    ls ${fq.getSimpleName()}_fastqc.zip
  """
}

workflow {
//  ECHO()
//  HEAD(fq = files)
  QCHECK(fq = files)
}
