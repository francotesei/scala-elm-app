package services

import javax.inject._
import org.apache.hadoop.fs.{FileSystem, Path}

import scala.concurrent.ExecutionContext


@Singleton
 class HdfsManager @Inject()(conf:Config)  {


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
class FileManagerService @Inject()(hdfsManager: HdfsManager) (implicit ec: ExecutionContext){

  def saveToHdfs(path: String, data: Array[Byte] ) =
    hdfsManager.write( path, data)

  def saveToLocal(path: String, data: Array[Byte] ) =
    hdfsManager.write( path, data)



  def download() =
    hdfsManager.read("test.txt","/home/ftesei/Documentos/testhdfs.txt")




}
