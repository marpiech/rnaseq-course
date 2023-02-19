files = Channel.fromPath("../../../filtered/*.fastq.gz")

process HEAD {
  publishDir "head"
  input:
    path fq
  output:
    path "${fq}.head"
  script:
  """
    zcat "${fq}" | head -4 > "${fq}.head"
  """
}

workflow {
  HEAD(fq = files)
}
