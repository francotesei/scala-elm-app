package controllers

import javax.inject._
import play.api.mvc.{AnyContent, _}
import services.{Counter, FileManagerService}


@Singleton
class FileManagerController @Inject()(fileManager:FileManagerService)   extends InjectedController {

  def health(): Action[AnyContent] = Action {
    Ok("ok")
  }

  def uploadFile :Action[AnyContent] = Action {

    fileManager.upload()
    Ok("ok")

  }
  def downloadFile :Action[AnyContent] = Action {

    fileManager.download()
    Ok("ok")

  }
}