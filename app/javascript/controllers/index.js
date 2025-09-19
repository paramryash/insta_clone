// app/javascript/controllers/index.js
import { Application } from "@hotwired/stimulus"
import CommentsController from "./comments_controller"

const application = Application.start()
application.register("comments", CommentsController)
