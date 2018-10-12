package services


import javax.inject._
import org.apache.hadoop.conf.Configuration
import org.apache.hadoop.fs.{FileSystem, Path}


case class myConf() extends Configuration {
  System.setProperty("HADOOP_USER_NAME", "root")
  this.set("fs.defaultFS", "hdfs://0.0.0.0:8020")
}

@Singleton
 class HdfsManager @Inject()(conf:myConf)  {


  def write(filePath: String, data: Array[Byte]) = {
    val path = new Path(filePath)
    val fs = FileSystem.get(conf)
    val os = fs.create(path)
    os.write(data)
    fs.close()
  }

  def read(hdfsPath: String,localPath:String): Unit ={
    val fs = FileSystem.get(conf)
    fs.copyToLocalFile(new Path(hdfsPath),new Path(localPath))
  }
}



@Singleton
class FileManagerService @Inject()(hdfsManager: HdfsManager) {

  def upload(path: String, data: Array[Byte] ) = {

    hdfsManager.write( path, data)

  }
  def download() = hdfsManager.read("test.txt","/home/ftesei/Documentos/testhdfs.txt")
}
