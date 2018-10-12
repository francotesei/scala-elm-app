package services

import org.apache.hadoop.conf.Configuration

class Config extends Configuration{
  System.setProperty("HADOOP_USER_NAME", "root")
  this.set("fs.defaultFS", "hdfs://0.0.0.0:8020")
  this.set("hdfs.path","")
  this.set("local.path","/tmp/")
  this.set("file.key","file1")

}
